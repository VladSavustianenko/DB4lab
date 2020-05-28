CREATE TYPE row_match IS OBJECT (
        team_home_name VARCHAR2(50 BYTE),
        team_away_name VARCHAR2(50 BYTE),
        season_period VARCHAR2(20 BYTE)
    );
/
CREATE TYPE tblteam IS TABLE OF row_match;
/
CREATE OR REPLACE FUNCTION selectmatch ( teamName VARCHAR ) RETURN tblteam PIPELINED IS
CURSOR tbl IS
	(SELECT team_name
	FROM team
	WHERE team_name = teamName);
col_type row_match;
BEGIN FOR res IN tbl LOOP
	col_type.team_home_name := res.team_home_name;
	col_type.team_away_name := res.team_away_name;
	col_type.season_period := res.season_period;
	PIPE ROW ( col_type );
END LOOP;
END;
