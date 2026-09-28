{{
    config (
        materialized = "incremental",
        on_schema_change = 'fail'
    )
}}

WITH src_reviews AS (
    SELECT * FROM {{ ref('src_reviews') }}
)

SELECT
{{ dbt_utils.generate_surrogate_key(['listing_id', 'review_date', 'reviewer_name', 'review_text']) }} as review_id,
    *
FROM src_reviews
WHERE review_text is not null
{# Initial incremental filter to only load new reviews based on the review_date column.
---------------------------------------------------------------------------------------
{% if is_incremental() -%}
    AND review_date > ( SELECT MAX(review_date) FROM {{ this }} )
{%- endif -%}
---------------------------------------------------------------------------------------
#}

{#
----------------------------------------------------------------------------------------------------------
Updated Increamental filter to allow for date range filtering based on start_date and end_date variables.
----------------------------------------------------------------------------------------------------------
#}
{% if is_incremental() %}
  {% if var("start_date", False) and var("end_date", False) %}
    {{ log('Loading ' ~ this ~ ' incrementally (start_date: ' ~ var("start_date") ~ ', end_date: ' ~ var("end_date") ~ ')', info=True) }}
    AND review_date >= '{{ var("start_date") }}'
    AND review_date < '{{ var("end_date") }}'
  {% else %}
    AND review_date > (select max(review_date) from {{ this }})
    {{ log('Loading ' ~ this ~ ' incrementally (all missing dates)', info=True)}}
  {% endif %}
{% endif %}
