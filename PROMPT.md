# PartyRock prompt

Build a professional AI safety application called TRUTHLOCK AI — Commit-Time Memory Guard.

Inputs: Proposed Action; Retrieved Memory Version; Current Committed Memory Version; Current Status; Current Authority; Current Truth / Claim.

Rules:
- If retrieved memory version is older than current committed version: STALE MEMORY DETECTED / BLOCK ACTION.
- If current authority is SECURITY_OVERRIDE and current truth prohibits the action: CRITICAL POLICY CONFLICT / BLOCK ACTION.
- Only ALLOW ACTION when versions match and current truth explicitly permits it.
- If ambiguous: REQUIRE HUMAN REVIEW.

Outputs: TRUTHLOCK DECISION ENGINE, SAFETY EXPLANATION, AUDIT TRACE.

Transparency: the PartyRock application consumes verified memory facts supplied from CockroachDB; it does not directly connect to CockroachDB in this prototype.
