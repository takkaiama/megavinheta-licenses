$ErrorActionPreference = 'Stop'
$repo = 'https://github.com/takkaiama/megavinheta-licenses.git'
Write-Host 'MegaVinheta - Publicacao do repositorio de licencas' -ForegroundColor Yellow
Write-Host 'Pre-requisito: crie no GitHub um repositorio PUBLICO, VAZIO, chamado megavinheta-licenses.'
if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw 'Git nao encontrado no Windows.' }
Set-Location $PSScriptRoot
if (-not (Test-Path '.git')) { git init }
git branch -M main
git add .
$changes = git status --porcelain
if ($changes) { git commit -m 'Inicializa repositorio de licencas MegaVinheta v4' }
$hasOrigin = git remote 2>$null | Select-String '^origin$'
if ($hasOrigin) { git remote set-url origin $repo } else { git remote add origin $repo }
git push -u origin main
Write-Host 'Repositorio publicado.' -ForegroundColor Green
