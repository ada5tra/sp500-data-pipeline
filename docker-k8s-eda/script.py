#!/usr/bin/env python
# coding: utf-8

# In[10]:


import pandas as pd
import plotly.express as px
import plotly.io as pio

# Set Plotly renderer
pio.renderers.default = 'png'

# Load the dataset
try:
    data = pd.read_csv("constituents-financials.csv")
    print("Dataset loaded successfully!")
except FileNotFoundError:
    print("Error: Dataset not found. Please check the file path and name.")
    exit()

# Data Cleaning and Type Conversion
data['Market Cap'] = data['Market Cap'].astype(float)
data['Price/Earnings'] = pd.to_numeric(data['Price/Earnings'], errors='coerce')  # Convert, handling non-numeric values
data['Price'] = data['Price'].astype(float)
data['Dividend Yield'] = pd.to_numeric(data['Dividend Yield'], errors='coerce')  # Convert Dividend Yield to numeric

# Exploratory Data Analysis
# 1. Top 10 companies by Market Cap
top_companies = data.nlargest(10, 'Market Cap')

# 2. Sector-wise average Price/Earnings ratio
sector_pe_ratio = data.groupby('Sector')['Price/Earnings'].mean().reset_index()

# 3. Sector-wise average Dividend Yield
sector_dividend_yield = data.groupby('Sector')['Dividend Yield'].mean().reset_index()

# Visualisations
# Bar chart: Top 10 companies by Market Cap
fig1 = px.bar(
    top_companies, 
    x='Name', 
    y='Market Cap',
    title="Top 10 Companies by Market Cap",
    labels={'Name': 'Company', 'Market Cap': 'Market Cap (USD)'},
    text='Market Cap'
)
fig1.update_traces(texttemplate='%{text:.2s}', textposition='outside')

# Boxplot: Sector-wise Price/Earnings ratio
fig2 = px.box(
    data, 
    x='Sector', 
    y='Price/Earnings',
    title="Sector-wise Price/Earnings Ratio Distribution",
    labels={'Sector': 'Sector', 'Price/Earnings': 'P/E Ratio'}
)

# Bar chart: Sector-wise average Dividend Yield
fig3 = px.bar(
    sector_dividend_yield,
    x='Sector',
    y='Dividend Yield',
    title="Sector-wise Average Dividend Yield",
    labels={'Sector': 'Sector', 'Dividend Yield': 'Average Dividend Yield'},
    text='Dividend Yield'
)
fig3.update_traces(texttemplate='%{text:.2%}', textposition='outside')  # Show percentage

# Show Plots
print("Displaying plots. 3 HTML files created.")
# Save the figures as HTML files
fig1.write_html("/app/fig1.html")
fig2.write_html("/app/fig2.html")
fig3.write_html("/app/fig3.html")


# In[9]:


data.head()


# In[ ]:




