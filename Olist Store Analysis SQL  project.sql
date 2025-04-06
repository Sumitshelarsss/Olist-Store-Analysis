use olist_store_analysis;

## KPI 1##
# Weekend vs weekday payment statistics ##
select 
case when dayofweek(str_to_Date(o.order_purchase_timestamp,'%Y-%m-%d'))
in (1,7) then 'weekend' else'weekday' end as Daytype,
count(distinct o.order_id) as totalorders,
round(sum(p.payment_value)) as totalpayments,
round(avg(p.payment_value)) as averagepayment
from
orders_dataset o
join
order_peyment p on o.order_id = p.order_id
group by
DayType;


## KPI 2 ##
# no of orders with review score 5 & payment type as credic card #
select 
count(distinct p.order_id) as numberoforders
from
order_peyment p
Join
review_dataset r on p.order_id = r.order_id
where
r.review_score = 5
and p.payment_type = 'credit_card';

## KPI 3 ##
# average no of days taken for order delivered customer date for pet shop #
select
product_category_name,
round(avg(datediff(order_delivered_customer_date,order_purchase_timestamp))) as avg_delivery_time
from
orders_dataset o
join
order_items i on i.order_id = o.order_id
join
products_dataset p on p.product_id=i.product_id
where
p.product_category_name = 'pet_shop'
and o.order_delivered_customer_date is not null;

## KPI 4 ##
# average price & payment values from sao paulo city #
select
round(avg(i.price)) as average_price,
round(avg(p.payment_value)) as average_payment
from
olist_customers c
join
orders_dataset o on c.customer_id = o.customer_id
join
order_items i on o.order_id = i.order_id
join
order_peyment p on o.order_id = p.order_id
where
customer_city = 'sao paulo';

## KPI 5 ##
# Relationship between shipping days vs review score #
select
round(avg(datediff(order_delivered_customer_date,order_purchase_timestamp)),0) as avgshippingDays,
review_score
from
orders_dataset o
join
review_dataset r on o.order_id = r.order_id
where
order_delivered_customer_date is not null
and order_purchase_timestamp is not null
group by
review_score;
