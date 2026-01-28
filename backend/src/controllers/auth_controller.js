import { validateEmail } from "../../utils/validation.js";
import bcrypt from 'bcrypt';
import { db } from "../database/db.js";
import { users } from "../database/schema.js";
import { eq } from "drizzle-orm";
import jwt from 'jsonwebtoken';

export const loginController = async (req, res) => {
    try {
        const { username, password } = req.body;

        if (!username || !password) {
            return res
                .status(400)
                .json({ message: "Username and password are required." });
        }

        const [user] = await db
            .select()
            .from(users)
            .where(eq(users.username, username));

        if (!user) {
            return res.status(401).json({ message: "Invalid credentials." });
        }

        const passwordMatch = await bcrypt.compare(password, user.password);

        if (!passwordMatch) {
            return res.status(401).json({ message: "Invalid credentials. Wrong Password!!" });
        }

        const token = generateToken(user);

        return res.status(200).json({
            message: "Login successful.",
            user: {
                id: user.id,
                username: user.username,
                email: user.email,
            },
            token,
        });
    } catch (error) {
        console.error("Login error:", error);
        return res.status(500).json({ message: "Internal server error." });
    }
};



export const signupController = async (req, res) => {
    try {
        const { username, password, email, age } = req.body;

        if (!username || !password || !email || !age) {
            return res.status(400).json({ message: "All fields are required." });
        }

        if (age < 13) {
            return res
                .status(400)
                .json({ message: "You must be at least 13 years old." });
        }

        if (!validateEmail(email)) {
            return res.status(400).json({ message: "Invalid email format." });
        }

        const existingEmail = await db
            .select()
            .from(users)
            .where(eq(users.email, email));

        if (existingEmail.length > 0) {
            return res.status(400).json({ message: "Email already in use." });
        }

        const existingUsername = await db
            .select()
            .from(users)
            .where(eq(users.username, username));

        if (existingUsername.length > 0) {
            return res.status(400).json({ message: "Username already taken." });
        }

        const hashedPassword = await bcrypt.hash(password, 10);

        const [newUser] = await db
            .insert(users)
            .values({
                username,
                email,
                password: hashedPassword,
                age,
            })
            .returning();

        const token = generateToken(newUser);

        return res.status(201).json({
            message: "User registered successfully.",
            user: {
                id: newUser.id,
                username: newUser.username,
                email: newUser.email,
            },
            token,
        });
    } catch (error) {
        console.error("Signup error:", error);
        return res.status(500).json({ message: "Internal server error." });
    }
};

const generateToken = (user) => {
    return jwt.sign(
        {
            userId: user.id,
            email: user.email,
            username: user.username,
        },
        process.env.JWT_SECRET,
        { expiresIn: "30d" }
    );
};
