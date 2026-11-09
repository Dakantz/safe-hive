# Agents Workspace

## Overview
Configuration and tooling directory for AI coding agent workspace, primarily set up for the **pi** coding agent (`@earendil-works/pi-coding-agent`).

## Structure

| Path | Description |
|---|---|
| `.pi/` | **pi agent runtime** — settings, auth, model configs, session logs. Includes custom binaries `fd` and `rg`. |
| `.agents/` | **Custom agent skills** — currently holds `tex-formatting` ("paper") skill for Typst academic papers. |
| `.claude.json` | **Claude agent config** (~41 KB). |
| `Dockerfile.base` | **Base Docker image** — Ubuntu with Firefox, Chromium, Typst, Java, Maven, Node.js, Python, and dependencies. Matches host UID/GID. |
| `install-dependencies.sh` | **Dependency installer** — geckodriver, Bun, uv. |
| `bin/hive` | Custom executable binary. |

## Key Observations
- Both **pi** and **Claude** agents are installed via their respective installers in the Dockerfile.
- The `tex-formatting` skill provides automated PDF "runt line" detection and Crossref DOI lookup for academic papers.
- The workspace is Docker-first, with a comprehensive toolchain for web automation, scientific typesetting, and general development.
