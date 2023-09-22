{# users having low course progress #}

{{ config(
  materialized = 'table',
) }}


{% set risk_threshold = 0.5 %}

with user_course_progress as (
    select
    uc.UserId,
    uc.CourseId,
    count(ur.ResourceId) as completed_resources,
    count(c.CourseId) as total_resources

    from {{ ref('fct_UserCourse_cleansed') }} uc
    join {{ ref('dim_course_cleansed') }} c 
    on uc.CourseId = c.CourseId
    left join fct_UserResources_cleansed ur 
    on uc.UserId = ur.UserId and uc.CourseId = ur.ResourceId
    group by uc.UserId, uc.CourseId
)
select
u.UserName,
uc.CourseId,
(count(case when (uc.completed_resources::float / uc.total_resources::float) < {{ risk_threshold }} then 1 else null end) > 0) as at_risk
from {{ ref('dim_user_cleansed') }} u
join user_course_progress uc on u.UserId = uc.UserId
group by u.UserName, uc.CourseId;
