# Write your MySQL query statement below
with sell_table as
(select stock_name, sum(price) as sell_price from stocks 
where operation = 'Sell' 
group by stock_name),

buy_table as
(select stock_name, sum(price) as buy_price from stocks
where operation = 'Buy' 
group by stock_name),

table_new as (
select sell_table.*,buy_table.buy_price  from sell_table
join buy_table on sell_table.stock_name = buy_table.stock_name)

select stock_name,sell_price-buy_price as capital_gain_loss from table_new