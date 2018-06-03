CREATE KEYSPACE IF NOT EXISTS users
  WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 3};

CREATE TABLE IF NOT EXISTS users.users (
  id uuid PRIMARY KEY,
  created_at timestamp,
  updated_at timestamp,
  deleted_at timestamp, --- default value: 0 which mean not destroyed
  username text,
  email text,
  password text,
  firstname text,
  lastname text
) WITH compaction = { 'class' : 'LeveledCompactionStrategy' };

CREATE TABLE IF NOT EXISTS users.addresses (
  id uuid PRIMARY KEY,
  user_id uuid,
  created_at timestamp,
  updated_at timestamp,
  deleted_at timestamp, --- default value: 0 which mean not destroyed
  name text,
  line1 text,
  line2 text,
  line3 text,
  city text,
  postalcode text,
  country text
) WITH compaction = { 'class' : 'LeveledCompactionStrategy' };
