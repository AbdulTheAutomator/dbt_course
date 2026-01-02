WITH src_hosts as (
    SELECT * FROM {{ref('src_hosts')}} --substituting the template tag
)

SELECT
    host_id,
    COALESCE(host_name, 'Anonymous') as host_name, --handling empty string as unknown
    is_superhost,
    created_at,
    updated_at

FROM
    src_hosts