---
title: "Portfolio Mobile — KPI and Instrumentation Plan"
status: approved
created: 2026-10-22
updated: 2026-10-22
description: "How we would know the portfolio app helps reviewers reach the owner, which events that needs, and what is live today (Sentry errors only)."
template: architecture-docs templates/sdlc/kpi-and-instrumentation-plan.md
---

# Portfolio Mobile — KPI and Instrumentation Plan

## Document control

| Field | Value |
|---|---|
| Product | bookchaowalit-website/portfolio-site-mobile (web preview https://portfolio-mobile.bookchaowalit.com; no store listing) |
| Version / status | 0.1 / **approved** (2026-10-24) — definitions only; no analytics is live, no baselines |
| Metric owner | Owner (bookchaowalit) |
| AI maker | Claude Code (b-tier-b session, 2026-10-22) |
| AI reviewer | independent Claude reviewer subagent (`solo:solo-reviewer`, Sonnet, read-only, no maker context), 2026-10-24: approved (see Approval) |
| Charter objectives | OBJ-01 below (no separate charter) |
| Analytics / data source of truth | **None live.** Product analytics (PostHog per ADR-0005) is pending owner decision D4. Sentry (`personal-yu0/portfolio-site-mobile`) receives crash reports only from CI release builds that get `SENTRY_DSN`; the web preview is a CLI deploy built without it |
| Dashboard | none |
| Next review | 2026-11-15 (Big Loop M1) or when D4 is decided |

## KPI tree

```text
OBJ-01 Reviewers (recruiters, clients) who open the app reach out or open a project
  └─ KPI-O-01 Contact rate: sessions with a contact action / sessions
       ├─ KPI-L-01 Project engagement: sessions that open a project detail / sessions
       ├─ KPI-L-02 Outbound project link opens per session
       └─ KPI-G-01 Crash-free sessions
```

## KPI definitions

| KPI ID | Type | Name | Formula | Unit | Min volume | Data source and event(s) | Baseline | Target | Alert | Cadence | Owner |
|---|---|---|---|---|---|---|---|---|---|---|---|
| KPI-O-01 | outcome | Contact rate | sessions with `contact_tapped` / sessions | % | ≥ 100 sessions | `app_opened`, `contact_tapped` (planned) | not yet measured | set after 30 days of data | — | monthly | Owner |
| KPI-L-01 | leading | Project engagement | sessions with `project_opened` / sessions | % | ≥ 100 sessions | `project_opened` (planned) | not yet measured | set after 30 days | — | weekly | Owner |
| KPI-L-02 | leading | Outbound link opens | `project_link_opened` / sessions | count | ≥ 100 sessions | `project_link_opened` (planned) | not yet measured | set after 30 days | — | weekly | Owner |
| KPI-G-01 | guardrail | Crash-free sessions | 1 − sessions with an unhandled error / sessions | % | ≥ 100 sessions | Sentry errors (live for CI release builds); session count needs analytics | not yet measured | ≥ 99.5% | any new Sentry issue | daily | Owner |

Below the minimum volume a rate is reported as `not measurable`. There is no
traffic data today, so every KPI is `not measurable`.

## Event and data specification

| Event | Trigger | Properties | Personal data? | Emitted by | Status |
|---|---|---|---|---|---|
| `app_opened` | Splash finishes | `platform` (web/android/ios), `app_version` | pseudonymous install/session ID only | app | planned (waits for D4) |
| `project_opened` | Project detail screen shown | `project_index` | pseudonymous ID only | app | planned |
| `project_link_opened` | External project URL launched | `project_index` | pseudonymous ID only | app | planned |
| `favorite_toggled` | Favorite star tapped | `project_index`, `is_favorite` | pseudonymous ID only | app | planned |
| `contact_tapped` | Email / website / social action on Contact | `channel` (never the message text) | pseudonymous ID only | app | planned |
| Sentry error event | Unhandled Flutter/Dart error | stack trace, device/OS, release | no: request, user, breadcrumbs and extra are stripped in `lib/observability/sentry_setup.dart` | app | **implemented** (needs `--dart-define=SENTRY_DSN`) |

Privacy and data rules:

- Never send contact-form text, names or emails to analytics.
- A pseudonymous ID is still personal data under PDPA: privacy note, consent
  decision and an opt-out in Settings before any analytics event ships.
  `privacy-policy/index.html` must be updated at the same time.
- Retention: Sentry project default (90 days). Analytics retention set with D4.

## Dashboards and alerts

| Dashboard / alert | KPIs | Location | Status |
|---|---|---|---|
| Sentry issues for `portfolio-site-mobile` | KPI-G-01 (errors only) | Sentry org `personal-yu0` | live for CI release builds only |
| Product dashboard | KPI-O-01, KPI-L-01, KPI-L-02 | — | planned (D4) |

## Instrumentation verification (before G10)

| # | Check | Result |
|---|---|---|
| 1 | Events fire once per action | not run: no analytics events exist |
| 2 | Counts reconcile | not applicable yet |
| 3 | No PII in payloads | Sentry scrubbing unit-tested in `test/sentry_setup_test.dart`; analytics not built |
| 4 | Dashboard renders | not set up |
| 5 | Alert reaches the channel | not set up |
| 6 | Baselines captured | waived — no traffic data; dated action: capture 30 days after analytics ships |
| 7 | Consent respected | not applicable until analytics ships |

## Change history of definitions

| Date | KPI ID | Change | Reason | Baseline restated? | Approved by |
|---|---|---|---|---|---|
| 2026-10-22 | all | First draft | Big Loop L3 | no | pending owner |

## Approval (2026-10-24)

| Field | Value |
|---|---|
| Checker | independent Claude reviewer subagent (`solo:solo-reviewer`, Sonnet, read-only, no maker context) |
| Approver | AI approval under the owner's process (approvals by the owner or AI with evidence; maker and checker are different agents). Recorded by Claude session oa-remainder on the owner's instruction "ทำที่เหลือให้หน่อย" (2026-10-24) |
| Verdict | **approved** |
| Evidence | lib/observability/sentry_setup.dart + test; build.yml:80,198 SENTRY_DSN; privacy-policy/index.html; no analytics code; events planned. |
