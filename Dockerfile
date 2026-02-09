# FROM: define la imagen base desde la cual se construirá la imagen
#FROM --platform=$BUILDPLATFORM node:20-alpine AS node_amd64 

# Etapa - Dependencias de desarrollo
FROM node:20-alpine AS deps

# WORKDIR: establece el directorio de trabajo dentro del contenedor
WORKDIR /app

# copiar los archivos app.js y package.json al WORKDIR
# COPY app.js package.json ./
COPY package.json ./

# instalar las dependencias
RUN npm install


# Etapa - Build y test
FROM node:20-alpine AS builder

WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules

COPY . .

RUN npm run test


# Etapa - Dependencias de prod
FROM node:20-alpine AS prod-deps

WORKDIR /app
COPY package.json ./
# Instalar unicamente las dependencias de PROD
RUN npm install --prod


# Etapa - Ejecutar App
FROM node:20-alpine AS runner

WORKDIR /app

COPY --from=prod-deps /app/node_modules ./node_modules

COPY app.js ./
COPY tasks/ ./tasks

# comando run de la imagen
CMD ["node","app.js"]






