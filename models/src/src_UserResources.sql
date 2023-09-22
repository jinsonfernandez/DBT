SELECT
  UserResourceId,
  UserId,
  ResourceId,
  CompletedDate
FROM {{ source('reporting', 'UserResources') }};
