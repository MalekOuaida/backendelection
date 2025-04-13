import pool from '../config/db';

export interface CitizenServiceInput {
  citizensGovId: number;
  relativeService?: boolean;
  relativesDetailsId?: number;
  serviceTypeId: number;
  serviceStatusId: number;
  serviceDescription: string;
}

// CREATE
export async function createCitizenService(data: CitizenServiceInput): Promise<number> {
  const sql = `
    INSERT INTO citizens_services (
      citizens_gov_id,
      relative_service,
      relatives_details_id,
      service_type_id,
      service_status_id,
      service_description
    )
    VALUES ($1, $2, $3, $4, $5, $6)
    RETURNING citizens_services_id
  `;
  const values = [
    data.citizensGovId,
    data.relativeService ?? false,
    data.relativesDetailsId ?? null,
    data.serviceTypeId,
    data.serviceStatusId,
    data.serviceDescription
  ];

  const result = await pool.query(sql, values);
  return result.rows[0].citizens_services_id;
}

// GET ALL SERVICES FOR A CITIZEN
export async function getServicesByCitizenId(citizenId: number) {
  const sql = `
    SELECT 
      cs.*,
      st.type_name AS service_type,
      ss.status_name AS service_status,
      r.full_name AS relative_name,
      r.related_citizen_id
    FROM citizens_services cs
    LEFT JOIN service_type st ON cs.service_type_id = st.service_type_id
    LEFT JOIN service_status ss ON cs.service_status_id = ss.service_status_id
    LEFT JOIN relatives_details r ON cs.relatives_details_id = r.relatives_details_id
    WHERE cs.citizens_gov_id = $1
    ORDER BY cs.citizens_services_id DESC
  `;
  const result = await pool.query(sql, [citizenId]);
  return result.rows;
}
