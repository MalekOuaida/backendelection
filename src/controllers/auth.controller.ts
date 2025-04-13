import { RequestHandler } from 'express';
import * as authService from '../services/auth.service';

export const registerUserController: RequestHandler = async (req, res, next) => {
  try {
    const id = await authService.registerUser(req.body);
    res.status(201).json({ userId: id, message: 'User registered successfully' });
  } catch (err) {
    next(err);
  }
};

export const loginUserController: RequestHandler = async (req, res, next) => {
  try {
    const { token, user } = await authService.loginUser(req.body.email, req.body.password);
    res.json({ token, user });
  } catch (err) {
    res.status(401).json({ error: 'Invalid credentials' });
  }
};
