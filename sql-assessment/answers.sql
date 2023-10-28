--Write a query to get the sum of impressions by day.
SELECT SUM(impressions)
FROM marketing_performance
GROUP BY date;

--Write a query to get the top three revenue-generating states in order of best to worst. How much revenue did the third best state generate?
SELECT state
FROM website_revenue
GROUP BY state
ORDER BY SUM(revenue) DESC
LIMIT 3;

--the third best state was OH, which generated 37577 in revenue
SELECT SUM(revenue)
FROM website_revenue
WHERE state = 'OH'
GROUP BY state;

--Write a query that shows total cost, impressions, clicks, and revenue of each campaign. Make sure to include the campaign name in the output.
SELECT ci.name, SUM(mp.cost), SUM(mp.impressions), SUM(mp.clicks), SUM(wr.revenue)
FROM campaign_info ci
  INNER JOIN marketing_performance mp on ci.id = mp.campaign_id
  INNER JOIN website_revenue wr on mp.campaign_id = wr.campaign_id
GROUP BY ci.name;

--Write a query to get the number of conversions of Campaign5 by state. Which state generated the most conversions for this campaign?
SELECT wr.state, SUM(mp.conversions)
FROM website_revenue wr
  INNER JOIN marketing_performance mp on wr.campaign_id = mp.campaign_id
  INNER JOIN campaign_info ci on mp.campaign_id = ci.id
WHERE ci.name = 'Campaign5'
GROUP BY state
ORDER BY SUM(mp.conversions) DESC;

--GA generated the most conversions for this campaign

--In your opinion, which campaign was the most efficient, and why?
--In my opinion, Campaign5 was the most efficient because it had the highest return on investment, calculated by (revenue - cost) / cost.

--Write a query that showcases the best day of the week (e.g., Sunday, Monday, Tuesday, etc.) to run ads.
SELECT DATENAME(dw, date) AS dayofweek
FROM marketing_performance
GROUP BY DATENAME(dw, date)
ORDER BY SUM(conversions) DESC
LIMIT 1;

--using conversions as the determining kpi
