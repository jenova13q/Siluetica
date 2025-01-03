# Siluetica

Intelligent wardrobe management system powered by LLM agent.

## Description

Siluetica helps users manage their wardrobe and create outfits using AI. The system analyzes clothing items, considers weather conditions, user preferences, and style guidelines to suggest appropriate outfit combinations.

## Tech Stack

- NestJS + TypeScript
- PostgreSQL (Prisma ORM)
- Weaviate (Vector DB)
- LLM (Local/OpenAI)
- Docker

## Project Structure

Clean Architecture:
- domain/ - Entities and interfaces
- application/ - Use Cases
- infrastructure/ - Implementations and adapters
- presentation/ - Controllers and DTOs
- agent/ - Core-Agent modules (LLM, planning, memory, etc.)
- shared/ - Common utilities

## Installation

```bash
# Install dependencies
npm install

# Configure environment
cp .env.example .env

# Run development
npm run start:dev
```

## Documentation

See `database-structure.md` for database schema details.
