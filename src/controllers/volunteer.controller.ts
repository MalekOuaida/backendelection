// volunteer.controller.ts
import { Response, NextFunction } from 'express';
import * as volunteerService from '../services/volunteer.service';
import { AuthenticatedRequest } from '../types/express';
import { logAudit } from '../utils/auditLogger';

export const upsertVolunteerController = async (
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
) => {
  try {
    const { oldVolunteer, newVolunteerId } = await volunteerService.upsertVolunteer(req.body);

    if (req.user) {
      await logAudit({
        table: 'volunteers',
        action: oldVolunteer ? 'UPDATE' : 'CREATE',
        recordId: newVolunteerId,
        userId: req.user.userId,
        oldData: oldVolunteer || null,
        newData: req.body
      });
    }

    res.status(200).json({
      volunteerId: newVolunteerId,
      message: 'Volunteer info saved successfully'
    });
  } catch (err) {
    next(err);
  }
};

export const getVolunteerByCitizenController = async (
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
) => {
  try {
    const citizenId = Number(req.params.citizenId);
    const volunteer = await volunteerService.getVolunteerByCitizenId(citizenId);
    res.json(volunteer);
  } catch (err) {
    next(err);
  }
};
