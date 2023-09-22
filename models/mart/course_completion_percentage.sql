{# model to calculate course completion percentage for each course a user is enrolled for .
List each 
  user name, 
  Number of course a user is enrolled ,
  list all the Courses the user is enrolled in a pipe-separated list, 
  and the total learning Minutes. 
Assume the Total learning minutes is the total learning minutes a user took to complete course resources.
 #}



{{ config(
  materialized = 'table',
) }}

with user_courses as (

    select uc.UserId,
    uc.CourseId,
    count(uc.CourseId) as num_courses,
    string_agg(c.CourseName, ' | ') as enrolled_courses,
    sum(r.LearningMinutes) as total_learning_minutes
    (count(ur.ResourceId)::float / count(c.CourseId)::float) * 100 as course_completion_percentage

    from {{ ref('fct_UserCourse_cleansed') }} uc
    join {{ ref('dim_course_cleansed') }} c 
    on uc.CourseId = c.CourseId
    join {{ ref('dim_resource_cleansed') }} r 
    on c.CourseId = r.ResourceId
    left join {{ ref('fct_UserResources_cleansed') }} ur 
    on uc.UserId = ur.UserId and uc.CourseId = ur.ResourceId
    group by uc.UserId
)

select u.UserName, 
  uc.num_courses, 
  uc.enrolled_courses, 
  uc.total_learning_minutes, 
  uc.course_completion_percentage
from {{ ref('dim_user_cleansed') }} u
join user_courses uc on u.UserId = uc.UserId;
