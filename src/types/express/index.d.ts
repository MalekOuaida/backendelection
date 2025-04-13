import { Request } from 'express';

export interface DecodedUser {
  userId: number;
  email: string;
  role: 'admin' | 'delegate';
  citizenId?: number;
}

export interface AuthenticatedRequest extends Request {
  user?: DecodedUser;
}