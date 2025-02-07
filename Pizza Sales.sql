-- Q1. Retrieve the total number of orders placed.

SELECT COUNT(order_id) as Total_orders 
FROM orders;


-- Q2. Calculate the total revenue generated from pizza sales.


SELECT ROUND(CAST(SUM(order_details.quantity * pizzas.pizza_price) AS NUMERIC), 2) AS Total_sales
FROM order_details 
JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id;
-- -- Here, ::NUMERIC is shorthand for casting in PostgreSQL.
-- Here I have Used CAST() to convert the sum result to numeric before rounding


-- Q3. Identify the highest-priced pizza.

SELECT pizza_types.pizza_name, pizzas.pizza_price
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.pizza_price desc limit 1;


-- Q4. Identify the most common pizza size ordered.

SELECT pizzas.pizza_size,
count(order_details.order_details_id) as order_count
FROM pizzas
JOIN order_details on pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.pizza_size
ORDER BY order_count DESC;


-- Q5. List the top 5 most ordered pizza types along with their quantities.

SELECT pizza_types.pizza_name, SUM(order_details.quantity) AS quantity
FROM pizza_types 
JOIN pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.pizza_name
ORDER BY quantity DESC
LIMIT 5;

-- Q6. Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT pizza_types.pizza_category,
SUM(order_details.quantity) AS quantity
FROM pizza_types 
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.pizza_category 
ORDER BY quantity DESC;

-- Q7. Determine the distribution of orders by hour of the day.

SELECT EXTRACT(HOUR FROM order_time) AS order_hour, COUNT(order_id) AS order_count
FROM orders
GROUP BY order_hour
ORDER BY order_hour;

-- Q8. Join relevant tables to find the category-wise distribution of pizzas.

SELECT pizza_category , COUNT(pizza_name) 
FROM pizza_types
GROUP BY pizza_category;

-- Q9. Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT ROUND(AVG(quantity), 0) AS avg_pizza_ordered_per_day 
FROM(SELECT orders.order_date, SUM(order_details.quantity) AS quantity
FROM orders JOIN order_details
ON orders.order_id = order_details.order_id
GROUP BY orders.order_date) AS order_quantity;

-- Q10. Determine the top 3 most ordered pizza types based on revenue.

SELECT pizza_types.pizza_name, 
SUM(order_details.quantity * pizzas.pizza_price) AS revenue
FROM pizza_types 
JOIN pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.pizza_name ORDER BY revenue DESC LIMIT 3;

