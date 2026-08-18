# Architecture

```text
Autonomous Agent
    |
    v
CockroachDB persistent memory
    |-- version/status/authority lineage
    |-- Distributed Vector Index
    |-- Managed MCP (OAuth, read-only for demo)
    |
    v
Verified current truth
    |
    v
Amazon Bedrock reasoning via PartyRock
    |
    v
TRUTHLOCK Commit-Time Gate
    |-- ALLOW
    |-- BLOCK
    `-- REQUIRE HUMAN REVIEW
    |
    v
Conditional action commit + audit proof
```

Core rule: semantic relevance is not execution authority. Before a consequential action is committed, TRUTHLOCK re-checks the current authoritative memory version.
