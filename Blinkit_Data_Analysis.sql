# ------------------------------------------------------------------------------------------------------------------------------------------#
#                                                            Data Cleaning                                                                  #
# ------------------------------------------------------------------------------------------------------------------------------------------#
UPDATE blinkit_grocery_data set `Item Fat Content` = 'Regular' where `Item Fat Content` = 'reg';
UPDATE blinkit_grocery_data set `Item Fat Content` = 'Low Fat' where `Item Fat Content` = 'LF' or `Item Fat Content` = 'low Fat';


# ------------------------------------------------------------------------------------------------------------------------------------------#
#                                                           KPI Requirements                                                                #
# ------------------------------------------------------------------------------------------------------------------------------------------#
-- 1. Total Sales: The overall revenue generated from all items sold.
SELECT CONCAT(CAST(sum(sales)/1000000 as DECIMAL(10,2)),'M') as Total_Sales_Millions
from blinkit_grocery_data;

-- 2. Average Sales: The average revenue per sale.
SELECT CONCAT(CAST(AVG(sales) as DECIMAL(10,0)),'M') as Avg_Sales
from blinkit_grocery_data;

-- 3. Number of Items: The total count of different items sold.
SELECT COUNT(*) AS Total_No_Items from blinkit_grocery_data;

-- 4. Average Rating: The average customer rating for items sold.
SELECT CAST(AVG(`Rating`) as DECIMAL(10,2)) as Avg_Rating
from blinkit_grocery_data;


# ------------------------------------------------------------------------------------------------------------------------------------------#
#                                                           Granular Requirements                                                           #
# ------------------------------------------------------------------------------------------------------------------------------------------#

/*
1. Total Sales by Fat Content:
    Objective: Analyze the impact of fat content on total sales.
    Additional KPI Metrics: Assess how other KPIs (Average Sales, Number of Items, Average Rating) vary with fat content.
*/
SELECT `Item Fat Content`, 
                CONCAT(CAST(sum(sales)/1000 as DECIMAL(10,2)),'k') as Total_Sales_Thousands,
                CONCAT(CAST(AVG(sales) as DECIMAL(10,0)),'M') as Avg_Sales,
                COUNT(*) AS Total_No_Items,
                CAST(AVG(`Rating`) as DECIMAL(10,2)) as Avg_Rating
from blinkit_grocery_data 
GROUP BY `Item Fat Content`
ORDER BY Total_Sales_Thousands DESC;

/*
2. Total Sales by Item Type:
    Objective: Identify the performance of different item types in terms of total sales.
    Additional KPI Metrics: Assess how other KPIs (Average Sales, Number of Items, Average Rating) vary with fat content.
*/

SELECT `Item Type`, 
                CONCAT(CAST(sum(sales)/1000 as DECIMAL(10,2)),'k') as Total_Sales_Millions,
                CONCAT(CAST(AVG(sales) as DECIMAL(10,0)),'M') as Avg_Sales,
                COUNT(*) AS Total_No_Items,
                CAST(AVG(`Rating`) as DECIMAL(10,2)) as Avg_Rating
from blinkit_grocery_data 
GROUP BY `Item Type`
ORDER BY Total_Sales_Millions ;


/*
3. Fat Content by Outlet for Total Sales:
    Objective: Compare total sales across different outlets segmented by fat content.
    Additional KPI Metrics: Assess how other KPIs (Average Sales, Number of Items, Average Rating) vary with fat content.
*/

SELECT `Item Fat Content`,`Outlet Location Type`,
                CONCAT(CAST(sum(sales)/1000 as DECIMAL(10,2)),'k') as Total_Sales_Millions,
                CONCAT(CAST(AVG(sales) as DECIMAL(10,0)),'M') as Avg_Sales,
                COUNT(*) AS Total_No_Items,
                CAST(AVG(`Rating`) as DECIMAL(10,2)) as Avg_Rating
from blinkit_grocery_data 
GROUP BY `Item Fat Content`,`Outlet Location Type`
ORDER BY Total_Sales_Millions ;



/*
4. Total Sales by Outlet Establishment:
    Objective: Evaluate how the age or type of outlet establishment influences total sales.
*/
SELECT `Outlet Establishment Year`,
                CONCAT(CAST(SUM(`Sales`)/1000 as DECIMAL(10,2)),'k') as Total_Sales,
                CONCAT(CAST(AVG(`Sales`) as DECIMAL(10,0)),'M') as Avg_Sales,
                COUNT(*) as No_of_Items
from blinkit_grocery_data 
GROUP BY `Outlet Establishment Year`
ORDER BY Total_Sales;


/*
5. Percentage of Sales by Outlet Size:
Objective: Analyze the correlation between outlet size and total sales.
*/

SELECT `Outlet Size`,
                CAST(SUM(`Sales`) as DECIMAL(10,2))as Total_Sales,
                CAST((SUM(`Sales`) * 100.0 / SUM(SUM(`Sales`)) OVER()) as DECIMAL(10,2)) as Sales_Percentage
FROM blinkit_grocery_data
GROUP BY `Outlet Size`;
-- OVER() is the window function used here.

/*
6. Sales by Outlet Location:
Objective: Assess the geographic distribution of sales across different locations.
*/
SELECT `Outlet Location Type`,
                CAST(SUM(`Sales`) as DECIMAL(10,2)) as Total_Sales,
                CAST((SUM(`Sales`) * 100.0 / SUM(SUM(`Sales`)) OVER()) as DECIMAL(10,2)) as Sales_Percentage
FROM blinkit_grocery_data
GROUP BY `Outlet Location Type`;

/*
7. All Metrics by Outlet Type:
Objective: Provide a comprehensive view of all key metrics (Total Sales, Average Sales, Number of
Items, Average Rating) broken down by different outlet types.
*/
SELECT `Outlet Type`,
                CONCAT(CAST(SUM(`Sales`)/1000 as DECIMAL(10,2)),'k') as Total_Sales,
                CONCAT(CAST(AVG(`Sales`) as DECIMAL(10,0)),'M') as Avg_Sales,
                COUNT(*) as No_of_Items,
                CAST(AVG(`Rating`) as DECIMAL(10,2)) as Avg_Rating
from blinkit_grocery_data 
GROUP BY `Outlet Type`
ORDER BY Total_Sales DESC;
