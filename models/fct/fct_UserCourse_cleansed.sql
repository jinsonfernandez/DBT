{{
  config(
    materialized = 'incremental',
    on_schema_change='fail'
    )
}}

with stg_UserCourse as (
    select
    UserCourseId,
    UserId,
    CourseId,
    EnrollDate
    from ref{{ ('src_UserCourse') }}
    where UserCourseId is not null 
    and UserId is not null 
    and CourseId is not null
)
select * from stg_UserCourse

{% if is_incremental() %}
  AND EnrollDate > (select max(EnrollDate) from {{ this }})
{% endif %}
