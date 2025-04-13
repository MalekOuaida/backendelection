import { RequestHandler } from 'express';
import * as service from '../services/electionData.service';

// ======= YEAR =======
export const createElectionYearController: RequestHandler = async (req, res, next) => {
  try {
    const id = await service.createElectionYear(req.body.year);
    res.status(201).json({ id, message: 'Election year created' });
  } catch (err) {
    next(err);
  }
};

export const getAllElectionYearsController: RequestHandler = async (req, res, next) => {
  try {
    const years = await service.getAllElectionYears();
    res.json(years);
  } catch (err) {
    next(err);
  }
};

// ======= TYPE =======
export const createElectionTypeController: RequestHandler = async (req, res, next) => {
  try {
    const id = await service.createElectionType(req.body.typeName);
    res.status(201).json({ id, message: 'Election type created' });
  } catch (err) {
    next(err);
  }
};

export const getAllElectionTypesController: RequestHandler = async (req, res, next) => {
  try {
    const types = await service.getAllElectionTypes();
    res.json(types);
  } catch (err) {
    next(err);
  }
};

// ======= DISTRICT =======
export const createElectionDistrictController: RequestHandler = async (req, res, next) => {
  try {
    const id = await service.createElectionDistrict(req.body.districtName);
    res.status(201).json({ id, message: 'Election district created' });
  } catch (err) {
    next(err);
  }
};

export const getAllElectionDistrictsController: RequestHandler = async (req, res, next) => {
  try {
    const districts = await service.getAllElectionDistricts();
    res.json(districts);
  } catch (err) {
    next(err);
  }
};
