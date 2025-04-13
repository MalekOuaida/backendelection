import { Request, Response, NextFunction } from 'express';
import * as userService from '../services/systemUsers.service';

interface AuthenticatedRequest extends Request {
  user?: {
    userId: number;
    email: string;
    role: 'admin' | 'delegate';
    citizenId?: number | null;
  };
}

// CREATE user
export const createUserController = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
  try {
    const newId = await userService.createSystemUser(req.body);
    res.status(201).json({ userId: newId });
  } catch (err) {
    next(err);
  }
};

// LOGIN
export const loginController = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
  try {
    const { userEmail, password } = req.body;
    const user = await userService.authenticateUser(userEmail, password);
    if (!user) {
      res.status(401).json({ error: 'Invalid credentials' });
      return;
    }
    res.json({ message: 'Login success', user });
  } catch (err) {
    next(err);
  }
};

// GET user by ID
export const getUserByIdController = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
  try {
    const userId = parseInt(req.params.id);
    if (isNaN(userId)) {
      res.status(400).json({ error: 'Invalid ID' });
      return;
    }

    const user = await userService.getUserById(userId);
    if (!user) {
      res.status(404).json({ error: 'User not found' });
      return;
    }

    res.json(user);
  } catch (err) {
    next(err);
  }
};

// UPDATE user
export const updateUserController = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
  try {
    const userId = parseInt(req.params.id);
    if (isNaN(userId)) {
      res.status(400).json({ error: 'Invalid ID' });
      return;
    }

    const updated = await userService.updateSystemUser(userId, req.body);
    if (!updated) {
      res.status(404).json({ error: 'No update or not found' });
      return;
    }

    res.json({ message: 'User updated', data: updated });
  } catch (err) {
    next(err);
  }
};

// DELETE user
export const deleteUserController = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
  try {
    const userId = parseInt(req.params.id);
    if (isNaN(userId)) {
      res.status(400).json({ error: 'Invalid ID' });
      return;
    }

    await userService.deleteSystemUser(userId);
    res.json({ message: 'User deleted' });
  } catch (err) {
    next(err);
  }
};

// GET /me
export const getMeController = (req: AuthenticatedRequest, res: Response): void => {
  if (!req.user) {
    res.status(401).json({ message: 'Not authenticated' });
    return;
  }

  res.json({
    userId: req.user.userId,
    email: req.user.email,
    role: req.user.role,
    citizenId: req.user.citizenId || null
  });
};

// GET /all
export const getAllUsersController = async (_req: Request, res: Response, next: NextFunction): Promise<void> => {
  try {
    const users = await userService.getAllUsers();
    res.json(users);
  } catch (err) {
    next(err);
  }
};

// PATCH /:id/promote
export const promoteUserController = async (req: Request, res: Response, next: NextFunction): Promise<void> => {
  try {
    const userId = parseInt(req.params.id);
    if (isNaN(userId)) {
      res.status(400).json({ error: 'Invalid user ID' });
      return;
    }

    const updated = await userService.promoteUserToAdmin(userId);
    if (!updated) {
      res.status(404).json({ message: 'User not found or promotion failed' });
      return;
    }

    res.json({
      message: 'User promoted to admin',
      user: {
        userId: updated.user_id,
        userName: updated.user_name,
        userEmail: updated.user_email,
        role: updated.role
      }
    });
  } catch (err) {
    next(err);
  }
};
