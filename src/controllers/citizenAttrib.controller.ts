import { Response, NextFunction } from 'express';
import {
  createCitizenAttrib,
  updateCitizenAttrib,
  getCitizenAttribByCitizenId,
  getCitizenAttribByAttribId,
  deleteCitizenAttrib
} from '../services/citizenAttrib.service';
import { AuthenticatedRequest } from '../types/express';
import { logAudit } from '../utils/auditLogger';

// CREATE
export const createCitizenAttribController = async (
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
) => {
  try {
    const newId = await createCitizenAttrib(req.body);

    await logAudit({
      table: 'citizen_attrib',
      action: 'CREATE',
      recordId: newId,
      userId: req.user?.userId!,
      newData: req.body
    });

    res.status(201).json({ id: newId, message: 'Citizen Attrib created' });
  } catch (err) {
    next(err);
  }
};

// GET by citizens_gov_id
export const getCitizenAttribByCitizenController = async (
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
) => {
  try {
    const citizenId = Number(req.params.citizenId);
    const result = await getCitizenAttribByCitizenId(citizenId);
    if (!result) {
      return res.status(404).json({ error: 'No attributes found for this citizen' });
    }
    res.json(result);
  } catch (err) {
    next(err);
  }
};

// UPDATE by citizen_attrib_id
export const updateCitizenAttribController = async (
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
) => {
  try {
    const attribId = Number(req.params.attribId);
    const oldData = await getCitizenAttribByAttribId(attribId);
    if (!oldData) return res.status(404).json({ error: 'Not found' });

    const updated = await updateCitizenAttrib(attribId, req.body);
    if (!updated) return res.status(400).json({ error: 'No fields updated' });

    await logAudit({
      table: 'citizen_attrib',
      action: 'UPDATE',
      recordId: attribId,
      userId: req.user?.userId!,
      oldData,
      newData: req.body
    });

    res.json({ message: 'Updated', data: updated });
  } catch (err) {
    next(err);
  }
};

// DELETE
export const deleteCitizenAttribController = async (
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
) => {
  try {
    const attribId = Number(req.params.attribId);
    const oldData = await getCitizenAttribByAttribId(attribId);
    if (!oldData) return res.status(404).json({ error: 'Not found' });

    await deleteCitizenAttrib(attribId);

    await logAudit({
      table: 'citizen_attrib',
      action: 'DELETE',
      recordId: attribId,
      userId: req.user?.userId!,
      oldData
    });

    res.json({ message: 'Deleted successfully' });
  } catch (err) {
    next(err);
  }
};
