create database cloud;

use cloud;
Select * from customers;
-- Total customers by billing cycle
SELECT 'Billing Cycle', COUNT(*) as CustomerCount
FROM customers
GROUP BY 'Billing Cycle';

Select * from VM;

Select * from services;

-- VM Resource Usage by OS
SELECT 
    'VM OS',
    COUNT(*) AS 'VM Count',
    AVG('VM RAM (GB)') AS Avg_RAM_GB,
    AVG('VM Storage (GB)') AS Avg_Storage_GB,
    AVG('VM CPU (Cores)') AS Avg_CPU_Cores,
    AVG('Monthly Cost (VM)') AS Avg_Monthly_Cost
FROM VM
GROUP BY 'VM OS';

-- Total Revenue per Customer (VMs + Services)
SELECT 
    c.`Customer ID`,
    c.`Customer Name`,
    COALESCE(SUM(v.`Total Billed (VM)`), 0) AS Total_VM_Billed,
    COALESCE(SUM(s.`WAF Total` + s.`Firewall Total` + s.`DNS Total` + s.`Mail Total`), 0) AS Total_Services_Billed,
    COALESCE(SUM(v.`Total Billed (VM)`), 0) + COALESCE(SUM(s.`WAF Total` + s.`Firewall Total` + s.`DNS Total` + s.`Mail Total`), 0) AS Total_Revenue
FROM Customers c
LEFT JOIN VM v ON c.`Customer ID` = v.`Customer ID`
LEFT JOIN services s ON c.`Customer ID` = s.`Customer ID`
GROUP BY c.`Customer ID`, c.`Customer Name`
ORDER BY Total_Revenue DESC;

-- Service Adoption by Customer
SELECT 
    c.`Customer ID`,
    c.`Customer Name`,
    COALESCE(SUM(s.`WAF Qty`), 0) AS WAF_Qty,
    COALESCE(SUM(s.`Firewall Qty`), 0) AS Firewall_Qty,
    COALESCE(SUM(s.`DNS Qty`), 0) AS DNS_Qty,
    COALESCE(SUM(s.`Mail Qty`), 0) AS Mail_Qty
FROM Customers c
LEFT JOIN Services s ON c.`Customer ID` = s.`Customer ID`
GROUP BY c.`Customer ID`, c.`Customer Name`;


-- Monthly Revenue Trend
SELECT 
    YEAR(c.`Start Date`) AS Year,
    MONTH(c.`Start Date`) AS Month,
    COALESCE(SUM(v.`Total Billed (VM)`) / NULLIF(AVG(c.`Months Active`), 0), 0) AS Avg_Monthly_VM_Revenue,
    COALESCE(
        (
            SUM(s.`WAF Total`) +  
            SUM(s.`Firewall Total`) +  
            SUM(s.`DNS Total`) +  
            SUM(s.`Mail Total`)
        ) / NULLIF(AVG(c.`Months Active`), 0), 0
    ) AS Avg_Monthly_Services_Revenue
FROM Customers c
LEFT JOIN VM v ON c.`Customer ID` = v.`Customer ID`
LEFT JOIN Services s ON c.`Customer ID` = s.`Customer ID`
GROUP BY YEAR(c.`Start Date`), MONTH(c.`Start Date`)
ORDER BY Year, Month
LIMIT 0, 1000;

-- Expiry check
SELECT 
    `Customer ID`, 
    `Customer Name`, 
    `Expiry Date`, 
    TIMESTAMPDIFF(MONTH, CURDATE(), `Expiry Date`) AS Months_Until_Expiry
FROM Customers
WHERE TIMESTAMPDIFF(MONTH, CURDATE(), `Expiry Date`) <= 6 AND `Expiry Date` >= CURDATE()
ORDER BY `Expiry Date` LIMIT 0, 1000;

ALTER TABLE customers
ADD Months_Until_Expiry INT;

SET SQL_SAFE_UPDATES = 0;

UPDATE customers
SET Months_Until_Expiry = GREATEST( TIMESTAMPDIFF(MONTH, CURDATE(), `Expiry Date`),0);

SET SQL_SAFE_UPDATES = 1; 

ALTER TABLE customers
DROP  Months_Until_Expiry ;