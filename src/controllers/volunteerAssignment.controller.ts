import { Response, NextFunction } from 'express';
import { AuthenticatedRequest } from '../types/express';
import * as assignmentService from '../services/volunteerAssignment.service';
import { logAudit } from '../utils/auditLogger';

export const createAssignmentController = async (
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
) => {
  try {
    const assignmentId = await assignmentService.createAssignment(req.body);

    if (req.user) {
      await logAudit({
        table: 'volunteer_assignments',
        action: 'CREATE',
        recordId: assignmentId,
        userId: req.user.userId,
        newData: req.body
      });
    }

    res.status(201).json({
      assignmentId,
      message: 'Assignment created successfully'
    });
  } catch (err) {
    next(err);
  }
};

export const getAssignmentsByVolunteerController = async (
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
) => {
  try {
    const volunteerId = Number(req.params.volunteerId);
    const assignments = await assignmentService.getAssignmentsByVolunteerId(volunteerId);
    res.json(assignments);
  } catch (err) {
    next(err);
  }
};
