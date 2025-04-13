import { Router } from 'express';
import {
  createListController,
  getAllListsController,
  createCandidateController,
  getCandidatesByListController
} from '../controllers/lists.controller';

const listsRouter = Router();

listsRouter.post('/', createListController);

listsRouter.get('/', getAllListsController);

listsRouter.post('/:listId/candidates', createCandidateController);

listsRouter.get('/:listId/candidates', getCandidatesByListController);

export default listsRouter;
