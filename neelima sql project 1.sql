/*
Business model Customer to Customer (C2C) allows customers to do business with each other. 

This model is growing fast with e-commerce platforms where sellers may be required to pay some amount and buyer can buy it without paying anything. 

E-Commerce website brings the seller and buyer to the same platform. 

Analyzing the user's database will lead to understanding the business perspective. 

Behaviour of the users can be traced in terms of business with exploration of the user’s database. 

Dataset: One .csv file with name users_data with 98913 rows and 27 columns
*/


--- 1. Create new schema as ecommerce

--- ANSWER----

CREATE DATABASE ecommerce;

/*
2. Import .csv file users_data into MySQL
(right click on ecommerce schema -> Table Data import Wizard -> Give path of the file -> Next -> choose options : Create a new table , select delete if exist -> next -> next)
*/
---- ANSWER-----

USE ecommerce;

SELECT COUNT(*) FROM one;

DESC one;
#******************************************************************************************************************************

--- 3. Run SQL command to see the structure of table

--- ANSWER----
DESC one;


--- 4. Run SQL command to select first 100 rows of the database.

--- ANSWER----

-- SELECT * FROM one;

SELECT 
    *
FROM
    one
LIMIT 100;

#********************************************************************************************************************************************
--- 5. How many distinct values exist in table for field country and language

---- ANSWER-----

SELECT 
    COUNT(DISTINCT country) DistinctCountry,
    COUNT(DISTINCT language) DistinctLanguage
FROM
    one;
    
#**********************************************************************************************************************************
--- 6. Check whether male users are having maximum followers or female users.

--- ANSWER---

SELECT * FROM one;

SELECT 
    gender, SUM(socialNbFollowers) Followers
FROM
    one
GROUP BY gender
ORDER BY SUM(socialNbFollowers) DESC
LIMIT 1;
#****************************************************************************************************************************************
/*
7. Calculate the total users those
a. Uses Profile Picture in their Profile
b. Uses Application for Ecommerce platform
c. Uses Android app
d. Uses ios app
*/

------ ANSWER----------
SELECT * FROM one;
-- a. Uses Profile Picture in their Profile

SELECT 
    COUNT(*)
FROM
    one
WHERE
    hasProfilePicture = 'True';

-- b. Uses Application for Ecommerce platform

SELECT 
    COUNT(*)
FROM
    one
WHERE
    hasAnyApp = 'True';

-- c. Uses Android app

SELECT 
    COUNT(*)
FROM
    one
WHERE
    hasAndroidApp = 'True';

-- d. Uses ios app

SELECT 
    COUNT(*)
FROM
    one
WHERE
    hasIosApp = 'True';

#*****************************************************************************************************************************************

--- 8. Calculate the total number of buyers for each country and sort the result in descending order of total number of buyers.  (Hint: consider only those users having at least 1 product bought.)

---- ANSWER-----

SELECT * FROM one;

SELECT 
    country, SUM(productsBought)
FROM
    one
WHERE
    productsBought > 1
GROUP BY country
ORDER BY SUM(productsBought) DESC;

#*********************************************************************************************************************************************
---- 9. Calculate the total number of sellers for each country and sort the result in ascending order of total number of sellers.  (Hint: consider only those users having at least 1 product sold.)

---- ANSWER---

SELECT * FROM one;

SELECT 
    country, SUM(productsSold)
FROM
    one
WHERE
    productsSold > 1
GROUP BY country
ORDER BY SUM(productsSold) ASC;


--- 10. Display name of top 10 countries having maximum products pass rate.

--- ANSWER----

SELECT * FROM one;

SELECT 
    country, SUM(productsPassRate)
FROM
    one
GROUP BY country
ORDER BY SUM(productsPassRate) DESC
LIMIT 10;
#*********************************************************************************************************************************

--- 11. Calculate the number of users on an ecommerce platform for different language choices.

----- ANSWER-----

SELECT * FROM one;

SELECT 
    language, COUNT(*) NumberOfUsers
FROM
    one
GROUP BY language;

#***********************************************************************************************************************************
--- 12. Check the choice of female users about putting the product in a wishlist or to like socially on an ecommerce platform.  (Hint: use UNION to answer this question.)
---- ANSWER----

SELECT * FROM one;

-- SELECT SUM(productsWished),SUM(socialProductsLiked) FROM one WHERE gender='F';

SELECT 
    SUM(productsWished), SUM(socialProductsLiked)
FROM
    one
WHERE
    gender = 'F' 
UNION SELECT 
    SUM(productsWished), SUM(socialProductsLiked)
FROM
    one
WHERE
    gender = 'F';

#***********************************************************************************************************************************************
---- 13.Check the choice of male users about being seller or buyer.  (Hint: use UNION to solve this question.)

---- ANSWER----
SELECT 
    SUM(productsSold), SUM(productsBought)
FROM
    one
WHERE
    gender = 'M' 
UNION SELECT 
    SUM(productsSold), SUM(productsBought)
FROM
    one
WHERE
    gender = 'M';
#*******************************************************************************************************************************

--- 14. Which country is having maximum number of buyers?

---- ANSWER---

SELECT 
    country, SUM(productsBought)
FROM
    one
GROUP BY country
ORDER BY SUM(productsBought) DESC
LIMIT 1;
#*****************************************************************************************************************
--- 15. List the name of 10 countries having zero number of sellers.

--- ANSWER----

SELECT 
    country, productsSold
FROM
    one
WHERE
    productsSold = 0
LIMIT 10;
#**********************************************************************************************************************************
--- 16. Display record of top 110 users who have used ecommerce platform recently.

--- ANSWER-------

SELECT * FROM one;

SELECT 
    daysSinceLastLogin Top_Record
FROM
    one
ORDER BY daysSinceLastLogin ASC
LIMIT 110;


-- OR


SELECT 
    *
FROM
    one
ORDER BY daysSinceLastLogin ASC
LIMIT 110;
#**************************************************************************************************************************************

--- 17. Calculate the number of female users those who have not logged in since last 100 days.

--- ANSWER---

SELECT * FROM one;

SELECT 
    gender, COUNT(daysSinceLastLogin)
FROM
    one
WHERE
    gender = 'F'
        AND daysSinceLastLogin > 100;

#*************************************************************************************************************************************
--- 18. Display the number of female users of each country at ecommerce platform.

---- ANSWER----
SELECT 
    country, COUNT(*)
FROM
    one
WHERE
    gender = 'F'
GROUP BY country;

#**************************************************************************************************************************
--- 19. Display the number of male users of each country at ecommerce platform.

--- ANSWER----- 

SELECT 
    country, COUNT(*)
FROM
    one
WHERE
    gender = 'M'
GROUP BY country;
#************************************************************************************************************************
 --- 20. Calculate the average number of products sold and bought on ecommerce platform by male users for each country.

---- ANSWER-----

SELECT 
    country, AVG(productsSold), AVG(productsBought)
FROM
    one
WHERE
    gender = 'M'
GROUP BY country;