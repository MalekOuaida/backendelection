import { RequestHandler } from 'express';
import * as refService from '../services/references.service';

// ========== BLOOD TYPE ==========
export const getAllBloodTypesController: RequestHandler = async (req, res, next) => {
  try {
    const rows = await refService.getAllBloodTypes();
    res.json(rows);
  } catch (err) {
    next(err);
  }
};

export const createBloodTypeController: RequestHandler = async (req, res, next) => {
  try {
    const id = await refService.createBloodType(req.body.name);
    res.status(201).json({ id, message: 'Blood type created' });
  } catch (err) {
    next(err);
  }
};

// ========== MARITAL STATUS ==========
export const getAllMaritalStatusesController: RequestHandler = async (req, res, next) => {
  try {
    const rows = await refService.getAllMaritalStatuses();
    res.json(rows);
  } catch (err) {
    next(err);
  }
};

export const createMaritalStatusController: RequestHandler = async (req, res, next) => {
  try {
    const id = await refService.createMaritalStatus(req.body.name);
    res.status(201).json({ id, message: 'Marital status created' });
  } catch (err) {
    next(err);
  }
};

// ========== EDUCATION LEVEL ==========
export const getAllEducationLevelsController: RequestHandler = async (req, res, next) => {
  try {
    const rows = await refService.getAllEducationLevels();
    res.json(rows);
  } catch (err) {
    next(err);
  }
};

export const createEducationLevelController: RequestHandler = async (req, res, next) => {
  try {
    const id = await refService.createEducationLevel(req.body.name);
    res.status(201).json({ id, message: 'Education level created' });
  } catch (err) {
    next(err);
  }
};

// ========== SUPPORT STATUS ==========
export const getAllSupportStatusesController: RequestHandler = async (req, res, next) => {
  try {
    const rows = await refService.getAllSupportStatuses();
    res.json(rows);
  } catch (err) {
    next(err);
  }
};

export const createSupportStatusController: RequestHandler = async (req, res, next) => {
  try {
    const id = await refService.createSupportStatus(req.body.name);
    res.status(201).json({ id, message: 'Support status created' });
  } catch (err) {
    next(err);
  }
};
