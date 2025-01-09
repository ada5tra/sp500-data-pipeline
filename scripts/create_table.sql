CREATE OR REPLACE TABLE sp500_table (
  Symbol STRING,
  Name STRING,
  Sector STRING,
  Price NUMBER,
  Price_Earnings NUMBER,
  Dividend_Yield NUMBER,
  Earnings_Share NUMBER,
  Week_Low NUMBER,
  Week_High NUMBER,
  Market_Cap NUMBER (20, 2),
  EBITDA NUMBER,
  Price_Sales NUMBER,
  Price_Book NUMBER,
  SEC_Filings STRING
);
