import { sendMessageService } from "../../../modules/message/message.service.js";

export const messageHandlers = (io: any, socket: any) => {
  socket.on("join:channel", async (channelId: string) => {
    try {
      socket.join(channelId);
    } catch (error) {
      socket.emit("error", {
        error: error instanceof Error ? error.message : "Unknown error",
      });
    }
  });

  socket.on("send:message", async (data: any) => {
    try {
      const { channelId, content } = data;

      const payload = await sendMessageService(
        channelId,
        socket.user.id,
        content,
      );

      io.to(channelId).emit("new:message", payload);
    } catch (error) {
      socket.emit("error", {
        error: error instanceof Error ? error.message : "Unknown error",
      });
    }
  });
};
