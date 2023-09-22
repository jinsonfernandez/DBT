{{
    config(
        materialized = 'view'
    )
}}

with stg_user as (
    select 
    UserId,
    UserName,
    Email,
    createdAt
    from {{ ref('src_users') }}
    where UserId is not null and length(UserName) > 0 and Email LIKE '%@%'
    )
select * from stg_user;

