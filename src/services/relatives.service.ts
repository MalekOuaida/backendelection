import pool from '../config/db';

export interface RelativeInput {
  citizensGovId: number;
  fullName?: string;
  relationshipType?: string;
  rDob?: string;
  maritalStatusId?: number;
  relatedCitizenId?: number;
  isEligibleVoter?: boolean;
}

export async function createRelative(data: RelativeInput): Promise<number> {
  if (data.isEligibleVoter && !data.relatedCitizenId) {
    throw new Error('Eligible voters must have relatedCitizenId set.');
  }

  const sql = `
    INSERT INTO relatives_details (
      citizens_gov_id,
      full_name,
      relationship_type,
      r_dob,
      marital_status_id,
      related_citizen_id,
      is_eligible_voter
    )
    VALUES ($1, $2, $3, $4, $5, $6, $7)
    RETURNING relatives_details_id
  `;

  const values = [
    data.citizensGovId,
    data.isEligibleVoter ? null : data.fullName || null,
    data.relationshipType || null,
    data.isEligibleVoter ? null : data.rDob || null,
    data.isEligibleVoter ? null : data.maritalStatusId || null,
    data.relatedCitizenId || null,
    data.isEligibleVoter ?? false
  ];

  const result = await pool.query(sql, values);
  return result.rows[0].relatives_details_id;
}

// GET
export async function getRelativesByCitizenId(citizenId: number) {
  const sql = `
    SELECT 
      r.*,
      c.first_name AS related_first_name,
      c.last_name AS related_last_name,
      a.marital_status_id AS derived_marital_status_id,
      ms.status_name AS derived_marital_status
    FROM relatives_details r
    LEFT JOIN citizens_gov c ON r.related_citizen_id = c.citizens_gov_id
    LEFT JOIN citizen_attrib a ON a.citizens_gov_id = c.citizens_gov_id
    LEFT JOIN marital_status ms ON a.marital_status_id = ms.marital_status_id
    WHERE r.citizens_gov_id = $1
    ORDER BY r.relatives_details_id DESC
  `;
  const result = await pool.query(sql, [citizenId]);
  return result.rows;
}
