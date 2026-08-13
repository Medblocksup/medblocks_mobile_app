# ADR-01 — Prioritise catalogue and ordering over batch verification

- Status: accepted
- Date: 2024-02-14

## Context
The initial scope covered both the ordering path and batch verification.
Interviews with three pharmacists (November 2022 – February 2023) showed that
batch verification is used occasionally, whereas catalogue and ordering are
used daily. Building both at once doubled the cost of every iteration, and each
iteration is subcontracted.

## Decision
Ship the ordering path first. Verification stays in scope but is scheduled
after the first public release.

## Consequences
- The first public version does not carry the differentiating module.
- Verification is delivered from June 2026 and becomes the focus of release
  1.1.0.
- The product is usable and demonstrable from April 2025.
