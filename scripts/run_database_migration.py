import psycopg2
import os


def migrate_models():
    conn = psycopg2.connect(
        dbname="viny",
        user="admin",
        password="password123",
        host="localhost",
        port=5432
    )
    conn.autocommit = True
    cur = conn.cursor()

    cur.execute("""
        CREATE TABLE IF NOT EXISTS migrations (
            version SMALLINT NOT NULL
        );
        SELECT version FROM migrations LIMIT 1;
    """)

    actual_version = cur.fetchone()
    if actual_version is None:
        print('First deployment, starting from migration 000')
        actual_version = 0
    else:
        print('Starting deployment from migration {}'.format(actual_version[0]))
    actual_version = int(actual_version[0])
    version = 0

    models = os.listdir('../models/')
    models.sort()
    for model in models:
        filename = '../models/{}'.format(model)
        version = int(filename.split('/')[2].split('_')[0])
        if version <= actual_version:
            continue
        print('Executing statements in file {}'.format(filename))
        if os.path.isfile(filename):
            with open(filename, mode='r') as f:
                txt = f.read()
                stmts = txt.split(';')
                for i in stmts:
                    stmt = i.strip()
                    if stmt != '':
                        print('Executing "' + stmt + '"')
                        cur.execute(stmt)

    cur.execute("""
        DELETE FROM migrations;
        INSERT INTO migrations (version) VALUES ('{}');
    """.format(version))

    cur.execute("""
        SELECT table_schema, table_name, table_type
            FROM information_schema.tables
            WHERE table_schema <> 'pg_catalog' AND
                table_schema <> 'information_schema'
            ORDER BY table_schema ASC, table_name ASC;
    """)
    tables = cur.fetchall()
    print('Tables in database:')
    for table in tables:
        print('\t{}: {}.{}'.format(table[2], table[0], table[1]))


if __name__ == '__main__':
    migrate_models()
