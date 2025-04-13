import { Request } from 'express';

export interface DecodedUser {
  userId: number;
  email: string;
  role: 'admin' | 'delegate';
  citizenId?: number | null;
}

export interface RequestWithUser extends Request {
  user?: DecodedUser;
}
