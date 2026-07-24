# Graph Report - .  (2026-07-24)

## Corpus Check
- Corpus is ~10,037 words - fits in a single context window. You may not need a graph.

## Summary
- 97 nodes · 190 edges · 5 communities
- Extraction: 89% EXTRACTED · 10% INFERRED · 1% AMBIGUOUS · INFERRED: 19 edges (avg confidence: 0.83)
- Token cost: 194,868 input · 0 output

## Community Hubs (Navigation)
- Spec System & State Templates
- Grill Questions & Permission Profiles
- Bootstrap Skill Core (Phases & Principles)
- Emitted Artifacts (AGENTS/CLAUDE/Decisions)
- Repo Onboarding & Contribution Policy

## God Nodes (most connected - your core abstractions)
1. `AgenticLoop Bootstrap — OKF Bundle (README)` - 14 edges
2. `Memory: Named Failure Modes` - 14 edges
3. `Skill: AgenticLoop Bootstrap` - 13 edges
4. `Phase 2: Tailor` - 10 edges
5. `The six-step loop (read→red→green→gate→record→update)` - 9 edges
6. `Example: A Full Bootstrap Walkthrough` - 8 edges
7. `Principle: Verify Then Act` - 7 edges
8. `Memory: Lessons from Real Use` - 7 edges
9. `The three actors (Owner / Agent / Gate)` - 6 edges
10. `Principle: Append-only` - 6 edges

## Surprising Connections (you probably didn't know these)
- `Maturity — validation status and scope` --semantically_similar_to--> `Source note (synthesized, redacted from working notes)`  [INFERRED] [semantically similar]
  README.md → docs/methodology-reference.md
- `solo-local permission profile (accident-prevention)` --semantically_similar_to--> `Coexistence rules (shared machine)`  [INFERRED] [semantically similar]
  skills/agentic-loop-bootstrap/artifacts/settings-json.md → docs/methodology-reference.md
- `Six-step loop (README mention)` --references--> `The six-step loop (read→red→green→gate→record→update)`  [EXTRACTED]
  README.md → docs/methodology-reference.md
- `State file rules (pasted output, tests_weakened must be 0)` --conceptually_related_to--> `Escalation rules`  [INFERRED]
  skills/agentic-loop-bootstrap/artifacts/state-file.md → docs/methodology-reference.md
- `Task spec template (per-task)` --conceptually_related_to--> `Task spec template`  [INFERRED]
  skills/agentic-loop-bootstrap/artifacts/task-spec.md → docs/methodology-reference.md

## Hyperedges (group relationships)
- **Bootstrap artifact-generation flow (all emitted/target-file specs)** — skills_agentic_loop_bootstrap_artifacts_agents_md_document, skills_agentic_loop_bootstrap_artifacts_claude_md_document, skills_agentic_loop_bootstrap_artifacts_settings_json_document, skills_agentic_loop_bootstrap_artifacts_spec_system_document, skills_agentic_loop_bootstrap_artifacts_decisions_log_document, skills_agentic_loop_bootstrap_artifacts_task_spec_document, skills_agentic_loop_bootstrap_artifacts_state_file_document [EXTRACTED 1.00]
- **Grill questions jointly drive the settings.json / spec-system permission profile** — skills_agentic_loop_bootstrap_questions_existing_repo_document, skills_agentic_loop_bootstrap_questions_harness_document, skills_agentic_loop_bootstrap_questions_stack_document, skills_agentic_loop_bootstrap_questions_threat_model_document, skills_agentic_loop_bootstrap_questions_verify_cadence_document, skills_agentic_loop_bootstrap_artifacts_settings_json_document [INFERRED 0.75]
- **Three-actor pattern: Owner, Agent, and Gate together form the loop's governance** — docs_methodology_reference_three_actor_pattern, docs_methodology_reference_owner, docs_methodology_reference_agent, docs_methodology_reference_gate [EXTRACTED 1.00]
- **Four-Phase Bootstrap Flow (Context Scan → Grill → Tailor → Verify)** — skills_agentic_loop_bootstrap_phases_00_context_scan_context_scan, skills_agentic_loop_bootstrap_phases_01_grill_grill, skills_agentic_loop_bootstrap_phases_02_tailor_tailor, skills_agentic_loop_bootstrap_phases_03_verify_verify [EXTRACTED 1.00]
- **Core Methodology Principles** — skills_agentic_loop_bootstrap_principles_append_only_append_only, skills_agentic_loop_bootstrap_principles_gate_on_merge_result_gate_on_merge_result, skills_agentic_loop_bootstrap_principles_provenance_before_confidence_provenance_before_confidence, skills_agentic_loop_bootstrap_principles_state_in_repo_state_in_repo, skills_agentic_loop_bootstrap_principles_verify_then_act_verify_then_act [INFERRED 0.85]
- **Named Failure Modes Catalog** — skills_agentic_loop_bootstrap_memory_failure_modes_ghost_test, skills_agentic_loop_bootstrap_memory_failure_modes_trunk_merge_with_pending_gate, skills_agentic_loop_bootstrap_memory_failure_modes_word_grep_overreach, skills_agentic_loop_bootstrap_memory_failure_modes_silent_overwrite, skills_agentic_loop_bootstrap_memory_failure_modes_fake_completion, skills_agentic_loop_bootstrap_memory_failure_modes_environment_masquerade [EXTRACTED 1.00]

## Communities (5 total, 0 thin omitted)

### Community 0 - "Spec System & State Templates"
Cohesion: 0.13
Nodes (20): Pull request guidelines, Agent (actor role), Autopilot contract, Coexistence rules (shared machine), Escalation rules, Gate (actor role — tests + self-review checklist), Master prompt template (session opener), Meta-observation (external confirmations) (+12 more)

### Community 1 - "Grill Questions & Permission Profiles"
Cohesion: 0.18
Nodes (13): Decisions-log emission rules, Rules for settings.json emission, public-with-contributors permission profile, small-team permission profile, solo-local permission profile (accident-prevention), solo-public-repo permission profile, phases/01-grill.md (Phase 1 grill), Existing Repo State options (greenfield/brownfield-*) (+5 more)

### Community 2 - "Bootstrap Skill Core (Phases & Principles)"
Cohesion: 0.29
Nodes (21): Example: A Full Bootstrap Walkthrough, Failure Mode: The Environment Masquerade, Memory: Named Failure Modes, Failure Mode: The Fake Completion, Failure Mode: The Ghost Test, Failure Mode: The Silent Overwrite, Failure Mode: The Trunk-Merge-With-Pending-Gate, Failure Mode: The Word-Grep Overreach (+13 more)

### Community 3 - "Emitted Artifacts (AGENTS/CLAUDE/Decisions)"
Cohesion: 0.12
Nodes (14): .claude/settings.json (generated permission profile file), Append-only chronological decisions ledger, Task spec template, Quick start (bootstrap flow), Rules for AGENTS.md emission, AGENTS.md (generated repo-root file), AGENTS.md template, When to skip CLAUDE.md emission (non-claude-code harness) (+6 more)

### Community 4 - "Repo Onboarding & Contribution Policy"
Cohesion: 0.19
Nodes (13): The append-only convention (required), Extend the methodology reference (guidance), Improve the bootstrap skill (OKF bundle), Sanitization policy, Source note (synthesized, redacted from working notes), AgenticLoop (methodology), Contributing section pointer, Maturity — validation status and scope (+5 more)

## Ambiguous Edges - Review These
- `artifacts/settings-json.md` → `questions/existing-repo.md`  [AMBIGUOUS]
  skills/agentic-loop-bootstrap/questions/existing-repo.md · relation: references
- `artifacts/settings-json.md` → `questions/verify-cadence.md`  [AMBIGUOUS]
  skills/agentic-loop-bootstrap/questions/verify-cadence.md · relation: references

## Knowledge Gaps
- **13 isolated node(s):** `Sanitization policy`, `Agent (actor role)`, `Model playbook`, `Master prompt template (session opener)`, `Meta-observation (external confirmations)` (+8 more)
  These have ≤1 connection - possible missing edges or undocumented components.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **What is the exact relationship between `artifacts/settings-json.md` and `questions/existing-repo.md`?**
  _Edge tagged AMBIGUOUS (relation: references) - confidence is low._
- **What is the exact relationship between `artifacts/settings-json.md` and `questions/verify-cadence.md`?**
  _Edge tagged AMBIGUOUS (relation: references) - confidence is low._
- **Why does `00-spec-system.md skeleton (8 sections)` connect `Spec System & State Templates` to `Grill Questions & Permission Profiles`?**
  _High betweenness centrality (0.078) - this node is a cross-community bridge._
- **Why does `The six-step loop (read→red→green→gate→record→update)` connect `Spec System & State Templates` to `Emitted Artifacts (AGENTS/CLAUDE/Decisions)`, `Repo Onboarding & Contribution Policy`?**
  _High betweenness centrality (0.077) - this node is a cross-community bridge._
- **Why does `The append-only convention (required)` connect `Repo Onboarding & Contribution Policy` to `Grill Questions & Permission Profiles`?**
  _High betweenness centrality (0.054) - this node is a cross-community bridge._
- **What connects `Sanitization policy`, `Agent (actor role)`, `Model playbook` to the rest of the system?**
  _13 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Spec System & State Templates` be split into smaller, more focused modules?**
  _Cohesion score 0.1341991341991342 - nodes in this community are weakly interconnected._