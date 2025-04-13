import { Router } from 'express';
import {
  createAssignmentController,
  getAssignmentsByVolunteerController
} from '../controllers/volunteerAssignment.controller';

import { authenticateToken, authorizeRoles } from '../middlewares/authMiddleware';

const router = Router();

router.post(
  '/',
  authenticateToken,
  authorizeRoles('admin', 'delegate'),
  createAssignmentController
);

router.get(
  '/:volunteerId',
  authenticateToken,
  authorizeRoles('admin', 'delegate'),
  getAssignmentsByVolunteerController
);

export default router;
