# ADR-02 — Incremental anchoring before any permissioned ledger

- Status: accepted
- Date: 2026-09-02

## Context
A full ledger implies operational infrastructure and load capacity that the
product does not have yet. Verification must nevertheless produce a proof that
a given batch record existed at a given time.

## Decision
Deliver an anchored hash first: SHA-256 of the batch record, external
timestamping, proof file downloadable from the result screen. The permissioned
ledger is deferred to phase 2.

## Consequences
- A verifiable proof is available without depending on a running network.
- Cost and operational risk stay controlled.
- The ledger remains an explicit later step, tracked in issue #9.
