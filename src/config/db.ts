import { Pool } from "pg";
import dotenv from "dotenv";

dotenv.config();

const pool = new Pool({
    host: process.env.DB_HOST,
    port: Number(process.env.DB_PORT),
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
});

pool.connect()
    .then(() => console.log("✅ PostgreSQL Database connected successfully"))
    .catch(err => console.error("❌ Database connection error", err));

export default pool;
