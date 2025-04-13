import pool from '../config/db';

// ========== BLOOD TYPE ==========
export async function getAllBloodTypes() {
  const sql = 'SELECT * FROM blood_type ORDER BY blood_type_id';
  const res = await pool.query(sql);
  return res.rows;
}

export async function createBloodType(name: string) {
  const sql = `
    INSERT INTO blood_type (blood_type_name)
    VALUES ($1)
    RETURNING blood_type_id
  `;
  const res = await pool.query(sql, [name]);
  return res.rows[0].blood_type_id;
}

// ========== MARITAL STATUS ==========
export async function getAllMaritalStatuses() {
  const sql = 'SELECT * FROM marital_status ORDER BY marital_status_id';
  const res = await pool.query(sql);
  return res.rows;
}

export async function createMaritalStatus(name: string) {
  const sql = `
    INSERT INTO marital_status (status_name)
    VALUES ($1)
    RETURNING marital_status_id
  `;
  const res = await pool.query(sql, [name]);
  return res.rows[0].marital_status_id;
}

// ========== EDUCATION LEVEL ==========
export async function getAllEducationLevels() {
  const sql = 'SELECT * FROM education_level ORDER BY education_level_id';
  const res = await pool.query(sql);
  return res.rows;
}

export async function createEducationLevel(name: string) {
  const sql = `
    INSERT INTO education_level (level_name)
    VALUES ($1)
    RETURNING education_level_id
  `;
  const res = await pool.query(sql, [name]);
  return res.rows[0].education_level_id;
}

// ========== SUPPORT STATUS ==========
export async function getAllSupportStatuses() {
  const sql = 'SELECT * FROM support_status ORDER BY support_status_id';
  const res = await pool.query(sql);
  return res.rows;
}

export async function createSupportStatus(name: string) {
  const sql = `
    INSERT INTO support_status (status_name)
    VALUES ($1)
    RETURNING support_status_id
  `;
  const res = await pool.query(sql, [name]);
  return res.rows[0].support_status_id;
}
