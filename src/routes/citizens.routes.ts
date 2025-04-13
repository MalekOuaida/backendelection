import { Router } from 'express';
import {
  createCitizenController,
  getCitizenByIdController,
  updateCitizenController,
  deleteCitizenController,
  searchCitizensController,
  getAllCitizensController,
  getFullCitizenByIdController
} from '../controllers/citizens.controller';

import { authenticateToken, authorizeRoles } from '../middlewares/authMiddleware';

const citizensRouter = Router();

// ✅ Only admin can create a new citizen
citizensRouter.post(
  '/',
  authenticateToken,
  authorizeRoles('admin'),
  createCitizenController
);

// ✅ Admin + delegate can read all citizens
citizensRouter.get(
  '/',
  authenticateToken,
  authorizeRoles('admin', 'delegate'),
  getAllCitizensController
);

// ✅ Admin + delegate can read a specific citizen
citizensRouter.get(
  '/:id',
  authenticateToken,
  authorizeRoles('admin', 'delegate'),
  getCitizenByIdController
);

// ✅ Admin + delegate can update citizen
citizensRouter.patch(
  '/:id',
  authenticateToken,
  authorizeRoles('admin', 'delegate'),
  updateCitizenController
);

// ❌ Only admin can delete citizen
citizensRouter.delete(
  '/:id',
  authenticateToken,
  authorizeRoles('admin'),
  deleteCitizenController
);

// ✅ Admin + delegate can search citizens
citizensRouter.get(
  '/search/filter',
  authenticateToken,
  authorizeRoles('admin', 'delegate'),
  searchCitizensController
);

// ✅ Admin + delegate can read full citizen details
citizensRouter.get(
  '/full/:id',
  authenticateToken,
  authorizeRoles('admin', 'delegate'),
  getFullCitizenByIdController
);

export default citizensRouter;
