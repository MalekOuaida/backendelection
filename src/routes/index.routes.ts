import { Router } from 'express';

import citizensRouter from './citizens.routes';
import citizenAttribRouter from './citizenAttrib.routes';
import locationRouter from './location.routes';
import systemUsersRouter from './systemUsers.routes';
import votePreferenceRouter from './votePreference.routes';
import electionDataRouter from './electionData.routes';
import listsRouter from './lists.routes';
import mukhtarRouter from './mukhtar.routes';
import citizensServicesRouter from './citizensServices.routes';
import relativesRouter from './relatives.routes';
import volunteerRouter from './volunteer.routes';
import volunteerAssignmentRouter from './volunteerAssignment.routes';
import referencesRouter from './references.routes';
import authRouter from './auth.routes'



const router = Router();

router.use('/citizens', citizensRouter);
router.use('/citizen-attrib', citizenAttribRouter);
router.use('/location', locationRouter);
router.use('/references', referencesRouter);
router.use('/users', systemUsersRouter);
router.use('/vote-preference', votePreferenceRouter);
router.use('/election-data', electionDataRouter);
router.use('/lists', listsRouter);
router.use('/mukhtar', mukhtarRouter);
router.use('/citizen-services', citizensServicesRouter);
router.use('/relatives', relativesRouter);
router.use('/volunteers', volunteerRouter);
router.use('/volunteer-assignments', volunteerAssignmentRouter);
router.use('/auth', authRouter);

router.use((req, res) => {
  res.status(404).json({ error: 'Not found' });
});

export default router;
