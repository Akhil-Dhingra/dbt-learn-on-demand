with payment as
(
    select 
    orderid as order_id
    ,paymentmethod
    ,status
    ,(amount/100) as amount
    from {{ source('stripe','payment') }}
)

select * from payment