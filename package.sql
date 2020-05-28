CREATE OR REPLACE PACKAGE league_package IS TYPE row_match IS RECORD (
        team_home_name      team.team_home_name%TYPE,
        team_away_name   team.team_away_name%TYPE,
        season_period team.season_period%TYPE
);
    TYPE tblteam IS TABLE OF row_match;
    FUNCTION chooseproject ( teamName VARCHAR, seasonPeriod VARCHAR ) RETURN tblteam PIPELINED;
    PROCEDURE add_match ( teamName VARCHAR, seasonPeriod VARCHAR );
END league_package;
/

create or replace PACKAGE BODY league_package IS
   PROCEDURE add_match ( teamName VARCHAR, seasonPeriod VARCHAR ) AS
    teamstate NUMBER;
    seasonstate NUMBER;
    none_data EXCEPTION;
BEGIN SELECT COUNT(*)INTO teamstate
    FROM team
    WHERE team_name LIKE teamName;
    SELECT COUNT(*) INTO seasonstate
    FROM season
    WHERE season_period LIKE seasonPeriod;
    IF (teamstate = 1) and (seasonstate = 1)
		THEN
			UPDATE team
			SET team_name = teamName
			WHERE season_period = seasonPeriod;
    ELSE
        RAISE none_data;
    END IF;
EXCEPTION
    WHEN none_data
		THEN
			dbms_output.put_line('No such team or season in the database');
    WHEN OTHERS THEN
        dbms_output.put_line('Error - ' || sqlcode || ' : ' || sqlerrm);
END;

FUNCTION selectmatch ( teamName VARCHAR ) RETURN tblteam PIPELINED IS
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
END;

