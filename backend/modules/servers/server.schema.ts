import { z } from 'zod';

export const createServerSchema = z.object({
    name: z.string().min(3).max(50),
    avatar: z.string().optional(),
    userId: z.string(),
})
