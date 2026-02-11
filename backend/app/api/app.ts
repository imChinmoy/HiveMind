import express from "express";
import cors from "cors";
import healthRoute from "./routes/health.route.js";
import authRoutes from "./routes/auth.route.js";
import serverRoutes from "./routes/server.route.js";
import channelRoutes from "./routes/channel.route.js";
import messageRoutes from "./routes/message.route.js";

export const app = express();

app.use(cors());
app.use(express.json());

app.use("/health", healthRoute);
app.use("/auth", authRoutes);
app.use("/servers", serverRoutes);
app.use("/channels", channelRoutes);
app.use("/message",messageRoutes);