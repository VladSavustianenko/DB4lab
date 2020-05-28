create or replace PROCEDURE add_match ( teamName VARCHAR, seasonPeriod VARCHAR ) AS
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