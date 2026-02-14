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
# iqpanda-pdv
