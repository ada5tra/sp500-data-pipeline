-- 1. Remove duplicates based on the Symbol
CREATE OR REPLACE TABLE sp500_cleaned AS
SELECT DISTINCT *
FROM sp500_table;

-- 2. Replace null values in 'Price' and 'Market_Cap' with zero (or a more appropriate value, e.g., -1)
UPDATE sp500_cleaned
SET Price = 0
WHERE Price IS NULL;

UPDATE sp500_cleaned
SET Market_Cap = 0
WHERE Market_Cap IS NULL;

-- 3. Replace null values in 'Dividend_Yield' with 0 (assuming no dividend in those cases)
UPDATE sp500_cleaned
SET Dividend_Yield = 0
WHERE Dividend_Yield IS NULL;

-- 4. Standardize the 'Price_Earnings' column to ensure there are no negative values
UPDATE sp500_cleaned
SET Price_Earnings = NULL
WHERE Price_Earnings < 0;

-- 5. Ensure that 'Price' and 'Week_High' values are greater than 0
UPDATE sp500_cleaned
SET Price = NULL
WHERE Price <= 0;

UPDATE sp500_cleaned
SET Week_High = NULL
WHERE Week_High <= 0;

-- 6. Calculate the 'Price_to_Book_Ratio' by dividing 'Price' by 'Price_Book' where 'Price_Book' is not null
UPDATE sp500_cleaned
SET Price_to_Book_Ratio = Price / Price_Book
WHERE Price_Book IS NOT NULL;

-- 7. Flag rows where 'Price' is less than 'Week_Low' (this should not happen)
UPDATE sp500_cleaned
SET Price_Flag = 'Price Below Week Low'
WHERE Price < Week_Low;

-- 8. Check if the 'Earnings_Share' value is negative and flag such rows (they may require further investigation)
UPDATE sp500_cleaned
SET Earnings_Flag = 'Negative Earnings'
WHERE Earnings_Share < 0;

-- 9. Remove rows where the 'Market_Cap' is zero, as it doesn't make sense to have companies with no market capitalization
DELETE FROM sp500_cleaned
WHERE Market_Cap = 0;

-- 10. Add a new column to classify companies as 'Large Cap', 'Mid Cap', or 'Small Cap' based on 'Market_Cap'
ALTER TABLE sp500_cleaned ADD COLUMN Market_Cap_Category STRING;

UPDATE sp500_cleaned
SET Market_Cap_Category = CASE
    WHEN Market_Cap >= 10000000000 THEN 'Large Cap'
    WHEN Market_Cap BETWEEN 2000000000 AND 10000000000 THEN 'Mid Cap'
    ELSE 'Small Cap'
END;

-- 11. Remove any rows where 'SEC_Filings' doesn't contain a valid URL (basic validation on SEC Filing URL format)
DELETE FROM sp500_cleaned
WHERE SEC_Filings NOT LIKE 'http%';

-- 12. Ensure that 'Week_Low' is always less than or equal to 'Week_High' (logical consistency check)
UPDATE sp500_cleaned
SET Week_Low = Week_High
WHERE Week_Low > Week_High;

-- 13. Check if 'Sector' values are valid (this step assumes you know the valid sectors, such as 'Healthcare', 'Technology', etc.)
UPDATE sp500_cleaned
SET Sector = 'Unknown'
WHERE Sector IS NULL OR Sector NOT IN ('Healthcare', 'Technology', 'Finance', 'Consumer Goods', 'Energy', 'Industrial', 'Utilities', 'Real Estate', 'Materials', 'Telecommunication Services', 'Information Technology');

-- Final Step: Verify the transformation by selecting the first 10 records
SELECT * FROM sp500_cleaned LIMIT 10;
