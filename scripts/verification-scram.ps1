Write-Host "=== VERIFICACION FINAL COMPLETA ===" -ForegroundColor Cyan

Set-Location "C:\Users\josem\Documents\6to Semestre\Bases de Datos 2\bases-de-datos-II"

Write-Host "1. Estado de contenedores PostgreSQL" -ForegroundColor Yellow
docker ps | findstr "primary standby replica"

Write-Host "2. Configuracion password_encryption" -ForegroundColor Yellow
docker exec primary psql -U postgres -c "SHOW password_encryption;"

Write-Host "3. Usuario replicationUser y metodo SCRAM" -ForegroundColor Yellow
docker exec primary psql -U postgres -c "SELECT usename, passwd FROM pg_shadow WHERE usename = 'replicationUser';"

Write-Host "4. Verificando que el password usa SCRAM..." -ForegroundColor Yellow
docker exec primary psql -U postgres -c "SELECT usename, passwd LIKE 'SCRAM-SHA-256%' as uses_scram FROM pg_shadow WHERE usename = 'replicationUser';"

Write-Host "5. Estado de replicacion" -ForegroundColor Yellow
docker exec primary psql -U postgres -c "SELECT client_addr, application_name, state, sync_state FROM pg_stat_replication;"

Write-Host "6. Configuracion WAL" -ForegroundColor Yellow
docker exec primary psql -U postgres -c "SHOW wal_level; SHOW max_wal_senders;"

Write-Host "7. Probando conexiones entre nodos" -ForegroundColor Yellow
Write-Host "   Desde standby a primary:" -ForegroundColor White
docker exec standby psql -h primary -U replicationUser -d postgres -c "SELECT 'Conexion exitosa desde standby' as status;" 2>&1

Write-Host "   Desde replica a primary:" -ForegroundColor White
docker exec replica psql -h primary -U replicationUser -d postgres -c "SELECT 'Conexion exitosa desde replica' as status;" 2>&1

Write-Host "=== VERIFICACION COMPLETADA ===" -ForegroundColor Green