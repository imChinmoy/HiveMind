import { Request, Response } from "express";
import { loginService, registerService } from "./auth.service.js";

export const register = async (req: Request, res: Response) => {
  try {
    const { username, email, password, dob } = req.body;

    const user = await registerService({
      email,
      username,
      password,
      dob,
    });
    res.json({
      message: "User registered successfully",
      user: {
        email,
        username,
      },
    });
  } catch (error: any) {
    res.status(400).json({ message: error.message });
  }
}

export const login = async (req: Request, res: Response) => {
  try {
    const { email, password } = req.body;

    const data = await loginService({ email, password });

    res.json({
      message: "Login successful",
      accesstoken: data.accessToken,
      user: {
        email: data.user.email,
        username: data.user.username,
      },
      refreshToken: data.refreshToken,
    });
  } catch (error) {
    res.status(400).json({ message: (error as Error).message });
  }
}
