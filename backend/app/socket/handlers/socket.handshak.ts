import { verifyToken } from "../../../modules/auth/jwt.js";

export const socketHandshakeHandler = (socket: any, next: any) => {
    try {
        const token = socket.handshak.auth.token;

        if(!token){
            return next(new Error("Authentication error: No token provided"));
        }
        const user = verifyToken(token);
        if (!user) {
            return next(new Error("Authentication error: Invalid token"));
        }
        
        socket.user = user;
        next();
        
    } catch (error) {
        next(new Error("Authentication error: " + (error instanceof Error ? error.message : "Unknown error")));
    }
}