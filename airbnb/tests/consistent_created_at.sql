-- select fr.*, dlc.created_at
-- from {{ ref('fct_reviews') }} fr

-- join {{ ref('dim_listings_cleansed') }} dlc
-- on fr.listing_id = dlc.listing_id
-- where fr.review_date < dlc.created_at


select *
from {{ ref('fct_reviews') }} fr

inner join {{ ref('dim_listings_cleansed') }} dlc

using (listing_id)

where fr.review_date < dlc.created_at
