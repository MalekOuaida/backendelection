import pool from '../config/db';

export interface VolunteerInput {
  citizenId: number;
  isVoter?: boolean;
  volunteerRole?: string;
  activeInProject?: boolean;
  notes?: string;
}

export async function upsertVolunteer(data: any) {
  const sqlFind = `SELECT * FROM volunteers WHERE citizen_id = $1`;
  const existing = await pool.query(sqlFind, [data.citizen_id]);
  const oldVolunteer = existing.rows[0];

  if (oldVolunteer) {
    const sqlUpdate = `
      UPDATE volunteers
      SET role = $1, active = $2
      WHERE citizen_id = $3
      RETURNING volunteer_id
    `;
    const result = await pool.query(sqlUpdate, [
      data.role,
      data.active,
      data.citizen_id
    ]);
    return { oldVolunteer, newVolunteerId: result.rows[0].volunteer_id };
  } else {
    const sqlInsert = `
      INSERT INTO volunteers (citizen_id, role, active)
      VALUES ($1, $2, $3)
      RETURNING volunteer_id
    `;
    const result = await pool.query(sqlInsert, [
      data.citizen_id,
      data.role,
      data.active
    ]);
    return { oldVolunteer: null, newVolunteerId: result.rows[0].volunteer_id };
  }
}


export async function getVolunteerByCitizenId(citizenId: number) {
  const sql = `
    SELECT v.*, c.first_name, c.last_name
    FROM volunteer v
    LEFT JOIN citizens_gov c ON c.citizens_gov_id = v.citizen_id
    WHERE v.citizen_id = $1
  `;
  const result = await pool.query(sql, [citizenId]);
  return result.rows[0] || null;
}
