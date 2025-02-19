-- 3️⃣ PLAYER ENGAGEMENT ANALYSIS
-- Retention Rate Calculation
SELECT 
    game_name,
    total_players,
    ROUND(100.0 * SUM(CASE WHEN avg_playtime > 30 THEN 1 ELSE 0 END) / COUNT(*), 2) AS retention_30_min_plus,
    ROUND(100.0 * SUM(CASE WHEN avg_playtime > 120 THEN 1 ELSE 0 END) / COUNT(*), 2) AS retention_2hr_plus
FROM player_activity
GROUP BY game_name
ORDER BY retention_30_min_plus DESC;

-- 4️⃣ REVENUE ANALYSIS
-- Top Revenue-Generating Games
SELECT 
    g.game_name,
    SUM(g.in_game_revenue + g.base_game_sales + g.dlc_sales) AS total_revenue
FROM game_revenue g
GROUP BY g.game_name
ORDER BY total_revenue DESC
LIMIT 10;

-- Average Revenue Per User (ARPU)
SELECT 
    g.game_name,
    ROUND(SUM(g.in_game_revenue + g.base_game_sales + g.dlc_sales) / COUNT(p.total_players), 2) AS avg_revenue_per_user
FROM game_revenue g
JOIN player_activity p ON g.app_id = p.app_id
GROUP BY g.game_name
ORDER BY avg_revenue_per_user DESC
LIMIT 10;

-- 5️⃣ MATCHMAKING ANALYSIS
-- Checking Fairness in Competitive Play
SELECT 
    game_name,
    ROUND(AVG(win_ratio), 2) AS avg_win_ratio,
    COUNT(match_id) AS total_matches
FROM matchmaking_stats
GROUP BY game_name
HAVING AVG(win_ratio) BETWEEN 45 AND 55
ORDER BY total_matches DESC;

-- 6️⃣ CHURN ANALYSIS
-- Player Churn Rate
SELECT 
    game_name,
    ROUND(AVG(churn_rate), 2) AS avg_churn_rate
FROM churn_analysis
GROUP BY game_name
ORDER BY avg_churn_rate DESC;

-- 7️⃣ DEMOGRAPHIC ANALYSIS
-- Player Distribution by Platform
SELECT 
    platform,
    COUNT(DISTINCT app_id) AS total_games
FROM player_demographics
GROUP BY platform
ORDER BY total_games DESC;

-- Player Age Group Distribution
SELECT 
    age_group,
    COUNT(DISTINCT app_id) AS total_games
FROM player_demographics
GROUP BY age_group
ORDER BY total_games DESC;