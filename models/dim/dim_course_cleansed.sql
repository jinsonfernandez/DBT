{{
    config(
        materialized = 'view'
    )
}}

with stg_Courses as(
    select 
    CourseId,
    CourseName, 
    created_at 
    from {{ ref('src_Courses') }}
    where CourseId is not null and 
    LENGTH(CourseName) > 0
)
select * from stg_Courses;


