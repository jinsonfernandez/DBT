{{ config(
  materialized = 'incremental',
  unique_key= 'enrollment_month'
) }}


with daily_user_course as (
    select 
    date_trunc('day', uc.EnrollDate) as enrollment_day,
    c.CourseName,
    count(distinct uc.UserId) as enrolled_users,
    sum(r.LearningMinutes) as total_learning_minutes
    
    from 
    {{ ref('fct_UserCourse_cleansed') }} uc
    join 
    {{ ref('dim_CourseResource_cleansed') }} cr 
    on 
    uc.CourseId = cr.CourseId
    join  {{ ref('dim_resource_cleansed') }} r 
    on cr.ResourceId = r.ResourceId
    join {{ ref('dim_course_cleansed') }} c
    on uc.CourseId = c.CourseId
    group by 1, 2
)
select * from daily_user_course
union all
select * from {{ ref('learning_minutes_breakdown') }} em
where em.enrollment_month < date_trunc('month', current_date);


