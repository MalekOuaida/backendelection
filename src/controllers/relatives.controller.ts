import { Response, NextFunction } from 'express';
import * as relativesService from '../services/relatives.service';
import { AuthenticatedRequest } from '../types/express';
import { logAudit } from '../utils/auditLogger';

export const createRelativeController = async (
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
) => {
  try {
    const newId = await relativesService.createRelative(req.body);


    if (req.user) {
      await logAudit({
        table: 'relatives_details',
        action: 'CREATE',
        recordId: newId,
        userId: req.user.userId,
        newData: req.body
      });
    }

    res.status(201).json({ relativeId: newId, message: 'Relative added successfully' });
  } catch (err) {
    res.status(400).json({
      error: 'Invalid relative input',
      details: (err as Error).message
    });
  }
};


export const getRelativesByCitizenController = async (
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
) => {
  try {
    const relatives = await relativesService.getRelativesByCitizenId(Number(req.params.citizenId));
    res.json(relatives);
  } catch (err) {
    next(err);
  }
};
