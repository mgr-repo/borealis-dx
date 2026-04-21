# Copilot / Agent Instructions for borealis-dx

Purpose
-------
Project produces an immutable image derived from ublue/aurora. This instructions file provides guidelines for GitHub Copilot and any coding agents contributing to this repository, ensuring that suggestions and contributions align with the project's conventions and goals.

Scope
-----
- Applies to automated code suggestions, Copilot sessions, and assistant agents working on this repository only.
- Primary file types: docker files, shell scripts, Justfile, TOML configs, build scripts, and small helper scripts under `build_files/` and `disk_config/`.

High-level rules
----------------
- Respect existing repository style and minimal surface changes: prefer small, focused edits rather than large refactors.
- Refer to https://github.com/ublue-os/aurora and https://docs.getaurora.dev/ for examples and docs.
- Do not change unrelated files. If a change touches multiple areas, explain rationale and ask before proceeding.
- Default shell: `bash`. Prefer POSIX-compatible shell constructs when practical, but use `bash` features by default for new scripts and explain why when deviating from POSIX.
- Preserve file encodings and line endings used in the repo.

Interaction rules for the agent
-----------------------------
- Ask clarifying questions when scope or intent is ambiguous (for example: "Should this rule apply to all shell scripts or only to `build_files/`?").
- When uncertain about repository conventions, propose one or two options and ask the maintainer to pick.

Additional guidelines
----------------------------------------
- Default shell: `bash`.
- Use `just check` to validate `Justfile`/ujust files during verification.
- Default behaviour: conservative, minimal-impact changes; ask clarifying questions when needed.

