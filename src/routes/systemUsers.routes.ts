import { Router } from 'express';
import {
  createUserController,
  loginController,
  getUserByIdController,
  updateUserController,
  deleteUserController
} from '../controllers/systemUsers.controller';

import { authenticateToken, authorizeRoles } from '../middlewares/authMiddleware';

const systemUsersRouter = Router();

systemUsersRouter.post(
  '/',
  authenticateToken,
  authorizeRoles('admin'),
  createUserController
);

systemUsersRouter.post('/login', loginController);

systemUsersRouter.get(
  '/:id',
  authenticateToken,
  authorizeRoles('admin'),
  getUserByIdController
);

systemUsersRouter.patch(
  '/:id',
  authenticateToken,
  authorizeRoles('admin'),
  updateUserController
);

systemUsersRouter.delete(
  '/:id',
  authenticateToken,
  authorizeRoles('admin'),
  deleteUserController
);

export default systemUsersRouter;
