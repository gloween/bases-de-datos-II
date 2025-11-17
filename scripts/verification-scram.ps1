Write-Host "=== VERIFICACION FINAL ===" -ForegroundColor Cyan

Set-Location "C:\Users\josem\Documents\6to Semestre\Bases de Datos 2\bases-de-datos-II"

Write-Host "1. Estado de contenedores" -ForegroundColor Yellow
docker ps

Write-Host "2. Configuracion password_encryption" -ForegroundColor Yellow
docker exec primary psql -U postgres -c "SHOW password_encryption;"

Write-Host "3. Verificacion SCRAM en usuario" -ForegroundColor Yellow
docker exec primary psql -U postgres -c "SELECT usename, passwd LIKE 'SCRAM-SHA-256%' as uses_scram FROM pg_shadow WHERE usename = 'replicationUser';"

Write-Host "4. Probando replicacion" -ForegroundColor Yellow
docker exec standby psql -U postgres -c "SELECT client_addr, state FROM pg_stat_replication;" 2>&1

Write-Host "=== VERIFICACION COMPLETADA ===" -ForegroundColor Green