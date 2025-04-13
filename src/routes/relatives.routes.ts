import { Router } from 'express';
import {
  createRelativeController,
  getRelativesByCitizenController
} from '../controllers/relatives.controller';

import { authenticateToken, authorizeRoles } from '../middlewares/authMiddleware';

const router = Router();

router.post(
  '/',
  authenticateToken,
  authorizeRoles('admin', 'delegate'),
  createRelativeController
);

router.get(
  '/:citizenId',
  authenticateToken,
  authorizeRoles('admin', 'delegate'),
  getRelativesByCitizenController
);

export default router;
