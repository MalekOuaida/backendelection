import { Router } from 'express';
import {
  registerUserController,
  loginUserController
} from '../controllers/auth.controller';

import { authenticateToken, authorizeRoles } from '../middlewares/authMiddleware';

const router = Router();

// ✅ Only authenticated admins can create users
router.post(
  '/signup',
  authenticateToken,
  authorizeRoles('admin'),
  registerUserController
);

// ✅ Login remains public
router.post('/login', loginUserController);

export default router;
