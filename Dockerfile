# Dockerfile
FROM oven/bun:latest AS builder

WORKDIR /app

# Copia los archivos de configuración
COPY bun.lockb package.json ./

# Instala las dependencias con Bun
RUN bun install --production

# Copia el resto del código fuente
COPY src ./src

# Compila la aplicación (Next.js con Bun)
RUN bun build

# Establece la imagen final
FROM oven/bun:latest

WORKDIR /app

# Copia los archivos necesarios desde el contenedor anterior
COPY --from=builder /app ./

EXPOSE 3000

CMD ["bun", "start"]
