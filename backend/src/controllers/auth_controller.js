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
            return res.status(400).json({ message: 'Username and password are required.' });
        }

        const user = await db.select().from(users).where(eq(users.username, username)).then(users => users[0]);

        if (!user) {
            return res.status(401).json({ message: 'Invalid username or password.' });
        }

        const passwordMatch = await bcrypt.compare(password, user.password);
        if (!passwordMatch) {
            return res.status(401).json({ message: 'Invalid username or password.' });
        }

        const token = generateToken(user);

        return res.status(200).json({ message: 'Login successful.', userId: user.id, token: token });



    } catch (error) {
        console.error('Error during login:', error);
        return res.status(500).json({ message: 'Internal server error.' });
    }


}

export const signupController = async (req, res) => {
    try {
        const { username, password, email, age } = req.body;

        if (!username || !password || !email || !age) {
            return res.status(400).json({ message: 'All fields are required.' });
        }

        if (age < 13) {
            return res.status(400).json({ message: 'You must be at least 13 years old to register.' });
        }

        if (!validateEmail(email)) {
            return res.status(400).json({ message: 'Invalid email format.' });
        }

        const hashedPassword = await bcrypt.hash(password, 10);

        await db.select().from(users).where(eq(users.email, email)).then(existingUser => {
            if (existingUser.length > 0) {
                return res.status(400).json({ message: 'Email already in use.' });
            }
        });

        await db.select().from(users).where(eq(users.username, username)).then(existingUser => {
            if (existingUser.length > 0) {
                return res.status(400).json({ message: 'Username already taken.' });
            }
        });

        const newUser = await db.insert(users).values({
            username,
            email,
            password: hashedPassword,
            age
        })
        const token = generateToken(newUser);
        return res.status(201).json({ message: 'User registered successfully.', userId: newUser.id, token: token });

    } catch (error) {
        console.error('Error during signup:', error);
        return res.status(500).json({ message: 'Internal server error.' });
    }
}


const generateToken = (user) => {
    const payload = {
        email: user.email,
        username: user.username,
        age: user.age,
    };

    return jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: '30d' });
};