{{
  config(
    materialized = 'incremental',
    on_schema_change='fail'
    )
}}

with stg_UserResources as(
    select 
    UserResourceId,
    UserId,
    ResourceId,
    CompletedDate
    from {{ ref('src_UserResources') }}
    where UserResourceId is not null and
    and UserId is not null 
    and ResourceId is not null
)
select * from stg_UserResources

{% if is_incremental() %}
  AND CompletedDate > (select max(CompletedDate) from {{ this }})
{% endif %}


