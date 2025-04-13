import { Router } from 'express';
import {
  getAllBloodTypesController,
  createBloodTypeController,
  getAllMaritalStatusesController,
  createMaritalStatusController,
  getAllEducationLevelsController,
  createEducationLevelController,
  getAllSupportStatusesController,
  createSupportStatusController
} from '../controllers/references.controller';

const router = Router();

router.get('/blood-type', getAllBloodTypesController);
router.post('/blood-type', createBloodTypeController);

router.get('/marital-status', getAllMaritalStatusesController);
router.post('/marital-status', createMaritalStatusController);

router.get('/education-level', getAllEducationLevelsController);
router.post('/education-level', createEducationLevelController);

router.get('/support-status', getAllSupportStatusesController);
router.post('/support-status', createSupportStatusController);

export default router;
