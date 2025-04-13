import { Request } from 'express';

export interface AuthenticatedUser {
  userId: number;
  role: 'admin' | 'delegate';
  email: string;
  citizenId?: number;
}

export interface AuthenticatedRequest extends Request {
  user?: AuthenticatedUser;
}
