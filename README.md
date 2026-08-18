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
- `01_schema.sql` — CockroachDB versioned-memory and vector-memory schema.
- `02_demo_data.sql` — NOVA V17/V18 supersession demo data.
- `03_commit_guard.sql` — commit-time stale-memory validation and execution guard.
- `04_vector_demo.sql` — Distributed Vector Indexing / semantic retrieval demo.
- `cline_mcp_settings.example.json` — CockroachDB Cloud Managed MCP example configuration.
- `PROMPT.md` — Amazon Bedrock / AWS PartyRock safety-reasoning prompt.
- `ARCHITECTURE.md` — architecture and system design.

## Run
Execute the following files in order in the CockroachDB Cloud SQL Shell:

1. `01_schema.sql`
2. `02_demo_data.sql`
3. `03_commit_guard.sql`
4. `04_vector_demo.sql`

Expected outcome:

- Retrieved memory version: V17
- Current authoritative version: V18
- Result: `STALE MEMORY DETECTED`
- Decision: `BLOCK ACTION`
- `executed_payments = 0`
