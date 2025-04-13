import { AuditLog } from '../models/audit.model';

export async function logAudit({
  table,
  action,
  recordId,
  userId,
  oldData = null,
  newData = null
}: {
  table: string;
  action: 'CREATE' | 'UPDATE' | 'DELETE';
  recordId: number;
  userId: number;
  oldData?: any;
  newData?: any;
}) {
  await AuditLog.create({
    table,
    action,
    recordId,
    userId,
    oldData,
    newData
  });
}


