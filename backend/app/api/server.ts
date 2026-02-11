import { connectPostgres } from "../../core/db/postgres.js";
import { config } from "../../core/config/index.js";
import server from "../socket/index.js";

const startServer = async () => {
  await connectPostgres();


  server.listen(config.PORT, () => {
    console.log(`Server is running on port ${config.PORT}`);
  });
};

startServer();
