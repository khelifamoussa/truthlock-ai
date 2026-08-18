# TRUTHLOCK AI — Commit-Time Memory Guard

TRUTHLOCK AI is a prototype safety layer for autonomous AI agents. It prevents a sensitive action from being executed when the agent is relying on stale, superseded, or no-longer-authoritative memory.

## Demo scenario
A finance agent proposes `PAY $28,500 TO SUPPLIER NOVA` using memory V17. CockroachDB contains a newer authoritative V18: `Supplier NOVA is suspended. All payments are prohibited.` TRUTHLOCK revalidates memory at commit time, detects V17 as superseded, and blocks the action. No payment record is committed.

## Architecture
1. CockroachDB Cloud — persistent versioned memory and current truth.
2. CockroachDB Distributed Vector Indexing — semantic retrieval of related historical/current memories.
3. CockroachDB Cloud Managed MCP Server — read-only agent-native inspection via OAuth.
4. Amazon Bedrock via AWS PartyRock — commit-time safety reasoning over verified memory facts.
5. Conditional execution gate — commit only if retrieved memory version still matches current truth.

Transparency: PartyRock does not directly connect to CockroachDB in this prototype. CockroachDB supplies verified persistent-memory state; PartyRock/Amazon Bedrock demonstrates the safety-reasoning stage.

## Repository contents
- `sql/01_schema.sql`
- `sql/02_demo_data.sql`
- `sql/03_commit_guard.sql`
- `sql/04_vector_demo.sql`
- `mcp/cline_mcp_settings.example.json`
- `partyrock/PROMPT.md`
- `ARCHITECTURE.md`

## Run
Execute the SQL files in order in CockroachDB Cloud SQL Shell. Expected outcome: V17 is superseded by V18, the guard returns `STALE MEMORY DETECTED / BLOCK ACTION`, and `executed_payments = 0`.

## Security
Never commit passwords, connection strings, API keys, OAuth tokens, or other secrets. This repository intentionally contains no credentials.

## License
MIT
