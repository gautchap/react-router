FROM node:20-alpine AS base

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

RUN pnpm add pm2@latest -g

FROM base AS dev-deps
RUN apk update
RUN apk add --no-cache libc6-compat
WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm i --frozen-lockfile

FROM base AS prod-deps
RUN apk update
RUN apk add --no-cache libc6-compat
WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN pnpm i --prod --frozen-lockfile

FROM base AS builder
WORKDIR /app
COPY package.json pnpm-lock.yaml ./
COPY --from=dev-deps /app/node_modules ./node_modules
COPY . .
RUN pnpm build

FROM base AS runner
WORKDIR /app
COPY package.json pnpm-lock.yaml ./
RUN addgroup --system --gid 1001 vitejs
RUN adduser --system --uid 1001 vitejs
USER vitejs
COPY --from=prod-deps --chown=vitejs:vitejs /app/node_modules ./node_modules
COPY --from=builder --chown=vitejs:vitejs /app/build ./build
COPY --from=builder --chown=vitejs:vitejs /app/ecosystem.config.cjs ./
# COPY --from=builder --chown=vitejs:vitejs /app/server.mjs ./
EXPOSE 3000
ENV PORT=3000
ENV HOSTNAME="0.0.0.0"
CMD ["pm2-runtime", "ecosystem.config.cjs"] 