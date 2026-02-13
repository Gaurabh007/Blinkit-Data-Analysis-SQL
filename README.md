# <center>**Blinkit Data Analysis using SQL**</center>

<img src="image.png" 
        alt="Picture" 
        width="1000" 
        height="600" 
        style="display: block; margin: 0 auto" />

**Tools Used :** SQL, Excel, Power BI

[Dataset Used](https://www.kaggle.com/datasets/arunkumaroraon/blinkit-grocery-dataset?select=BlinkIT-Grocery-Data.csv)

[SQL Analysis Code](https://github.com/Gaurabh007/Blinkit-Data-Analysis-SQL/blob/main/Blinkit_Data_Analysis.sql)

[Power BI Dashboard](https://app.powerbi.com/reportEmbed?reportId=84987c39-014f-4f93-93d9-1d22346a7933&autoAuth=true&ctid=9c57347d-760c-410c-8ea1-f1c42e38522d)

- **Business Problem:** To conduct a comprehensive analysis of Blinkit's sales performance, customer satisfaction, and inventory distribution to identify key insights and opportunities for optimization using various KPIs and visualizations in Power Bl. They need a robust and scalable data analytics solution to handle the amount of data and uncover valuable patterns and trends.


## 1. The overall revenue generated from all items sold.
```mysql
SELECT CONCAT(CAST(sum(sales)/1000000 as DECIMAL(10,2)),'M') as Total_Sales_Millions
from blinkit_grocery_data;
```
Result:

![Q1](https://i.ibb.co/N2SKGJQw/image.png)

>Insight:
The total revenue generated from all items sold amounts to a multi-million figure, indicating strong sales performance across the grocery catalog. This metric sets the foundation for evaluating overall business health and revenue trends.

--------

## 2. The average revenue per sale.
```mysql
SELECT CONCAT(CAST(AVG(sales) as DECIMAL(10,0)),'M') as Avg_Sales
from blinkit_grocery_data;
```
Result:

![Q2](https://i.ibb.co/RGLqnyXK/image.png)

>Insight:
This output shows the average sales value per item sold, offering a view into individual product performance. It helps assess whether revenue is driven by high-value products or a large volume of low-value items.

--------

## 3. The total count of different items sold.
```mysql
SELECT COUNT(*) AS Total_No_Items from blinkit_grocery_data;
```
Result:

![Q3](https://i.ibb.co/HfzqMPY6/image.png)

>Insight:
This query returns the count of all individual product entries, reflecting the scale and diversity of Blinkit's product offerings. A large item count suggests a wide assortment and potentially a broader market reach.

---------

## 4. The average customer rating for items sold.
```mysql
SELECT CAST(AVG(`Rating`) as DECIMAL(10,2)) as Avg_Rating
from blinkit_grocery_data;
```
Result:

![Q4](https://i.ibb.co/SD4cX78W/image.png)

>Insight:
This metric provides the mean customer satisfaction score across all products. A high average rating indicates strong customer satisfaction and product quality, whereas a lower one could highlight the need for improvements.


---
## 5. Total Sales by Fat Content:
Objective: Analyze the impact of fat content on total sales.

```mysql
SELECT `Item Fat Content`, 
                CONCAT(CAST(sum(sales)/1000 as DECIMAL(10,2)),'k') as Total_Sales_Thousands,
                CONCAT(CAST(AVG(sales) as DECIMAL(10,0)),'M') as Avg_Sales,
                COUNT(*) AS Total_No_Items,
                CAST(AVG(`Rating`) as DECIMAL(10,2)) as Avg_Rating
from blinkit_grocery_data 
GROUP BY `Item Fat Content`
ORDER BY Total_Sales_Thousands DESC;
```

Result:

![Q5](https://i.ibb.co/F4SQB2th/image.png)

>Insight:
This output segments sales based on fat content (e.g., Low Fat, Regular, etc.), revealing consumer preferences. Higher sales in certain fat categories can inform product stocking and health-based marketing strategies.


---
## 6. Total Sales by Item Type:
Objective: Identify the performance of different item types in terms of total sales.

```mysql
SELECT `Item Type`, 
                CONCAT(CAST(sum(sales)/1000 as DECIMAL(10,2)),'k') as Total_Sales,
                CONCAT(CAST(AVG(sales) as DECIMAL(10,0)),'M') as Avg_Sales,
                COUNT(*) AS Total_No_Items,
                CAST(AVG(`Rating`) as DECIMAL(10,2)) as Avg_Rating
from blinkit_grocery_data 
GROUP BY `Item Type`
ORDER BY Total_Sales;
```
Result:

![Q6](https://i.ibb.co/GqbFRQf/image.png)

>Insight:
By analyzing performance across product types (e.g., Dairy, Snacks, Beverages), this result pinpoints high-revenue categories. The business can use this to identify top-selling segments and plan inventory or promotions accordingly.

---
## 7. Fat Content by Outlet for Total Sales:
Objective: Compare total sales across different outlets segmented by fat content.
```mysql
SELECT `Item Fat Content`,`Outlet Location Type`,
                CONCAT(CAST(sum(sales)/1000 as DECIMAL(10,2)),'k') as Total_Sales,
                CONCAT(CAST(AVG(sales) as DECIMAL(10,0)),'M') as Avg_Sales,
                COUNT(*) AS Total_No_Items,
                CAST(AVG(`Rating`) as DECIMAL(10,2)) as Avg_Rating
from blinkit_grocery_data 
GROUP BY `Item Fat Content`,`Outlet Location Type`
ORDER BY Total_Sales;
```
Result:

![Q7](https://i.ibb.co/wD5XhYc/image.png)

>Insight:
This analysis combines fat content with outlet location types to identify regional or store-type preferences. It uncovers consumption patterns and helps Blinkit align store-specific inventory with local customer demand.

---
## 8. Total Sales by Outlet Establishment:
Objective: Evaluate how the age or type of outlet establishment influences total sales.
```mysql
SELECT `Outlet Establishment Year`,
                CONCAT(CAST(SUM(`Sales`)/1000 as DECIMAL(10,2)),'k') as Total_Sales,
                CONCAT(CAST(AVG(`Sales`) as DECIMAL(10,0)),'M') as Avg_Sales,
                COUNT(*) as No_of_Items
from blinkit_grocery_data 
GROUP BY `Outlet Establishment Year`
ORDER BY Total_Sales;
```
Result:

![Q8](https://i.ibb.co/mCWZP4yV/image.png)

>Insight:
This shows how much each outlet, based on its establishment year, contributes to total sales. Newer or older outlets with higher sales can guide decisions on expansion, renovation, or marketing efforts.

---
## 9. Percentage of Sales by Outlet Size:
Objective: Analyze the correlation between outlet size and total sales.
```mysql
SELECT `Outlet Size`,
                CAST(SUM(`Sales`) as DECIMAL(10,2))as Total_Sales,
                CAST((SUM(`Sales`) * 100.0 / SUM(SUM(`Sales`)) OVER()) as DECIMAL(10,2)) as Sales_Percentage
FROM blinkit_grocery_data
GROUP BY `Outlet Size`;
```
Result:

![Q9](https://i.ibb.co/XZ5NNQQs/image.png)

>Insight:
This output provides a percentage breakdown of total sales by outlet size (Small, Medium, High). It highlights which store sizes contribute most to revenue and can help in optimizing store layouts or investments.


---
## 10. Sales by Outlet Location:
Objective: Assess the geographic distribution of sales across different locations.
```mysql
SELECT `Outlet Location Type`,
                CAST(SUM(`Sales`) as DECIMAL(10,2)) as Total_Sales,
                CAST((SUM(`Sales`) * 100.0 / SUM(SUM(`Sales`)) OVER()) as DECIMAL(10,2)) as Sales_Percentage
FROM blinkit_grocery_data
GROUP BY `Outlet Location Type`;
```
Result:

![Q10](https://i.ibb.co/HfJZG4Zt/image.png)

>Insight:
This shows the distribution of sales across different geographic locations (Urban, Semi-Urban, etc.), offering insights into regional performance. It helps target marketing and operations based on location-based profitability.

---
## 11. All Metrics by Outlet Type:
Objective: Provide a comprehensive view of all key metrics (Total Sales, Average Sales, Number of
Items, Average Rating) broken down by different outlet types.
```mysql
SELECT `Outlet Type`,
                CONCAT(CAST(SUM(`Sales`)/1000 as DECIMAL(10,2)),'k') as Total_Sales,
                CONCAT(CAST(AVG(`Sales`) as DECIMAL(10,0)),'M') as Avg_Sales,
                COUNT(*) as No_of_Items,
                CAST(AVG(`Rating`) as DECIMAL(10,2)) as Avg_Rating
from blinkit_grocery_data 
GROUP BY `Outlet Type`
ORDER BY Total_Sales DESC;
```
Result:

![Q11](https://i.ibb.co/Gvnwx47d/image.png)

>Insight:
This comprehensive summary breaks down total sales, average sales, item count, and ratings by outlet type (e.g., Grocery Store, Supermarket). It provides a comparative performance view across formats, guiding strategic decisions on outlet expansion or improvement.

---
