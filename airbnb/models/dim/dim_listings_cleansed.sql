WITH src_listings as (
    SELECT * FROM {{ref('src_listings')}} --substituting the template tag
)

SELECT
    listing_id,
    listing_name,
    room_type,
    case 
        when minimum_nights = 0 then 1 --there is at least one night. it is illogical for there be 0 night per listing, hence this is bad data
    else minimum_nights
    end as minimum_nights,
    host_id,
    replace(price_str, '$', '')::number(10,2) as price, --because it is written as $90.00 in raw data
    created_at,
    updated_at
FROM
    src_listings