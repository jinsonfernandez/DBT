with raw_courses as (
    select 
    CourseId,
    CourseName,
    current_timestamp() as created_at

from {{ source('reporting', 'courses') }}
)
select CourseId, CourseName, created_at
from raw_courses;


