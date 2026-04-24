# ReJudge

ReJudge is an R library for working with **ejudge** directly from RStudio: browse problems, submit solutions, and interact with contests without leaving the console.

## Architecture

The project is organized around focused, composable layers. Each layer exposes a small interface and stays independent of the others.

- **Text** — lazy text values and adapters with `contents(...)`
- **Collection** — lazy sequence transformations with `items(...)`
- **Dom** — HTML navigation over a concrete DOM engine
- **Http** — HTTP request construction and concrete adapters
- **Session** — authenticated session objects
- **Page** — ejudge pages as composable objects
- **Domain** — business logic for working with ejudge
- **Json** — lazy JSON parsing with a `fields(...)` interface
- **Status** — run status objects with an `ok(...)` interface
- **Script** — executable scripts with a `result(...)` interface
- **File** — files as composable objects
- **Spec** — specifications with input and output
- **Token** — tokens as composable objects
- **Workspace** — user environment integration
- **App** — top-level workflows: problem browsing and submission

## HTTP layer

- **Driver** — selects a concrete HTTP backend
- **Connection** — response-producing connection objects with composable policies:
  - logging
  - retries
  - timeout
  - memoization
  - successful-status checks
- **Attachment** — file attachment support
- **Media** — request media containers and members
- **Httr** — concrete implementation backed by `httr`

## Status

The core layers are in place. The project continues to evolve toward a fully declarative model where all ejudge interactions are described through composable objects.
