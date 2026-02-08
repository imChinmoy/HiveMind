import { Router } from "express";
import { login, register } from "../../../modules/auth/auth.controller.js";
import { arcjetMiddleware } from "../../../middlewares/arcjet.middleware.js";

const router = Router();

router.post("/register", arcjetMiddleware, register);
router.post("/login", arcjetMiddleware, login);

export default router;
