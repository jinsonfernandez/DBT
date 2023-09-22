{% snapshot scd_raw_users %}

{{
   config(
       target_schema='reporting',
       unique_key='UserId',
       strategy='timestamp',
       updated_at='updated_at',
       invalidate_hard_deletes=True
   )
}}

select *  FROM {{ source('reporting', 'users') }}

{% endsnapshot %}
