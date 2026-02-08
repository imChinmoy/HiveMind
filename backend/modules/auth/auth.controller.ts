import { Request, Response } from "express";
import { loginService, registerService } from "./auth.service.js";
import { loginSchema, registerSchema } from "./auth.schema.js";
import { id } from "zod/locales";

export const register = async (req: Request, res: Response) => {
  try {
    const { username, email, password, dob } = req.body;
    const safeData = registerSchema.parse({ username, email, password, dob });
    const data = await registerService(safeData);
    res.status(201).json({
      message: "User registered successfully",
    });
  } catch (error: any) {
    res.status(400).json({ message: error.message });
  }
}

export const login = async (req: Request, res: Response) => {
  try {
    const { email, password } = req.body;

    const safeData = loginSchema.parse({ email, password });
    const data = await loginService(safeData);

    res.json({
      message: "Login successful",
      accesstoken: data.accessToken,
      user: {
        email: data.user.email,
        username: data.user.username,
        id: data.user.id
      },
      refreshToken: data.refreshToken,
    });
  } catch (error) {
    res.status(400).json({ message: (error as Error).message });
  }
}
