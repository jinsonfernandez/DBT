{{
    config(
        materialized = 'view'
    )
}}

with stg_CourseResources as (
    select 
    CourseResourceId,
    CourseId,
    ResourceId
    from {{ ref('src_CourseResources') }}
    WHERE CourseResourceId IS NOT NULL 
    AND CourseId IS NOT NULL      
    AND ResourceId IS NOT NULL
)
select * from stg_CourseResources;