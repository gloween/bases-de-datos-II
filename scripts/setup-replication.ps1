Write-Host "=== CONFIGURANDO REPLICACION ===" -ForegroundColor Cyan

Set-Location "C:\Users\josem\Documents\6to Semestre\Bases de Datos 2\bases-de-datos-II"

Write-Host "1. Configurando primary para replicacion..." -ForegroundColor Yellow
docker exec primary bash -c "echo 'wal_level = replica' >> /var/lib/postgresql/data/postgresql.conf"
docker exec primary bash -c "echo 'max_wal_senders = 10' >> /var/lib/postgresql/data/postgresql.conf"
docker exec primary bash -c "echo 'wal_keep_size = 1GB' >> /var/lib/postgresql/data/postgresql.conf"
docker exec primary bash -c "echo 'hot_standby = on' >> /var/lib/postgresql/data/postgresql.conf"

Write-Host "2. Recargando configuracion de primary..." -ForegroundColor Yellow
docker exec primary psql -U postgres -c "SELECT pg_reload_conf();"

Write-Host "3. Verificando configuracion de replicacion..." -ForegroundColor Yellow
docker exec primary psql -U postgres -c "SHOW wal_level; SHOW max_wal_senders;"

Write-Host "=== CONFIGURACION DE REPLICACION COMPLETADA ===" -ForegroundColor Green