Write-Host "=== CREANDO USUARIO REPLICATIONUSER ===" -ForegroundColor Cyan

Set-Location "C:\Users\josem\Documents\6to Semestre\Bases de Datos 2\bases-de-datos-II"

Write-Host "1. Creando usuario replicationUser..." -ForegroundColor Yellow
docker exec primary psql -U postgres -c "CREATE USER replicationUser WITH REPLICATION PASSWORD 'password123';"

Write-Host "2. Verificando usuario creado..." -ForegroundColor Yellow
docker exec primary psql -U postgres -c "SELECT usename, usesuper, userepl FROM pg_user WHERE usename = 'replicationUser';"

Write-Host "3. Otorgando permisos..." -ForegroundColor Yellow
docker exec primary psql -U postgres -c "ALTER USER replicationUser WITH REPLICATION;"

Write-Host "=== USUARIO CREADO EXITOSAMENTE ===" -ForegroundColor Green