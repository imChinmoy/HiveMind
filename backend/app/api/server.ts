import { connectPostgres } from "../../core/db/postgres.js";
import { app } from "./app.js";
import { config } from "../../core/config/index.js";

const startServer = async () => {
  await connectPostgres();


  app.listen(config.PORT, () => {
    console.log(`Server is running on port ${config.PORT}`);
  });
};

startServer();
