from cassandra.cluster import Cluster
from cassandra.auth import PlainTextAuthProvider
import os


def main():
    auth_provider = PlainTextAuthProvider(username='cassandra', password='cassandra')
    cluster = Cluster(auth_provider=auth_provider)
    session = cluster.connect()

    for model in os.listdir('../models/'):
        if os.path.isfile('../models/{}'.format(model)):
            with open('../models/{}'.format(model), mode='r') as f:
                txt = f.read()
                stmts = txt.split(';')
                for i in stmts:
                    stmt = i.strip()
                    if stmt != '':
                        print('Executing "' + stmt + '"')
                        session.execute(stmt)


if __name__ == '__main__':
    main()
