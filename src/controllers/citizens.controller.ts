import { RequestHandler, Request, Response, NextFunction } from 'express';
import * as citizensService from '../services/citizens.service';
import { logAudit } from '../utils/auditLogger';
import { AuthenticatedRequest } from '../types/express'; // Make sure this is defined properly

// CREATE
export const createCitizenController: RequestHandler = async (
  req: AuthenticatedRequest,
  res,
  next
) => {
  try {
    const newId = await citizensService.createCitizen(req.body);

    await logAudit({
      table: 'citizens_gov',
      action: 'CREATE',
      recordId: newId,
      userId: req.user?.userId!,
      newData: req.body,
    });

    res.status(201).json({ id: newId, message: 'Citizen created' });
  } catch (err) {
    next(err);
  }
};

// READ ALL
export const getAllCitizensController: RequestHandler = async (req, res, next) => {
  try {
    const allCitizens = await citizensService.getAllCitizens();
    res.json(allCitizens);
  } catch (err) {
    next(err);
  }
};

// READ ONE
export const getCitizenByIdController: RequestHandler = async (req, res, next) => {
  try {
    const citizenId = Number(req.params.id);
    const foundCitizen = await citizensService.getCitizenById(citizenId);
    if (!foundCitizen) {
      res.status(404).json({ error: 'Citizen not found' });
      return;
    }
    res.json(foundCitizen);
  } catch (err) {
    next(err);
  }
};

// UPDATE
export const updateCitizenController: RequestHandler = async (
  req: AuthenticatedRequest,
  res,
  next
) => {
  try {
    const citizenId = Number(req.params.id);
    const oldData = await citizensService.getCitizenById(citizenId);

    const updatedCitizen = await citizensService.updateCitizen(citizenId, req.body);
    if (!updatedCitizen) {
      res.status(404).json({ error: 'No update or not found' });
      return;
    }

    await logAudit({
      table: 'citizens_gov',
      action: 'UPDATE',
      recordId: citizenId,
      userId: req.user?.userId!,
      oldData,
      newData: req.body,
    });

    res.json({ message: 'Citizen updated', data: updatedCitizen });
  } catch (err) {
    next(err);
  }
};

// DELETE
export const deleteCitizenController: RequestHandler = async (
  req: AuthenticatedRequest,
  res,
  next
) => {
  try {
    const citizenId = Number(req.params.id);
    const oldData = await citizensService.getCitizenById(citizenId);

    await citizensService.deleteCitizen(citizenId);

    await logAudit({
      table: 'citizens_gov',
      action: 'DELETE',
      recordId: citizenId,
      userId: req.user?.userId!,
      oldData,
    });

    res.json({ message: 'Citizen deleted' });
  } catch (err) {
    next(err);
  }
};

// SEARCH
export const searchCitizensController: RequestHandler = async (req, res, next) => {
  try {
    const filters = {
      firstName: req.query.firstName as string | undefined,
      lastName: req.query.lastName as string | undefined,
      regNumber: req.query.regNumber as string | undefined,
      municipalityName: req.query.municipalityName as string | undefined,
      districtName: req.query.districtName as string | undefined,
      governorateName: req.query.governorateName as string | undefined,
    };
    const results = await citizensService.searchCitizens(filters);
    res.json(results);
  } catch (err) {
    next(err);
  }
};

// FULL PROFILE
export const getFullCitizenByIdController: RequestHandler = async (req, res, next) => {
  try {
    const citizenId = Number(req.params.id);
    const fullData = await citizensService.getFullCitizenById(citizenId);

    if (!fullData) {
      res.status(404).json({ error: 'Citizen not found' });
      return;
    }

    res.json(fullData);
  } catch (err) {
    next(err);
  }
};
