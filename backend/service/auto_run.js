import cron from "node-cron";
import { messageRetention } from "../utils/message_retention";

cron.schedule("0 3 * * *", messageRetention);
