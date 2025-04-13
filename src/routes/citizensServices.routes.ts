import { Router } from 'express';
import {
  createCitizenServiceController,
  getServicesByCitizenController
} from '../controllers/citizensServices.controller';

import { authenticateToken, authorizeRoles } from '../middlewares/authMiddleware';

const router = Router();

// ✅ Admin + Delegate can create a service
router.post(
  '/',
  authenticateToken,
  authorizeRoles('admin', 'delegate'),
  createCitizenServiceController
);

// ✅ Admin + Delegate can fetch services for a citizen
router.get(
  '/:citizenId',
  authenticateToken,
  authorizeRoles('admin', 'delegate'),
  getServicesByCitizenController
);

export default router;
