SELECT
  UserCourseId,
  UserId,
  CourseId,
  EnrolleDate,
  load_date
FROM {{ source('reporting', 'UserCourse') }};
