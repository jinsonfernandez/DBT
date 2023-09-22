SELECT
  ResourceId,
  ResourceName,
  LearningMinutes
FROM {{ source('reporting', 'resources') }};

