# Titan Infinity — Docker Infrastructure

Complete container stack for the Titan Infinity AI Operating System.

## Services

| Service | Image | Port | Profiles |
|---------|-------|------|----------|
| Postgres | postgres:16-alpine | 5432 | hermes-ops, developer, automation-engineer |
| Redis | redis:7-alpine | 6379 | All profiles |
| RabbitMQ | rabbitmq:3-management-alpine | 5672, 15672 (UI) | automation-engineer, agenticops |
| Prometheus | prom/prometheus:v2.54.0 | 9090 | hermes-ops |
| Grafana | grafana/grafana:11.2.0 | 3001 | hermes-ops |
| Elasticsearch | elasticsearch:8.15.0 | 9200 | researcher, hermes-ops |
| Ollama | ollama/ollama:latest | 11434 | quantum-scientist, researcher, agenticops |
| Hermes Agent | node:20-slim | internal | All profiles |
| Hermes Browser | browserless/chrome | 3000 | All profiles |

## Quick Start

```bash
# Start all services
docker compose up -d

# Start specific services
docker compose up -d postgres redis rabbitmq

# View logs
docker compose logs -f

# Stop all
docker compose down

# Stop and remove volumes (CAREFUL)
docker compose down -v
```

## Data Storage

All data is stored on Drive S:
```
S:\hermes\docker\postgres\data
S:\hermes\docker\redis\data
S:\hermes\docker\elasticsearch\data
S:\hermes\docker\rabbitmq\data
S:\hermes\docker\prometheus\data
S:\hermes\docker\grafana\data
S:\hermes\docker\ollama\models
```

## Credentials

| Service | Username | Password |
|---------|----------|----------|
| Postgres | titan | titan_secure_2026 |
| Redis | - | titan_redis_2026 |
| RabbitMQ | titan | titan_mq_2026 |
| Grafana | titan | titan_grafana_2026 |

## Monitoring

- **Prometheus:** http://localhost:9090
- **Grafana:** http://localhost:3001
- **RabbitMQ Management:** http://localhost:15672
- **Control Tower:** Every 2h health check via cron

## Service Dependencies

```
postgres ─→ (no deps)
redis ─→ (no deps)
rabbitmq ─→ (no deps)
elasticsearch ─→ (no deps, needs memory)
ollama ─→ (no deps, needs GPU for full speed)
prometheus ─→ postgres, redis, rabbitmq, elasticsearch
grafana ─→ prometheus
```
