import { Router } from 'express';
import {
  upsertVolunteerController,
  getVolunteerByCitizenController
} from '../controllers/volunteer.controller';

import { authenticateToken, authorizeRoles } from '../middlewares/authMiddleware';

const router = Router();

router.post(
  '/',
  authenticateToken,
  authorizeRoles('admin', 'delegate'),
  upsertVolunteerController
);

router.get(
  '/:citizenId',
  authenticateToken,
  authorizeRoles('admin', 'delegate'),
  getVolunteerByCitizenController
);

export default router;
