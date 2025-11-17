Write-Host "=== CONFIGURACION SCRAM FINAL ===" -ForegroundColor Cyan

Set-Location "C:\Users\josem\Documents\6to Semestre\Bases de Datos 2\bases-de-datos-II"

Write-Host "1. Configurando SCRAM en primary..." -ForegroundColor Yellow
docker exec primary bash -c "echo 'password_encryption = scram-sha-256' >> /var/lib/postgresql/data/postgresql.conf"

Write-Host "2. Recargando configuracion..." -ForegroundColor Yellow
docker exec primary psql -U postgres -c "SELECT pg_reload_conf();"

Write-Host "3. Actualizando password de replicationUser con SCRAM..." -ForegroundColor Yellow
docker exec primary psql -U postgres -c "ALTER USER replicationUser WITH PASSWORD 'password123';"

Write-Host "4. Verificando configuracion SCRAM..." -ForegroundColor Yellow
docker exec primary psql -U postgres -c "SELECT usename, passwd FROM pg_shadow WHERE usename = 'replicationUser';"

Write-Host "=== CONFIGURACION FINAL COMPLETADA ===" -ForegroundColor Green