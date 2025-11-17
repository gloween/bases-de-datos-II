Write-Host "=== VERIFICANDO USUARIO REPLICATIONUSER ===" -ForegroundColor Cyan

Set-Location "C:\Users\josem\Documents\6to Semestre\Bases de Datos 2\bases-de-datos-II"

Write-Host "1. Verificando usuario en pg_user..." -ForegroundColor Yellow
docker exec primary psql -U postgres -c "SELECT usename, usesuper, userepl FROM pg_user WHERE usename = 'replicationuser';"

Write-Host "2. Verificando usuario en pg_shadow..." -ForegroundColor Yellow
docker exec primary psql -U postgres -c "SELECT usename, passwd FROM pg_shadow WHERE usename = 'replicationuser';"

Write-Host "3. Verificando con nombre exacto (case-sensitive)..." -ForegroundColor Yellow
docker exec primary psql -U postgres -c "SELECT usename FROM pg_user WHERE usename = 'replicationUser';"

Write-Host "=== VERIFICACION COMPLETADA ===" -ForegroundColor Green