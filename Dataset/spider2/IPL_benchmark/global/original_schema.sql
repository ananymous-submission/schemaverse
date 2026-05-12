CREATE TABLE ball_by_ball(
        match_id INTEGER NOT NULL,
        over_id INTEGER NOT NULL,
        ball_id INTEGER NOT NULL,
        innings_no INTEGER NOT NULL,
        team_batting INTEGER,
        team_bowling INTEGER,
        striker_batting_position INTEGER,
        striker INTEGER,
        non_striker INTEGER,
        bowler INTEGER,
        PRIMARY KEY(match_id, over_id, ball_id, innings_no)
    );

CREATE TABLE batsman_scored(
        match_id INTEGER NOT NULL,
        over_id INTEGER NOT NULL,
        ball_id INTEGER NOT NULL,
        runs_scored INTEGER,
        innings_no INTEGER NOT NULL,
        PRIMARY KEY(match_id, over_id, ball_id, innings_no)
    );

CREATE TABLE extra_runs(
        match_id INTEGER NOT NULL,
        over_id INTEGER NOT NULL,
        ball_id INTEGER NOT NULL,
        extra_type TEXT,
        extra_runs INTEGER,
        innings_no INTEGER NOT NULL,
        PRIMARY KEY(match_id, over_id, ball_id, innings_no)
    );

CREATE TABLE match(
        match_id INTEGER PRIMARY KEY,
        team_1 INTEGER,
        team_2 INTEGER,
        match_date DATE,
        season_id INTEGER,
        venue TEXT,
        toss_winner INTEGER,
        toss_decision TEXT,
        win_type TEXT,
        win_margin INTEGER,
        outcome_type TEXT,
        match_winner INTEGER,
        man_of_the_match INTEGER
    );

CREATE TABLE player(
        player_id INTEGER PRIMARY KEY,
        player_name TEXT,
        dob DATE,
        batting_hand TEXT,
        bowling_skill TEXT,
        country_name TEXT
    );

CREATE TABLE player_match(
        match_id INTEGER NOT NULL,
        player_id INTEGER NOT NULL,
        role TEXT,
        team_id INTEGER,
        PRIMARY KEY(match_id, player_id)
    );

CREATE TABLE team(
        team_id INTEGER PRIMARY KEY,
        name TEXT
    );

CREATE TABLE wicket_taken(
        match_id INTEGER NOT NULL,
        over_id INTEGER NOT NULL,
        ball_id INTEGER NOT NULL,
        player_out INTEGER,
        kind_out TEXT,
        innings_no INTEGER NOT NULL,
        PRIMARY KEY(match_id, over_id, ball_id, innings_no)
    );