SELECT * FROM TABLE(league_package.selectmatch('Manchester City','2012-2013'));
SELECT * FROM TABLE(league_package.selectmatch('Manchester United','2013-2014'));
SELECT * FROM TABLE(league_package.selectmatch('Liverpool','2014-2015));

INSERT  into match(team_home_name, team_away_name, season_period) VALUES ('Dynamo','Shachtar','2010-2011');
INSERT  into match(team_home_name, team_away_name, season_period) VALUES ('Shachtar','Zorya','2010-2011');
INSERT  into match(team_home_name, team_away_name, season_period) VALUES ('Zorya','Dynamo','2010-2011');
