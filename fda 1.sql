USE fda;
SELECT 
	YEAR(ActionDate) AS Approval_Year,
	COUNT(*) AS number_of_drugs_approved
FROM regactiondate
GROUP BY 1
ORDER BY 1;
-- Identify the top three years that got the highest and lowest approvals, in descending and ascending order, respectively
SELECT 
	YEAR(ActionDate) AS Approval_Year, 
    COUNT(*) AS number_of_drugs_approved
FROM regactiondate
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3;

SELECT 
	YEAR(ActionDate) AS Approval_Year, 
    COUNT(*) AS number_of_drugs_approved
FROM regactiondate
GROUP BY 1
ORDER BY 2 
LIMIT 3;

-- Explore approval trends over the years based on sponsors
SELECT 
	YEAR(ActionDate) AS approval_year, 
    SponsorApplicant, COUNT(*) AS num_drugs_approved
FROM regactiondate
	LEFT JOIN application 
		ON regactiondate.ApplNo = application.ApplNo
GROUP BY 1, 
		application.SponsorApplicant
ORDER BY 1,
		2 DESC;

-- Rank sponsors based on the total number of approvals they received each year between 1939 and 1960.
SELECT 
	YEAR(ActionDate) AS Approval_Year,
    SponsorApplicant, 
    COUNT(*) AS Num_Drugs_Approved
FROM regactiondate
	LEFT JOIN application 
		ON regactiondate.ApplNo = application.ApplNo
WHERE regactiondate.ActionDate BETWEEN '1939-01-01' AND '1960-12-31'
GROUP BY 1, 
		 2
ORDER BY 	1, 
			3 DESC;
            
            SELECT 
	ProductMktStatus, 
    COUNT(*) AS num_products
FROM product
GROUP BY ProductMktStatus;

-- Calculate the total number of applications for each MarketingStatus year-wise after the year 2010.
SELECT 
	YEAR(ActionDate) AS application_year, 
    ProductMktStatus, 
    COUNT(*) AS num_applications
FROM regactiondate
	LEFT JOIN product 
    ON regactiondate.ApplNo = product.ApplNo
WHERE YEAR(ActionDate) > 2010
GROUP BY 1, 
		 2
ORDER BY 1, 
		3 DESC;

-- Identify the top MarketingStatus with the maximum number of applications and analyze its trend over time.
SELECT 
	ProductMktStatus, 
    YEAR(ActionDate) AS application_year, 
    COUNT(*) AS num_applications
FROM regactiondate
	LEFT JOIN product 
		ON regactiondate.ApplNo = product.ApplNo
GROUP BY   	1,
			2
ORDER BY 3 DESC
LIMIT 5;

SELECT 
	Dosage,
    COUNT(*) AS num_products
FROM product
GROUP BY 1
ORDER BY 2 DESC;

-- Calculate the total number of approvals for each dosage form and identify the most successful forms.
SELECT 
	Dosage,
    COUNT(*) AS num_approvals
FROM product
	LEFT JOIN application 
		ON product.ApplNo = application.ApplNo
WHERE application.ActionType = "AP"
GROUP BY 1
ORDER BY 2 DESC;

-- Investigate yearly trends related to successful forms.
SELECT 
	YEAR(ActionDate) AS approval_year, 
    Dosage,
    COUNT(*) AS num_approvals
FROM regactiondate
	LEFT JOIN product
		ON regactiondate.ApplNo = product.ApplNo
WHERE regactiondate.ActionType = "AP"
GROUP BY 1,
		 2
ORDER BY 1, 
		 3 DESC;
        
        SELECT 
	TECode,
    COUNT(*) AS num_approvals
FROM product_tecode
	LEFT JOIN regactiondate 
		ON product_tecode.ApplNo = regactiondate.ApplNo
WHERE ActionType = "AP"
GROUP BY 1
ORDER BY 2 DESC;

-- Determine the therapeutic evaluation code (TE_Code) with the highest number of Approvals in each year.
SELECT 
	YEAR(ActionDate) AS approval_year, 
    TECode, 
    COUNT(*) AS num_approvals
FROM regactiondate 
	LEFT JOIN product_tecode
		ON regactiondate.ApplNo = product_tecode.ApplNo
WHERE ActionType = "AP"
GROUP BY 1,
		 2
ORDER BY 1,
		 2 DESC;
        