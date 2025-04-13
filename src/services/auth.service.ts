import pool from '../config/db';
import bcrypt from 'bcrypt';
import jwt, { SignOptions } from 'jsonwebtoken';

const jwtSecret = process.env.JWT_SECRET!;
const jwtExpiresIn: SignOptions['expiresIn'] = (process.env.JWT_EXPIRES_IN as SignOptions['expiresIn']) || '1d';

// ===============================
// Register New User
// ===============================
export async function registerUser(user: {
  userName: string;
  userEmail: string;
  password: string;
  phoneNumber: string;
  role?: 'admin' | 'delegate';
  citizenId?: number;
}) {
  const hashedPassword = await bcrypt.hash(user.password, 12);

  const sql = `
    INSERT INTO system_users (
      user_name,
      user_email,
      password,
      phone_number,
      role,
      citizen_id
    )
    VALUES ($1, $2, $3, $4, $5, $6)
    RETURNING user_id
  `;

  const values = [
    user.userName,
    user.userEmail,
    hashedPassword,
    user.phoneNumber,
    user.role || 'delegate', // default to 'delegate'
    user.citizenId || null
  ];

  const result = await pool.query(sql, values);
  return result.rows[0].user_id;
}

// ===============================
// Login Existing User
// ===============================
export async function loginUser(email: string, password: string) {
  const sql = `SELECT * FROM system_users WHERE user_email = $1`;
  const result = await pool.query(sql, [email]);
  const user = result.rows[0];

  if (!user || !(await bcrypt.compare(password, user.password))) {
    throw new Error('Invalid email or password');
  }

  const payload = {
    userId: user.user_id,
    role: user.role,
    email: user.user_email
  };

  const token = jwt.sign(payload, jwtSecret, {
    expiresIn: jwtExpiresIn
  });

  return {
    token,
    user: {
      userId: user.user_id,
      userName: user.user_name,
      role: user.role
    }
  };
}
