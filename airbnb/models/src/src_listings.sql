--creates a transformation step
--creates easy to debug code and modular
--only need to change cte definition ocne if source changes
WITH raw_listings as (
select * from AIRBNB.RAW.RAW_LISTINGS
)

--making it business friendly name
--listing url is missed here
select 
id as listing_id,
name as listing_name,
room_type,
minimum_nights,
host_id,
price as price_str,
created_at,
updated_at
from 
raw_listings