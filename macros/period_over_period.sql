{% macro percentage_change(model, metric, datefield, datepart) %}

with {{model}}_temp as (
    select 
    {{datepart}}({{datefield}}) as {{datepart}}_field,
    sum({{metric}}) as {{metric}}_field
    from {{ model }}
    group by 1
)

select 
a.{{datepart}}_field as {{datepart}}_field,
a.{{metric}}_field as {{metric}}_field,
lag(a.{{metric}}_field) over (order by a.{{datepart}}_field) as prev_{{metric}}_field,
(a.{{metric}}_field / lag(a.{{metric}}_field) over (order by a.{{datepart}}_field)
 -1) * 100 as pct_growth_from_previous
from {{model}}_temp a

{% endmacro %}

