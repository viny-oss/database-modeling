# Start docker
echo 'Starting docker...'
cd dockers
docker pull bitnami/postgresql:10-master
docker-compose up --abort-on-container-exit &
sleep 10
cd ..
echo '...docker finished.'
# Start migrations
echo 'Starting migrations...'
cd scripts
./install.sh
python run_database_migration.py
cd ..
echo '...migrations finished.'
