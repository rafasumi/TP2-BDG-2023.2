SET search_path TO geodata,public;

CREATE TABLE estacao (
  cod varchar(4) NOT NULL,
  nome varchar(50),
  latitude double precision,
  longitude double precision,
  DiasSecos_2018 double precision,
  DiasSecos_2019 double precision,
  DiasSecos_2020 double precision,
  DiasSecos_2021 double precision,
  DiasSecos_2022 double precision,
  MedUmidMin_2018 double precision,
  MedUmidMin_2019 double precision,
  MedUmidMin_2020 double precision,
  MedUmidMin_2021 double precision,
  MedUmidMin_2022 double precision,
  MedUmidMax_2018 double precision,
  MedUmidMax_2019 double precision,
  MedUmidMax_2020 double precision,
  MedUmidMax_2021 double precision,
  MedUmidMax_2022 double precision,
  geom geometry,
  CONSTRAINT estacao_pkey PRIMARY KEY (cod),
  CONSTRAINT enforce_dims_the_geom CHECK (st_ndims(geom) = 2),
  CONSTRAINT enforce_geotype_geom CHECK (geometrytype(geom) = 'POINT'::text OR geom IS NULL),
  CONSTRAINT enforce_srid_the_geom CHECK (st_srid(geom) = 4326)
);

CREATE INDEX estacao_geom
  ON estacao
  (geom );

COPY estacao(cod,nome,latitude,longitude,DiasSecos_2018,DiasSecos_2019,DiasSecos_2020,DiasSecos_2021,DiasSecos_2022,MedUmidMin_2018,MedUmidMin_2019,MedUmidMin_2020,MedUmidMin_2021,MedUmidMin_2022,MedUmidMax_2018,MedUmidMax_2019,MedUmidMax_2020,MedUmidMax_2021,MedUmidMax_2022) FROM '/tmp/geo_df.csv' DELIMITERS ',' WITH CSV HEADER;

UPDATE estacao
SET geom = ST_GeomFromText('POINT(' || longitude || ' ' || latitude || ')',4326);