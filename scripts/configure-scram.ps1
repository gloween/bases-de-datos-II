Write-Host "CONFIGURACION SCRAM-256" -ForegroundColor Cyan

Set-Location "C:\Users\josem\Documents\6to Semestre\Bases de Datos 2\bases-de-datos-II"

Write-Host "Deteniendo contenedores anteriores" -ForegroundColor Yellow
docker-compose stop primary standby replica
docker-compose rm -f primary standby replica

Write-Host "Iniciando contenedores" -ForegroundColor Yellow
docker-compose up -d primary standby replica

Write-Host "Esperando 10 s" -ForegroundColor Yellow
Start-Sleep -Seconds 10

Write-Host "4. Verificando estado" -ForegroundColor Yellow
docker ps

docker exec primary bash -c "echo 'password_encryption = scram-sha-256' >> /var/lib/postgresql/data/pgdata/postgresql.conf"

docker exec primary psql -U postgres -c "SELECT pg_reload_conf();"

docker exec primary psql -U postgres -c "ALTER USER replicationUser WITH PASSWORD 'password123';"

docker exec primary psql -U postgres -c "SELECT usename, passwd FROM pg_shadow WHERE usename = 'replicationUser';"

Write-Host "Completado" -ForegroundColor Green