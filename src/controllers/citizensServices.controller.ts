import { Response, NextFunction } from 'express';
import { AuthenticatedRequest } from '../types/express';
import * as service from '../services/citizensServices.service';
import { logAudit } from '../utils/auditLogger';

// CREATE service for citizen or relative
export const createCitizenServiceController = async (
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
) => {
  try {
    const newServiceId = await service.createCitizenService(req.body);

    if (req.user) {
      await logAudit({
        table: 'citizens_services',
        action: 'CREATE',
        recordId: newServiceId,
        userId: req.user.userId,
        newData: req.body
      });
    }

    res.status(201).json({
      serviceId: newServiceId,
      message: 'Service created successfully'
    });
  } catch (err) {
    next(err);
  }
};

// GET all services for a citizen
export const getServicesByCitizenController = async (
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
) => {
  try {
    const citizenId = Number(req.params.citizenId);
    const services = await service.getServicesByCitizenId(citizenId);
    res.json(services);
  } catch (err) {
    next(err);
  }
};
