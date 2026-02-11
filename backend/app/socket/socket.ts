import { messageHandlers } from "./handlers/message.handlers.js";
import { socketHandshakeHandler } from "./handlers/socket.handshak.js";
import { typingHandlers } from "./handlers/typing.handlers.js";

export const socketRegisterHandlers = (io: any) => {
    io.use(socketHandshakeHandler);
    
    io.on("connection", (socket: any)=> {
        console.log(`User connected: ${socket.user.username}`);

        messageHandlers(io, socket);
        typingHandlers(io, socket);

        socket.on("disconnect", () => {
            console.log(`User disconnected: ${socket.user.username}`);
        });
    })
}