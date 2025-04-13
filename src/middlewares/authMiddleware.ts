import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';

const jwtSecret = process.env.JWT_SECRET!;

export interface DecodedUser {
  userId: number;
  role: 'admin' | 'delegate';
  email: string;
  citizenId?: number;
}


export function authenticateToken(
  req: Request & { user?: DecodedUser },
  res: Response,
  next: NextFunction
): void {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];

  if (!token) {
    res.status(401).json({ message: 'Missing token' });
    return;
  }

  try {
    const decoded = jwt.verify(token, jwtSecret) as DecodedUser;
    req.user = decoded;
    next();
  } catch (err) {
    res.status(403).json({ message: 'Invalid or expired token' });
  }
}

export function authorizeRoles(
  ...allowedRoles: Array<'admin' | 'delegate'>
) {
  return (
    req: Request & { user?: DecodedUser },
    res: Response,
    next: NextFunction
  ): void => {
    if (!req.user) {
      res.status(401).json({ message: 'Not authenticated' });
      return;
    }

    if (!allowedRoles.includes(req.user.role)) {
      res.status(403).json({ message: 'Forbidden: Insufficient role' });
      return;
    }

    next();
  };
}
