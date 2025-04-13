import { Router, Request, Response, NextFunction } from 'express';
import multer from 'multer';
import { uploadFileController } from '../controllers/fileUpload.controller';

console.log('✅ fileUploadRouter file is being imported!');

const upload = multer({ dest: 'uploads/' });

const fileUploadRouter = Router();

fileUploadRouter.post(
  '/file',
  (req: Request, res: Response, next: NextFunction) => {
    console.log('✅ [fileUpload.routes] POST /file route was called.');
    next();
  },
  upload.single('myFile'),
  uploadFileController
);

export default fileUploadRouter;
