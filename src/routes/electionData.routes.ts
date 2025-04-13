import { Router } from 'express';
import {
  createElectionYearController,
  getAllElectionYearsController,
  createElectionTypeController,
  getAllElectionTypesController,
  createElectionDistrictController,
  getAllElectionDistrictsController
} from '../controllers/electionData.controller';

const router = Router();

// Election Year
router.post('/year', createElectionYearController);
router.get('/year', getAllElectionYearsController);

// Election Type
router.post('/type', createElectionTypeController);
router.get('/type', getAllElectionTypesController);

// Election District
router.post('/district', createElectionDistrictController);
router.get('/district', getAllElectionDistrictsController);

export default router;
