--
-- DO_DB schema
-- ====================
--
CREATE TABLE do_term (
  _id INTEGER PRIMARY KEY,
  do_id VARCHAR(12) NOT NULL UNIQUE,               -- DI ID
  term VARCHAR(255) NOT NULL                  -- textual label for the DO term
);

CREATE TABLE do_synonym (
  _id INTEGER NOT NULL,                     -- REFERENCES do_term
  synonym VARCHAR(255) NOT NULL,                -- label or DO ID
  secondary VARCHAR(12) NULL,                      -- DO ID
  like_do_id SMALLINT,                          -- boolean (1 or 0)
  FOREIGN KEY (_id) REFERENCES do_term (_id)
);


CREATE TABLE do_parents ( 
  _id INTEGER NOT NULL,                     -- REFERENCES do_term
  _parent_id INTEGER NOT NULL,                   -- REFERENCES do_term
  relationship_type VARCHAR(7) NOT NULL,                 -- type of DO child-parent relationship
  FOREIGN KEY (_id) REFERENCES do_term (_id),
  FOREIGN KEY (_parent_id) REFERENCES do_term (_id)
);

CREATE TABLE do_offspring (
  _id INTEGER NOT NULL,                     -- REFERENCES do_term
  _offspring_id INTEGER NOT NULL,                -- REFERENCES do_term
  FOREIGN KEY (_id) REFERENCES do_term (_id),
  FOREIGN KEY (_offspring_id) REFERENCES do_term (_id)
);


CREATE TABLE do_obsolete (
  do_id VARCHAR(12) PRIMARY KEY,                   -- DO ID
  term VARCHAR(255) NOT NULL                   -- textual label for the DO term
)
;

CREATE TABLE map_counts (
  map_name VARCHAR(80) PRIMARY KEY,
  count INTEGER NOT NULL
);

CREATE TABLE map_metadata (
  map_name VARCHAR(80) NOT NULL,
  source_name VARCHAR(80) NOT NULL,
  source_url VARCHAR(255) NOT NULL,
  source_date VARCHAR(20) NOT NULL
);

CREATE TABLE metadata (
  name VARCHAR(80) PRIMARY KEY,
  value VARCHAR(255)
);

-- Indexes

