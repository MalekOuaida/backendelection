import pool from '../config/db';

// ======= Election Year =======
export async function createElectionYear(year: number) {
  const sql = `INSERT INTO election_year (year) VALUES ($1) RETURNING election_year_id`;
  const res = await pool.query(sql, [year]);
  return res.rows[0].election_year_id;
}

export async function getAllElectionYears() {
  const sql = `SELECT * FROM election_year ORDER BY year DESC`;
  const res = await pool.query(sql);
  return res.rows;
}

// ======= Election Type =======
export async function createElectionType(typeName: string) {
  const sql = `INSERT INTO election_type (type_name) VALUES ($1) RETURNING election_type_id`;
  const res = await pool.query(sql, [typeName]);
  return res.rows[0].election_type_id;
}

export async function getAllElectionTypes() {
  const sql = `SELECT * FROM election_type ORDER BY type_name ASC`;
  const res = await pool.query(sql);
  return res.rows;
}

// ======= Election District =======
export async function createElectionDistrict(districtName: string) {
  const sql = `INSERT INTO election_district (district_name) VALUES ($1) RETURNING election_district_id`;
  const res = await pool.query(sql, [districtName]);
  return res.rows[0].election_district_id;
}

export async function getAllElectionDistricts() {
  const sql = `SELECT * FROM election_district ORDER BY district_name ASC`;
  const res = await pool.query(sql);
  return res.rows;
}
