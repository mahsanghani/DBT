select *
from (
        select dim_cust.customer_id
        from {{ ref('dim_customers') }} dim_cust
            left join {{ ref('stg_eltool__customers') }} stg_cust on dim_cust.customer_id = stg_cust.customer_id
        where stg_cust.customer_id is null
        UNION ALL
        select stg_cust.customer_id
        from {{ ref('stg_eltool__customers') }} stg_cust
            left join {{ ref('dim_customers') }} dim_cust on stg_cust.customer_id = dim_cust.customer_id
        where dim_cust.customer_id is null
    ) tmp
