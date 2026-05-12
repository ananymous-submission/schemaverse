CREATE TABLE Ingredient
(
    ingredient_id INTEGER
            primary key,
    category      TEXT,
    name          TEXT,
    plural        TEXT
);

CREATE TABLE Nutrition
(
    recipe_id     INTEGER
            primary key,
    protein       REAL,
    carbo         REAL,
    alcohol       REAL,
    total_fat     REAL,
    sat_fat       REAL,
    cholestrl     REAL,
    sodium        REAL,
    iron          REAL,
    vitamin_c     REAL,
    vitamin_a     REAL,
    fiber         REAL,
    pcnt_cal_carb REAL,
    pcnt_cal_fat  REAL,
    pcnt_cal_prot REAL,
    calories      REAL,
    foreign key (recipe_id) references Recipe(recipe_id)
);

CREATE TABLE Quantity
(
    quantity_id   INTEGER
            primary key,
    recipe_id     INTEGER,
    ingredient_id INTEGER,
    max_qty       REAL,
    min_qty       REAL,
    unit          TEXT,
    preparation   TEXT,
    optional      TEXT,
    foreign key (recipe_id) references Recipe(recipe_id),
    foreign key (ingredient_id) references Ingredient(ingredient_id),
    foreign key (recipe_id) references Nutrition(recipe_id)
);

CREATE TABLE Recipe
(
    recipe_id  INTEGER
            primary key,
    title      TEXT,
    subtitle   TEXT,
    servings   INTEGER,
    yield_unit TEXT,
    prep_min   INTEGER,
    cook_min   INTEGER,
    stnd_min   INTEGER,
    source     TEXT,
    intro      TEXT,
    directions TEXT
);