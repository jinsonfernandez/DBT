{# monthly breakdown of users enrolled in a course and Total learning minutes #}


{{ config(
  materialized = 'table',
) }}


with monthly_course_enrollment as (
    select
    date_trunc('month', uc.EnrollDate) as enrollment_month,
    c.CourseName,
    count(distinct uc.UserId) as enrolled_users,
    sum(r.LearningMinutes) as total_learning_minutes
    
    from
    {{ ref('fct_UserCourse_cleansed') }} uc
    join
    {{ ref('dim_CourseResource_cleansed') }} cr
    on uc.CourseId = cr.CourseId
    join {{ ref('dim_resource_cleansed') }} r
    on cr.ResourceId = r.ResourceId
    join {{ ref('dim_course_cleansed') }} c
    on uc.CourseId = c.CourseId
    group by 1, 2
)
select * from monthly_course_enrollment;
