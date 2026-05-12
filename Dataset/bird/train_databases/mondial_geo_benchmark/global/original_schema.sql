CREATE TABLE "borders"
(
    Country1 TEXT default '' not null
        constraint borders_ibfk_1
            references country,
    Country2 TEXT default '' not null
        constraint borders_ibfk_2
            references country,
    Length   REAL,
    primary key (Country1, Country2)
);

CREATE TABLE "city"
(
    Name       TEXT default '' not null,
    Country    TEXT default '' not null
        constraint city_ibfk_1
            references country
            on update cascade on delete cascade,
    Province   TEXT default '' not null,
    Population INTEGER,
    Longitude  REAL,
    Latitude   REAL,
    primary key (Name, Province),
    constraint city_ibfk_2
        foreign key (Province, Country) references province
            on update cascade on delete cascade
);

CREATE TABLE "continent"
(
    Name TEXT default '' not null
        primary key,
    Area REAL
);

CREATE TABLE "country"
(
    Name       TEXT            not null
        constraint ix_county_Name
            unique,
    Code       TEXT default '' not null
        primary key,
    Capital    TEXT,
    Province   TEXT,
    Area       REAL,
    Population INTEGER
);

CREATE TABLE "desert"
(
    Name      TEXT default '' not null
        primary key,
    Area      REAL,
    Longitude REAL,
    Latitude  REAL
);

CREATE TABLE "economy"
(
    Country     TEXT default '' not null
        primary key
        constraint economy_ibfk_1
            references country
            on update cascade on delete cascade,
    GDP         REAL,
    Agriculture REAL,
    Service     REAL,
    Industry    REAL,
    Inflation   REAL
);

CREATE TABLE "encompasses"
(
    Country    TEXT not null
        constraint encompasses_ibfk_1
            references country
            on update cascade on delete cascade,
    Continent  TEXT not null
        constraint encompasses_ibfk_2
            references continent
            on update cascade on delete cascade,
    Percentage REAL,
    primary key (Country, Continent)
);

CREATE TABLE "ethnicGroup"
(
    Country    TEXT default '' not null
        constraint ethnicGroup_ibfk_1
            references country
            on update cascade on delete cascade,
    Name       TEXT default '' not null,
    Percentage REAL,
    primary key (Name, Country)
);

CREATE TABLE "geo_desert"
(
    Desert   TEXT default '' not null
        constraint geo_desert_ibfk_3
            references desert
            on update cascade on delete cascade,
    Country  TEXT default '' not null
        constraint geo_desert_ibfk_1
            references country
            on update cascade on delete cascade,
    Province TEXT default '' not null,
    primary key (Province, Country, Desert),
    constraint geo_desert_ibfk_2
        foreign key (Province, Country) references province
            on update cascade on delete cascade
);

CREATE TABLE "geo_estuary"
(
    River    TEXT default '' not null
        constraint geo_estuary_ibfk_3
            references river
            on update cascade on delete cascade,
    Country  TEXT default '' not null
        constraint geo_estuary_ibfk_1
            references country
            on update cascade on delete cascade,
    Province TEXT default '' not null,
    primary key (Province, Country, River),
    constraint geo_estuary_ibfk_2
        foreign key (Province, Country) references province
            on update cascade on delete cascade
);

CREATE TABLE "geo_island"
(
    Island   TEXT default '' not null
        constraint geo_island_ibfk_3
            references island
            on update cascade on delete cascade,
    Country  TEXT default '' not null
        constraint geo_island_ibfk_1
            references country
            on update cascade on delete cascade,
    Province TEXT default '' not null,
    primary key (Province, Country, Island),
    constraint geo_island_ibfk_2
        foreign key (Province, Country) references province
            on update cascade on delete cascade
);

CREATE TABLE "geo_lake"
(
    Lake     TEXT default '' not null
        constraint geo_lake_ibfk_3
            references lake
            on update cascade on delete cascade,
    Country  TEXT default '' not null
        constraint geo_lake_ibfk_1
            references country
            on update cascade on delete cascade,
    Province TEXT default '' not null,
    primary key (Province, Country, Lake),
    constraint geo_lake_ibfk_2
        foreign key (Province, Country) references province
            on update cascade on delete cascade
);

CREATE TABLE "geo_mountain"
(
    Mountain TEXT default '' not null
        constraint geo_mountain_ibfk_3
            references mountain
            on update cascade on delete cascade,
    Country  TEXT default '' not null
        constraint geo_mountain_ibfk_1
            references country
            on update cascade on delete cascade,
    Province TEXT default '' not null,
    primary key (Province, Country, Mountain),
    constraint geo_mountain_ibfk_2
        foreign key (Province, Country) references province
            on update cascade on delete cascade
);

CREATE TABLE "geo_river"
(
    River    TEXT default '' not null
        constraint geo_river_ibfk_3
            references river
            on update cascade on delete cascade,
    Country  TEXT default '' not null
        constraint geo_river_ibfk_1
            references country
            on update cascade on delete cascade,
    Province TEXT default '' not null,
    primary key (Province, Country, River),
    constraint geo_river_ibfk_2
        foreign key (Province, Country) references province
            on update cascade on delete cascade
);

CREATE TABLE "geo_sea"
(
    Sea      TEXT default '' not null
        constraint geo_sea_ibfk_3
            references sea
            on update cascade on delete cascade,
    Country  TEXT default '' not null
        constraint geo_sea_ibfk_1
            references country
            on update cascade on delete cascade,
    Province TEXT default '' not null,
    primary key (Province, Country, Sea),
    constraint geo_sea_ibfk_2
        foreign key (Province, Country) references province
            on update cascade on delete cascade
);

CREATE TABLE "geo_source"
(
    River    TEXT default '' not null
        constraint geo_source_ibfk_3
            references river
            on update cascade on delete cascade,
    Country  TEXT default '' not null
        constraint geo_source_ibfk_1
            references country
            on update cascade on delete cascade,
    Province TEXT default '' not null,
    primary key (Province, Country, River),
    constraint geo_source_ibfk_2
        foreign key (Province, Country) references province
            on update cascade on delete cascade
);

CREATE TABLE "isMember"
(
    Country      TEXT default '' not null
        constraint isMember_ibfk_1
            references country
            on update cascade on delete cascade,
    Organization TEXT default '' not null
        constraint isMember_ibfk_2
            references organization
            on update cascade on delete cascade,
    Type         TEXT default 'member',
    primary key (Country, Organization)
);

CREATE TABLE "island"
(
    Name      TEXT default '' not null
        primary key,
    Islands   TEXT,
    Area      REAL,
    Height    REAL,
    Type      TEXT,
    Longitude REAL,
    Latitude  REAL
);

CREATE TABLE "islandIn"
(
    Island TEXT
        constraint islandIn_ibfk_4
            references island
            on update cascade on delete cascade,
    Sea    TEXT
        constraint islandIn_ibfk_3
            references sea
            on update cascade on delete cascade,
    Lake   TEXT
        constraint islandIn_ibfk_1
            references lake
            on update cascade on delete cascade,
    River  TEXT
        constraint islandIn_ibfk_2
            references river
            on update cascade on delete cascade
);

CREATE TABLE "lake"
(
    Name      TEXT default '' not null
        primary key,
    Area      REAL,
    Depth     REAL,
    Altitude  REAL,
    Type      TEXT,
    River     TEXT,
    Longitude REAL,
    Latitude  REAL
);

CREATE TABLE "language"
(
    Country    TEXT default '' not null
        constraint language_ibfk_1
            references country
            on update cascade on delete cascade,
    Name       TEXT default '' not null,
    Percentage REAL,
    primary key (Name, Country)
);

CREATE TABLE "located"
(
    City     TEXT,
    Province TEXT,
    Country  TEXT
        constraint located_ibfk_1
            references country
            on update cascade on delete cascade,
    River    TEXT
        constraint located_ibfk_3
            references river
            on update cascade on delete cascade,
    Lake     TEXT
        constraint located_ibfk_4
            references lake
            on update cascade on delete cascade,
    Sea      TEXT
        constraint located_ibfk_5
            references sea
            on update cascade on delete cascade,
    constraint located_ibfk_2
        foreign key (City, Province) references city
            on update cascade on delete cascade,
    constraint located_ibfk_6
        foreign key (Province, Country) references province
            on update cascade on delete cascade
);

CREATE TABLE "locatedOn"
(
    City     TEXT default '' not null,
    Province TEXT default '' not null,
    Country  TEXT default '' not null
        constraint locatedOn_ibfk_1
            references country
            on update cascade on delete cascade,
    Island   TEXT default '' not null
        constraint locatedOn_ibfk_2
            references island
            on update cascade on delete cascade,
    primary key (City, Province, Country, Island),
    constraint locatedOn_ibfk_3
        foreign key (City, Province) references city
            on update cascade on delete cascade,
    constraint locatedOn_ibfk_4
        foreign key (Province, Country) references province
            on update cascade on delete cascade
);

CREATE TABLE "mergesWith"
(
    Sea1 TEXT default '' not null
        constraint mergesWith_ibfk_1
            references sea
            on update cascade on delete cascade,
    Sea2 TEXT default '' not null
        constraint mergesWith_ibfk_2
            references sea
            on update cascade on delete cascade,
    primary key (Sea1, Sea2)
);

CREATE TABLE "mountain"
(
    Name      TEXT default '' not null
        primary key,
    Mountains TEXT,
    Height    REAL,
    Type      TEXT,
    Longitude REAL,
    Latitude  REAL
);

CREATE TABLE "mountainOnIsland"
(
    Mountain TEXT default '' not null
        constraint mountainOnIsland_ibfk_2
            references mountain
            on update cascade on delete cascade,
    Island   TEXT default '' not null
        constraint mountainOnIsland_ibfk_1
            references island
            on update cascade on delete cascade,
    primary key (Mountain, Island)
);

CREATE TABLE "organization"
(
    Abbreviation TEXT not null
        primary key,
    Name         TEXT not null
        constraint ix_organization_OrgNameUnique
            unique,
    City         TEXT,
    Country      TEXT
        constraint organization_ibfk_1
            references country
            on update cascade on delete cascade,
    Province     TEXT,
    Established  DATE,
    constraint organization_ibfk_2
        foreign key (City, Province) references city
            on update cascade on delete cascade,
    constraint organization_ibfk_3
        foreign key (Province, Country) references province
            on update cascade on delete cascade
);

CREATE TABLE "politics"
(
    Country      TEXT default '' not null
        primary key
        constraint politics_ibfk_1
            references country
            on update cascade on delete cascade,
    Independence DATE,
    Dependent    TEXT
        constraint politics_ibfk_2
            references country
            on update cascade on delete cascade,
    Government   TEXT
);

CREATE TABLE "population"
(
    Country           TEXT default '' not null
        primary key
        constraint population_ibfk_1
            references country
            on update cascade on delete cascade,
    Population_Growth REAL,
    Infant_Mortality  REAL
);

CREATE TABLE "province"
(
    Name       TEXT not null,
    Country    TEXT not null
        constraint province_ibfk_1
            references country
            on update cascade on delete cascade,
    Population INTEGER,
    Area       REAL,
    Capital    TEXT,
    CapProv    TEXT,
    primary key (Name, Country)
);

CREATE TABLE "religion"
(
    Country    TEXT default '' not null
        constraint religion_ibfk_1
            references country
            on update cascade on delete cascade,
    Name       TEXT default '' not null,
    Percentage REAL,
    primary key (Name, Country)
);

CREATE TABLE "river"
(
    Name             TEXT default '' not null
        primary key,
    River            TEXT,
    Lake             TEXT
        constraint river_ibfk_1
            references lake
            on update cascade on delete cascade,
    Sea              TEXT,
    Length           REAL,
    SourceLongitude  REAL,
    SourceLatitude   REAL,
    Mountains        TEXT,
    SourceAltitude   REAL,
    EstuaryLongitude REAL,
    EstuaryLatitude  REAL
);

CREATE TABLE "sea"
(
    Name  TEXT default '' not null
        primary key,
    Depth REAL
);

CREATE TABLE "target"
(
    Country TEXT not null
        primary key
        constraint target_Country_fkey
            references country
            on update cascade on delete cascade,
    Target  TEXT
);