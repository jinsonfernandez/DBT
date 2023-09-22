SELECT
  CourseResourceId,
  CourseId,
  ResourceId
FROM {{ source('reporting', 'CourseResources') }};