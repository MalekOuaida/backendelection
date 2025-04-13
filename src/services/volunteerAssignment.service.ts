import pool from '../config/db';

export interface AssignmentInput {
  volunteerId: number;
  assignedCitizenId: number;
  taskDescription?: string;
  pickupLocation?: string;
  status?: string;
}

// CREATE
export async function createAssignment(data: AssignmentInput): Promise<number> {
  const sql = `
    INSERT INTO volunteer_assignments (
      volunteer_id,
      assigned_citizen_id,
      task_description,
      pickup_location,
      status
    )
    VALUES ($1, $2, $3, $4, $5)
    RETURNING assignment_id
  `;
  const values = [
    data.volunteerId,
    data.assignedCitizenId,
    data.taskDescription || null,
    data.pickupLocation || null,
    data.status || 'pending'
  ];

  const result = await pool.query(sql, values);
  return result.rows[0].assignment_id;
}

// GET all assignments for a volunteer
export async function getAssignmentsByVolunteerId(volunteerId: number) {
  const sql = `
    SELECT 
      a.*, 
      c.first_name AS citizen_first_name,
      c.last_name AS citizen_last_name
    FROM volunteer_assignments a
    LEFT JOIN citizens_gov c ON a.assigned_citizen_id = c.citizens_gov_id
    WHERE a.volunteer_id = $1
    ORDER BY a.created_at DESC
  `;
  const result = await pool.query(sql, [volunteerId]);
  return result.rows;
}
