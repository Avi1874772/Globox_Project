SELECT g.uid id, 
CASE 
WHEN u.country = 'CAN' THEN 'Canada'
WHEN u.country = 'BRA' THEN 'Brazil'
WHEN u.country = 'FRA' THEN 'France'
WHEN u.country = 'DEU' THEN 'Germany'
WHEN u.country = 'GBR' THEN 'United Kingdom'
WHEN u.country = 'ESP' THEN 'Spain'
WHEN u.country = 'USA' THEN 'United States'
WHEN u.country = 'AUS' THEN 'Australia'
WHEN u.country = 'MEX' THEN 'Mexico'
WHEN u.country = 'TUR' THEN 'Turkey'
ELSE 'NA'
END AS Country,
COALESCE(NULLIF(u.gender, " "), 'N/A') AS Gender,
CASE 
WHEN g.device = 'I' THEN 'IOS'
WHEN g.device = 'A' THEN 'Android'
ELSE 'NA'
END AS Device, g.join_dt AS Date,
g."group", COALESCE(SUM(a.spent), 0) AS Total_spent,
CASE 
WHEN COALESCE(SUM(a.spent),0) > 0 THEN 1
ELSE 0
END Status
FROM "groups" g 
LEFT JOIN activity a ON g.uid = a.uid 
LEFT JOIN users u ON g.uid = u.id 
GROUP BY g.uid, g."group", g.device, u.country, u.gender, g.join_dt;



