create or replace TRIGGER team_check
BEFORE INSERT
    ON team FOR EACH ROW
    WHEN ( new.team_name IS NULL )
BEGIN :new.team_name := 'Undefined';
END;