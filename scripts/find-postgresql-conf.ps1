Write-Host "=== BUSCANDO ARCHIVOS DE CONFIGURACION ===" -ForegroundColor Cyan

Write-Host "1. Buscando postgresql.conf en primary..." -ForegroundColor Yellow
docker exec primary find / -name "postgresql.conf" 2>/dev/null

Write-Host "2. Buscando postgresql.conf en standby..." -ForegroundColor Yellow
docker exec standby find / -name "postgresql.conf" 2>/dev/null

Write-Host "3. Buscando postgresql.conf en replica..." -ForegroundColor Yellow
docker exec replica find / -name "postgresql.conf" 2>/dev/null

Write-Host "4. Verificando directorio de datos en primary..." -ForegroundColor Yellow
docker exec primary ls -la /var/lib/postgresql/data/

Write-Host "=== BUSQUEDA COMPLETADA ===" -ForegroundColor Green