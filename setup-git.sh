#!/bin/bash

echo "🔧 Configurando Git para IQpanda PDV..."

# Colores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Verificar si Git está instalado
if ! command -v git &> /dev/null; then
    echo -e "${RED}❌ Git no está instalado${NC}"
    echo "Instalando Git..."
    sudo apt install -y git
fi

echo ""
echo -e "${BLUE}📝 Configuración de Identidad${NC}"
echo "Esta información aparecerá en tus commits"
echo ""

# Verificar si ya está configurado
CURRENT_NAME=$(git config --global user.name 2>/dev/null)
CURRENT_EMAIL=$(git config --global user.email 2>/dev/null)

if [ -n "$CURRENT_NAME" ] && [ -n "$CURRENT_EMAIL" ]; then
    echo -e "${YELLOW}⚠️  Ya tienes configuración de Git:${NC}"
    echo "   Nombre: $CURRENT_NAME"
    echo "   Email:  $CURRENT_EMAIL"
    echo ""
    read -p "¿Quieres mantener esta configuración? (s/n): " KEEP_CONFIG
    
    if [ "$KEEP_CONFIG" != "s" ] && [ "$KEEP_CONFIG" != "S" ]; then
        CURRENT_NAME=""
        CURRENT_EMAIL=""
    fi
fi

# Solicitar nombre si no existe
if [ -z "$CURRENT_NAME" ]; then
    read -p "Tu nombre completo: " USER_NAME
    git config --global user.name "$USER_NAME"
    echo -e "${GREEN}✅ Nombre configurado: $USER_NAME${NC}"
else
    echo -e "${GREEN}✅ Usando nombre: $CURRENT_NAME${NC}"
fi

# Solicitar email si no existe
if [ -z "$CURRENT_EMAIL" ]; then
    read -p "Tu email: " USER_EMAIL
    git config --global user.email "$USER_EMAIL"
    echo -e "${GREEN}✅ Email configurado: $USER_EMAIL${NC}"
else
    echo -e "${GREEN}✅ Usando email: $CURRENT_EMAIL${NC}"
fi

echo ""
echo -e "${BLUE}⚙️  Configurando opciones adicionales...${NC}"

# Configuraciones adicionales
git config --global core.editor "nano"
git config --global color.ui auto
git config --global init.defaultBranch main
git config --global push.default simple
git config --global pull.rebase true
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'

echo -e "${GREEN}✅ Configuraciones aplicadas${NC}"

echo ""
echo -e "${BLUE}🔐 ¿Quieres configurar firma GPG para commits? (Opcional)${NC}"
echo "Esto añade una capa extra de seguridad y verificación"
read -p "Configurar GPG (s/n): " SETUP_GPG

if [ "$SETUP_GPG" = "s" ] || [ "$SETUP_GPG" = "S" ]; then
    echo ""
    echo "Generando clave GPG..."
    echo "Sigue las instrucciones (presiona Enter para valores por defecto)"
    gpg --full-generate-key
    
    # Obtener el KEY ID
    KEY_ID=$(gpg --list-secret-keys --keyid-format=long | grep "sec" | head -n 1 | awk '{print $2}' | cut -d'/' -f2)
    
    if [ -n "$KEY_ID" ]; then
        git config --global user.signingkey "$KEY_ID"
        git config --global commit.gpgsign true
        echo -e "${GREEN}✅ GPG configurado con clave: $KEY_ID${NC}"
        
        echo ""
        echo "Tu clave pública GPG (para agregar en GitHub/GitLab):"
        echo "─────────────────────────────────────────────────────"
        gpg --armor --export $(git config user.email)
        echo "─────────────────────────────────────────────────────"
        echo ""
        echo "Copia esto y agrégalo en:"
        echo "  GitHub: Settings → SSH and GPG keys → New GPG key"
        echo "  GitLab: Preferences → GPG Keys → Add new key"
    fi
fi

echo ""
echo -e "${BLUE}📦 Inicializando repositorio Git...${NC}"

# Verificar que estamos en el directorio correcto
if [ ! -d "backend" ] || [ ! -d "frontend" ]; then
    echo -e "${RED}❌ Error: Ejecuta este script desde la raíz del proyecto${NC}"
    exit 1
fi

# Inicializar Git si no está inicializado
if [ ! -d ".git" ]; then
    git init
    echo -e "${GREEN}✅ Repositorio Git inicializado${NC}"
else
    echo -e "${YELLOW}⚠️  Repositorio Git ya existía${NC}"
fi

# Crear .gitignore completo
echo ""
echo -e "${BLUE}📝 Creando .gitignore...${NC}"

cat > .gitignore << 'GITIGNORE_EOF'
# ============================================
# IQpanda PDV - Git Ignore
# ============================================

# ============================================
# Python
# ============================================
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
env/
venv/
ENV/
env.bak/
venv.bak/
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
pip-wheel-metadata/
share/python-wheels/
*.egg-info/
.installed.cfg
*.egg
MANIFEST

# PyInstaller
*.manifest
*.spec

# Unit test / coverage reports
htmlcov/
.tox/
.nox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*.cover
*.py,cover
.hypothesis/
.pytest_cache/

# Jupyter Notebook
.ipynb_checkpoints

# pyenv
.python-version

# Celery
celerybeat-schedule
celerybeat.pid

# SageMath
*.sage.py

# Spyder
.spyderproject
.spyproject

# Rope
.ropeproject

# mkdocs
/site

# mypy
.mypy_cache/
.dmypy.json
dmypy.json

# Pyre
.pyre/

# ============================================
# Node.js / JavaScript
# ============================================
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*
lerna-debug.log*
.pnpm-debug.log*

# Dependency directories
jspm_packages/

# TypeScript cache
*.tsbuildinfo

# Optional npm cache
.npm

# Optional eslint cache
.eslintcache

# Optional REPL history
.node_repl_history

# Output of 'npm pack'
*.tgz

# Yarn Integrity file
.yarn-integrity

# parcel-bundler cache
.cache
.parcel-cache

# Next.js build output
.next
out

# Nuxt.js build / generate output
.nuxt
dist

# Gatsby files
.cache/
public

# vuepress build output
.vuepress/dist

# Serverless directories
.serverless/

# FuseBox cache
.fusebox/

# DynamoDB Local files
.dynamodb/

# TernJS port file
.tern-port

# Stores VSCode versions
.vscode-test

# ============================================
# IDEs y Editores
# ============================================
.vscode/
.idea/
*.swp
*.swo
*~
.DS_Store
*.sublime-project
*.sublime-workspace
.cursor/

# ============================================
# Environment Variables
# ============================================
.env
.env.local
.env.*.local
.env.development.local
.env.test.local
.env.production.local

# ============================================
# Databases
# ============================================
*.db
*.sqlite
*.sqlite3
*.db-journal

# PostgreSQL
postgres-data/

# ============================================
# Logs
# ============================================
logs/
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
lerna-debug.log*
pnpm-debug.log*

# ============================================
# OS Specific
# ============================================
# macOS
.DS_Store
.AppleDouble
.LSOverride
._*

# Windows
Thumbs.db
Thumbs.db:encryptable
ehthumbs.db
ehthumbs_vista.db
*.stackdump
[Dd]esktop.ini
$RECYCLE.BIN/
*.lnk

# Linux
*~
.fuse_hidden*
.directory
.Trash-*
.nfs*

# ============================================
# Archivos del Proyecto
# ============================================
# Uploads (archivos subidos por usuarios)
uploads/
temp/
tmp/
*.tmp

# Backups
backups/
*.backup
*.bak

# Certificados (NUNCA commitear)
*.pem
*.key
*.crt
*.cer
*.p12
*.pfx

# Reportes generados
reports/generated/

# Imágenes de productos (si son muchas)
# frontend/public/products/

# Cache de ML models
*.pkl
*.joblib
ml_models/cache/

# ============================================
# Build Artifacts
# ============================================
build/
dist/
*.whl

# ============================================
# Coverage reports
# ============================================
htmlcov/
.coverage
coverage/

# ============================================
# Docker
# ============================================
# Si usas Docker en el futuro
docker-compose.override.yml
.dockerignore

# ============================================
# Misc
# ============================================
.venv
pip-log.txt
pip-delete-this-directory.txt
.webassets-cache
instance/
.scrapy
docs/_build/
target/
profile_default/
ipython_config.py
__pypackages__/

# Archivos de configuración locales
config.local.json
settings.local.json

# TODO: Descomentar si usas estos
# migrations/versions/*.pyc
GITIGNORE_EOF

echo -e "${GREEN}✅ .gitignore creado${NC}"

# Crear .gitattributes para normalización de líneas
echo ""
echo -e "${BLUE}📝 Creando .gitattributes...${NC}"

cat > .gitattributes << 'GITATTR_EOF'
# Auto detect text files and perform LF normalization
* text=auto

# Source code
*.py text eol=lf
*.js text eol=lf
*.jsx text eol=lf
*.ts text eol=lf
*.tsx text eol=lf
*.json text eol=lf
*.html text eol=lf
*.css text eol=lf
*.scss text eol=lf
*.sql text eol=lf
*.sh text eol=lf

# Documentation
*.md text eol=lf
*.txt text eol=lf

# Config files
.gitignore text eol=lf
.gitattributes text eol=lf
.editorconfig text eol=lf

# Binary files
*.png binary
*.jpg binary
*.jpeg binary
*.gif binary
*.ico binary
*.pdf binary
*.woff binary
*.woff2 binary
*.ttf binary
*.eot binary
*.db binary
*.sqlite binary
GITATTR_EOF

echo -e "${GREEN}✅ .gitattributes creado${NC}"

# Crear README.md básico
echo ""
echo -e "${BLUE}📝 Creando README.md...${NC}"

cat > README.md << 'README_EOF'
# IQpanda Tecnovador - PDV Inteligente 🍎🍌🍊

Sistema de Punto de Venta inteligente para fruterías con IA integrada.

## 🚀 Características

- ✅ Sistema de ventas completo
- ✅ Gestión de inventario en tiempo real
- ✅ Integración con báscula digital
- ✅ Predicción de demanda con IA
- ✅ Prevención de merma
- ✅ Sugerencias automáticas de resurtido
- ✅ Sistema de promociones inteligente
- ✅ Reportes avanzados
- ✅ Módulos premium opcionales

## 🛠️ Stack Tecnológico

**Backend:**
- Python 3.11+
- FastAPI
- SQLAlchemy
- PostgreSQL
- Redis
- scikit-learn

**Frontend:**
- React 18+
- TypeScript
- Vite
- Tailwind CSS
- Zustand

## 📋 Requisitos

- Linux Mint 21+ / Ubuntu 22.04+
- Python 3.11+
- Node.js 20+
- PostgreSQL 14+
- Redis 6+

## 🔧 Instalación
```bash
# 1. Clonar repositorio
git clone <url-del-repo>
cd iqpanda-pdv

# 2. Ejecutar setup
./scripts/setup.sh

# 3. Configurar variables de entorno
nano backend/.env

# 4. Ejecutar migraciones
cd backend
source venv/bin/activate
alembic upgrade head
cd ..

# 5. Iniciar sistema
./scripts/start.sh
```

## 📚 Documentación

La documentación completa está en `docs/`

- [Especificación Técnica](docs/especificacion-tecnica.md)
- [Guía de Instalación](docs/guia-instalacion.md)
- [Manual de Usuario](docs/manual-usuario.md)
- [API Documentation](http://localhost:8000/docs) (cuando el servidor esté corriendo)

## 🧪 Testing
```bash
# Backend
cd backend
source venv/bin/activate
pytest

# Frontend
cd frontend
npm test
```

## 📝 Licencia

Propietaria - IQpanda Tecnovador © 2026

## 👥 Equipo

Desarrollado por el equipo de IQpanda Tecnovador

## 📞 Soporte

- Email: soporte@iqpanda.com
- Teléfono: +52 (55) 1234-5678
- Sitio Web: www.iqpanda.com
README_EOF

echo -e "${GREEN}✅ README.md creado${NC}"

# Primer commit
echo ""
echo -e "${BLUE}📦 Realizando primer commit...${NC}"

git add .
git commit -m "Initial commit: Project structure and configuration

- Backend: FastAPI + SQLAlchemy + PostgreSQL
- Frontend: React + TypeScript + Vite + Tailwind
- Documentation: Technical specification
- Scripts: Setup and automation scripts
- Configuration: Git, IDE, environment

Created by: $(git config user.name)
Date: $(date '+%Y-%m-%d')"

echo -e "${GREEN}✅ Commit inicial realizado${NC}"

# Mostrar status
echo ""
echo -e "${BLUE}📊 Estado del repositorio:${NC}"
git log --oneline -1
git status

echo ""
echo -e "${GREEN}✨ ¡Git configurado exitosamente!${NC}"
echo ""
echo "📝 Próximos pasos:"
echo "   1. Crear repositorio en GitHub/GitLab"
echo "   2. Agregar remote: git remote add origin <url>"
echo "   3. Push inicial: git push -u origin main"
echo ""

# Mostrar configuración final
echo -e "${BLUE}⚙️  Tu configuración de Git:${NC}"
echo "───────────────────────────────────────"
git config --list | grep -E "(user\.|core\.editor|color\.|init\.defaultBranch|push\.default|pull\.rebase)"
echo "───────────────────────────────────────"
echo ""

GITIGNORE_EOF
