# 📦 The Look E-Commerce Analysis (2019–2025)

## 📌 Project Overview

**The Look**, an established e-commerce clothing retailer in the online fashion industry, has been operating for several years and maintains a rich dataset covering **2019 to 2025**. The business uses a traditional direct-to-consumer model, selling apparel exclusively through its digital storefront.

The company collects extensive data across **sales, customers, product ranges, marketing activity, inventory, distribution, and site performance**, much of this information has been historically underutilized. This project aims to analyse and synthesise these datasets to uncover actionable insights that can help drive **The Look’s overall business growth and performance**.

**Insights and recommendations are provided on the following key areas:**

- **Sales Trend Analysis:** Assessment of historical sales behaviour across regions, with a focus on Revenue, Order Volume, and Average Order Value (AOV).
- **Product Performance:** Evaluation of product categories to understand their contribution and impact on overall sales.
- **Customer Segmentation:** Demographic breakdown of customers by age and gender to identify key buyer groups.
- **Regional Performance:** Analysis of sales and order distribution across geographic regions.
- **Marketing Channels:** Identification of traffic sources and their contribution to sales performance.

## 🔗 Project Resources

- **Data Quality Check**: The SQL queries used to inspect and clean the data for this analysis can be found here [[link](https://docs.google.com/spreadsheets/d/1TnQysry7-BT1Gp438DsQV8-yNDu4toQbPGkzGbxSLuE/edit?usp=sharing)].
- **SQL Queries**: Targeted SQL queries regarding various business questions can be found here [[link](https://sky-wallet-913.notion.site/The-Look-E-Commerce-Analysis-Process-2bfa50407d03808e9936fa2df736b00d?source=copy_link)].
- **Looker Studio Report**: An interactive Looker Studio report to explore sales trends can be found here [[link](https://lookerstudio.google.com/reporting/650d7b66-7918-4d10-b463-5d4222c2aab1)].
- **Stakeholder Presentation**: Prepared a stakeholder presentation to highlight key insights and recommendations here [[link](https://docs.google.com/presentation/d/1zHow1BogWJdY0-oY386aHfhq5j_6OE0UYpBaHYTPwRw/edit?usp=sharing)]

## 🗂️ Data Structure & Initial Checks

**The Look** database structure as seen below consists of four tables: **`orders`**, **`order_items`**, **`products`**, **`users`**, with an approximate total row count of 182K records. A description of each table is as follows:

<img width="1010" height="613" alt="The Look ERD" src="https://github.com/user-attachments/assets/807203f2-61dd-4b18-bfcb-145f327730ac" />

**Note**: I will be focusing on these tables for now. Other available tables will be in the future analysis.

Prior to beginning the analysis, a variety of checks were conducted for quality control and familiarization with the datasets. The SQL queries utilised to inspect and perform **quality checks** can be found [**here**](https://docs.google.com/spreadsheets/d/1TnQysry7-BT1Gp438DsQV8-yNDu4toQbPGkzGbxSLuE/edit?usp=sharing).

## 📈 Executive Summary

### 🔍 Overview of Findings
**Significant sales spikes were observed in 2025** during Feb - Mar (~109K),  Sep–Oct (~123K), and Oct–Nov (~180K), with the **Oct–Nov period showing the largest growth to date**. Key performance indicators (KPIs) also highlight strong **year-over-year improvements** compared to the previous period: revenue by 85.7%, order volume by 91% and customers count by 85.7%. Despite these positive gains, the **Average Order Value (AOV) declined by 2.8%**. The following sections take a deeper look into the drivers behind the strong growth in revenue, order volume, and customers, while also exploring the factors contributing to the decline in AOV

Below is the overview page from the **Looker Studio report** and more examples included throughout the report. The entire interactive report can be accessed [here](https://lookerstudio.google.com/reporting/650d7b66-7918-4d10-b463-5d4222c2aab1).

<img width="997" height="741" alt="overview" src="https://github.com/user-attachments/assets/23c0c1b1-16f5-4fcb-9387-317252f23bab" />

**📉 Sales Trends**

- **Total sales revenue from 2019 to 2025 ~$905K**, ranging in monthly sales $0.8k to $908K.
- **Significant spikes in sales are observed in 2025** during Feb - Mar (~109K),  Sep–Oct (~123K), and Oct–Nov (~180K), with the Oct–Nov period showing the largest growth to date.
- There was a **noticeable dip in Jan to Feb 2025**, It was also seen in Jan to Feb 2022, it might be a seasonailty or global trend.
- Despite the notable dip in January to February 2025, **March showed a strong recovery with a ~109K increase.**
- In 2025, the **Average Order Value (AOV) showed only slight year-over-year increases** in May and September. This trend may be influenced by factors such as heavy promotional activity, shifts in customer demographics, and an increased share of purchases involving lower-priced items.
- **Search** is the main driver of revenue compared from the other traffic sources.
  
<img width="886" height="385" alt="yoy" src="https://github.com/user-attachments/assets/b2c701b0-5e61-4d35-9efb-de06c1feeaed" />

<img width="1104" height="324" alt="yoy aov" src="https://github.com/user-attachments/assets/f60f1c9b-7c2f-47a6-a503-8dfff3bd739d" />

**🛍️ Product Performance**

- With **63% of the order volume** comes from the 10 out of 23 product categories, these categories accounts for 10M in revenue, 71% of the total.
- The dip in Jan to 2022 and Jan to Feb 2025 was primarily driven by **Outerwear & Coats**.
- For Outerwear & Coats, the decline during these periods: Jan to Feb 2022 and Jan to Feb 2025 were primarily seen in **APAC and NA region** and driven by **Search traffic source,** may suggest weaker customer interest, seasonality effects, or reduced visibility in search channels during that period.
- **Male seniors aged 56 and above** were the primary contributors to the January to February 2022 & 2025 decline in Outerwear & Coats, suggesting possible seasonal behavior, a drop in interest, or a weaker product fit for this age group.
- **All product categories saw significant increases over time, with the exception of Clothing Sets**, which exhibited an unstable trend. This points to Clothing Sets being one of the weaker performers.
- Clothing sets generated minimal revenue, making up **only 0.18% of total sales**.

<img width="536" height="335" alt="category 1" src="https://github.com/user-attachments/assets/2041c77e-97ca-4ff3-984b-5dd6ed0a3050" />
<img width="545" height="339" alt="category 2" src="https://github.com/user-attachments/assets/9fd867ab-0c72-4962-b17d-96fdd6457212" />

**💡Recommendations**

Based on the uncovered insights, the following recommendations have been provided.

- The Jan to Feb 2022 and 2025 dip suggests seasonal effects. Consider planning assortments and stock levels that match **regional seasonality (especially APAC & NA)**.
- Since **male seniors (56+) were the main contributors to the decline**, review whether current styles, fits, colours, and pricing align with their preferences. Consider introducing more classic, functional, or premium options if gaps exist.
- Conduct a **deeper analysis to identify which brands** are driving the decline, and categorize them into budget, mid-tier, and premium segments to gain more detailed insights.
- **Strengthen Search Strategy**
    - improving SEO for Outerwear & Coats (keywords, metadata, product tagging)
    - adjusting paid search targeting to reach older male audiences
    - refreshing ad creatives to highlight benefits relevant to seniors (comfort, durability, functionality)
- Since **Search drives the highest revenue**, prioritize investments in SEO and paid search rather than spreading budget evenly.
- Revisit the **marketing strategy in clothing sets** that makes only the **0.16% of the revenue**. It may be worth discontinuing the Clothing Sets category, given that its revenue showed minimal improvement over six years, rising only from $128 to $1,336.
- Follow up with the data engineering team to confirm the channel mapping, as **“Search” currently accounts for approximately 56% to 82% of revenue**. If this bucket represents paid search, the business may be heavily over-relying on high-cost acquisition channels. Paid search typically should not exceed 30–35% of revenue to avoid inflated CAC, and the ideal range is around 10–25%. A dependency this high could indicate an unstable and expensive acquisition mix.
- Reduce spend on keywords with **high CAC but low LTV**. Shift budget toward more cost-efficient channels.
- For other sources, **grow email** through list building, segmentation and automated flows. **Enhance Facebook** retargeting and explore Display or native ads for top-level awareness.

## ⚠️ **Assumptions and Caveats:**

Throughout the analysis, multiple assumptions were made to manage challenges with the data. These assumptions and caveats are noted below:

- Trends observed in the dataset are assumed to reflect normal business patterns, with no major disruptions.
- Since purchase date (created_at) contains future dates, the ingested data for analysis is filter up to the current date.
- Revenue is attributed to channels based on the last-click or the reporting model used by the platform, and this is assumed consistent across the period.
- Potential Traffic Source Misclassification: Search (Paid) has a fairly large contribution to the revenue.
- Analysis does not account for detailed spend by campaign, which limits insights into cost-efficiency of channels.
