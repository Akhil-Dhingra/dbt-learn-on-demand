with payment as
(
    select * from {{ ref('stg_payment') }}
),

orders as
(
    select * from {{ ref('stg_orders') }}
),

order_payments as
(
select payment.order_id
        ,sum(case when payment.status = 'success' then payment.amount else 0 end) as order_amount
from payment
group by 1
),

final as 
(
    select orders.order_id,
      orders.customer_id,
        orders.order_date,
        orders.status,
        coalesce(order_payments.order_amount,0) as amount
        from orders
        left join order_payments using (order_id)
)

select * from final