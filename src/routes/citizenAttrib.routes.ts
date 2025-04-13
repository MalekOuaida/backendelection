import { Router } from 'express';
import {
  createCitizenAttribController,
  getCitizenAttribByCitizenController,
  updateCitizenAttribController
} from '../controllers/citizenAttrib.controller';

import { authenticateToken, authorizeRoles } from '../middlewares/authMiddleware';

const router = Router();

// ✅ Admin + Delegate can create attributes
router.post(
  '/',
  authenticateToken,
  authorizeRoles('admin', 'delegate'),
  createCitizenAttribController
);

// ✅ Admin + Delegate can view citizen attribute by citizen ID
router.get(
  '/:citizenId',
  authenticateToken,
  authorizeRoles('admin', 'delegate'),
  getCitizenAttribByCitizenController
);

// ✅ Admin + Delegate can update attribute
router.patch(
  '/:attribId',
  authenticateToken,
  authorizeRoles('admin', 'delegate'),
  updateCitizenAttribController
);

export default router;
