{{
    config(
        materialized = 'view'
    )
}}

WITH stg_Resources AS (
    select
    ResourceId,
    ResourceName,
    LearningMinutes
    from  {{ ref('src_Resources') }}
    where  ResourceId IS NOT NULL  
    and LENGTH(ResourceName) > 0 
    and LearningMinutes >= 0     
)
SELECT *
FROM stg_Resources;