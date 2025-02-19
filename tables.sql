-- ==============================================
-- SQL Project: Player Engagement & Monetization Analytics for Riot Games
-- Dataset: Steam Video Game Player Stats (Kaggle)
-- Author: Jenny Tran
-- Description: SQL-driven business intelligence analysis 
-- for player retention, revenue, and matchmaking balance.
-- ==============================================

-- 1️⃣ CREATE TABLES
-- Creating the main table for player engagement
CREATE TABLE player_activity (
    app_id INT,  -- Unique game identifier from the dataset
    game_name VARCHAR(255),
    release_date DATE,
    price DECIMAL(5,2),
    positive_reviews INT,
    negative_reviews INT,
    total_players INT,
    avg_playtime INT,  -- Average playtime per session in minutes
    PRIMARY KEY (app_id)
);

-- Creating the revenue table
CREATE TABLE game_revenue (
    app_id INT,
    game_name VARCHAR(255),
    in_game_revenue DECIMAL(10,2),  -- Revenue from in-game purchases
    base_game_sales DECIMAL(10,2),  -- Revenue from the base game
    dlc_sales DECIMAL(10,2),  -- Revenue from additional content
    FOREIGN KEY (app_id) REFERENCES player_activity(app_id)
);

-- Creating the matchmaking table
CREATE TABLE matchmaking_stats (
    match_id SERIAL PRIMARY KEY,
    app_id INT,
    game_name VARCHAR(255),
    win_ratio DECIMAL(5,2),  -- % of games won
    avg_rank INT,  -- Player ranking score
    FOREIGN KEY (app_id) REFERENCES player_activity(app_id)
);

-- Creating a churn table to track retention rates
CREATE TABLE churn_analysis (
    app_id INT,
    game_name VARCHAR(255),
    churn_rate DECIMAL(5,2),  -- % of players who stop playing within 30 days
    FOREIGN KEY (app_id) REFERENCES player_activity(app_id)
);

-- Creating a demographics table for user insights
CREATE TABLE player_demographics (
    app_id INT,
    game_name VARCHAR(255),
    country VARCHAR(50),
    platform VARCHAR(50),
    age_group VARCHAR(50),
    FOREIGN KEY (app_id) REFERENCES player_activity(app_id)
);


