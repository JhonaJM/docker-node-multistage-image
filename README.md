# 🐳 Docker Node Cron Ticker (Multi‑Stage Image)

Proyecto de ejemplo para aprender **creación de imágenes Docker personalizadas** usando:

- Dockerfile
- Multi‑stage builds
- .dockerignore
- Build
- Tags
- Docker Hub
- Buildx (multi‑arquitectura)

La aplicación es un **cron job en Node.js** que ejecuta una tarea cada 5 segundos simulando una sincronización de base de datos.

---

## 📁 Estructura del proyecto

```
cron-ticker (nombre de mi proyecto)
├── tasks/
│   └── sync-db.js
├── tests/
│   └── tasks/sync-db.test.js
├── app.js
├── Dockerfile
├── .dockerignore
├── package.json
├── package-lock.json
└── .gitignore
```

---

## 🚀 ¿Qué hace la app?

Usa la biblioteca `node-cron` para ejecutar un proceso cada 5 segundos:

```
Tick cada multiplo de 5
```
---

## 🧠 ¿Qué es Multi‑Stage Build?

Un **multi‑stage build** permite usar **múltiples etapas dentro del mismo Dockerfile**.

Ventajas:

- imágenes más pequeñas
- mayor seguridad
- solo dependencias de producción
- tests durante el build
- mejor rendimiento


### 🐳 Dockerfile (Multi‑Stage explicado)

Se utilizan **4 etapas** para optimizar tamaño y seguridad.

#### 1️⃣ deps

Instala dependencias de desarrollo.

#### 2️⃣ builder

Copia código y ejecuta tests.

#### 3️⃣ prod-deps

Instala SOLO dependencias de producción.

#### 4️⃣ runner

Imagen final mínima que ejecuta la app.

---

## ⚙️ Construir la imagen localmente

```
docker build -t cron-ticker .
```

Ejecutar:

```
docker run cron-ticker
```

---

## 🚀 Build multi‑arquitectura con Buildx

Permite generar imágenes compatibles con:

- amd64 (PCs)
- arm64 (Mac M1/M2, servidores ARM)

### Crear builder

```
docker buildx create --use
```

### Construir imagen

```
docker buildx build -t cron-ticker .
```

---

# 📦 Publicar la imagen en Docker Hub

## 🔹 Login

```
docker login
```

## 🔹 Build + Push (IMPORTANTE)

⚠️ **Debes usar tu propio usuario Docker Hub**

Formato obligatorio:

```
<usuario-dockerhub>/<repo>:tag
```

### Comando genérico:

```
docker buildx build   --platform linux/amd64,linux/arm64   -t <usuario-dockerhub>/cron-ticker:1.0.0   --push .
```

### Ejemplo de este caso:

```
docker buildx build   --platform linux/amd64,linux/arm64   -t jhonajm/cron-ticker:1.0.0   --push .
```

Esto:

- construye la imagen
- genera soporte multi‑arquitectura
- sube la imagen automáticamente a Docker Hub

---

# 📥 Descargar y usar la imagen pública

Si solo quieres ejecutar la app, no necesitas construir nada:

```
docker pull jhonajm/cron-ticker:1.0.0
docker run jhonajm/cron-ticker:1.0.0
```

Docker descargará automáticamente la versión correcta según tu arquitectura.

---


## 🧪 Ejecutar tests manualmente

```
npm install
npm run test
npm start
```

---

## 🏁 Conclusión

Este proyecto demuestra:

- creación de imágenes personalizadas
- optimización con multi‑stage
- pruebas durante build
- imágenes pequeñas para producción
- publicación en Docker Hub
- soporte multi‑arquitectura con Buildx

Base fundamental para desplegar aplicaciones en producción 🚀
