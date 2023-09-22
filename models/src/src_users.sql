with raw_users as (

SELECT
    UserId,
    UserName,
    Email,
    createdAt, 
    current_timestamp() AS updated_at
    FROM {{ source('reporting', 'users') }}
)
SELECT
  UserId,
  UserName,
  Email,
  created_at,
  updated_at
FROM raw_users;