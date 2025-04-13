import mongoose from 'mongoose';

const auditLogSchema = new mongoose.Schema({
  table: String,
  action: String,
  recordId: Number,
  userId: Number,
  timestamp: { type: Date, default: Date.now },
  oldData: mongoose.Schema.Types.Mixed,
  newData: mongoose.Schema.Types.Mixed,
});

export const AuditLog = mongoose.model('AuditLog', auditLogSchema);
