import { aj } from "../core/arcjet/arcjet.js";
import { Request, Response, NextFunction } from "express";
export async function arcjetMiddleware(
  req: Request,
  res: Response,
  next: NextFunction,
) {
  const decision = await aj.protect(req);

  if (decision.isDenied()) {
    return res.status(429).json({ error: "Blocked by security policy" });
  }

  next();
}
