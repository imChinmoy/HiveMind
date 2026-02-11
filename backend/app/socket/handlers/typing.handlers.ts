export const typingHandlers = (io: any, socket: any) => {
  socket.on("typing:start", (channelId: string) => {
    try {
      socket.to(channelId).emit("typing:start", {
        userId: socket.user.id,
        username: socket.user.username,
      });
    } catch (error) {
      socket.emit("error", {
        error: error instanceof Error ? error.message : "Unknown error",
      });
    }
  });

  socket.on("typing:stop", (channelId: string) => {
    try {
      socket.to(channelId).emit("typing:stop", {
        userId: socket.user.id,
        username: socket.user.username,
      });
    } catch (error) {
      socket.emit("error", {
        error: error instanceof Error ? error.message : "Unknown error",
      });
    }
  });
};
