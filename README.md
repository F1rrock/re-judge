# ReJudge

ReJudge is an R library for working with **ejudge** directly from RStudio. It allows you to browse contest problems, read statements, run sample tests, submit solutions, and inspect reports without leaving the RStudio console.

## Architecture

The project is organized around focused, composable layers. Each layer exposes a small interface and remains independent of concrete implementations where possible.

- **Text** — lazy text values and adapters with the `contents(...)` interface
- **Collection** — lazy sequence transformations with the `items(...)` interface
- **Dom** — HTML navigation over a concrete DOM engine
- **Http** — HTTP request construction and concrete HTTP adapters
- **Session** — authenticated ejudge session objects
- **Page** — ejudge pages represented as composable objects
- **Domain** — business logic for working with ejudge entities
- **Json** — lazy JSON parsing with the `fields(...)` interface
- **Status** — run status objects with the `ok(...)` interface
- **Script** — executable scripts with the `result(...)` interface
- **Resource** — downloadable resources required by local tests
- **File** — files represented as composable objects
- **Spec** — input/output specifications for sample tests
- **Workspace** — user environment integration, including RStudio
- **App** — top-level workflows such as problem browsing, local testing, and submission

## HTTP layer

The HTTP layer is split into small composable parts:

- **Driver** — selects a concrete HTTP backend
- **Connection** — response-producing connection objects with composable policies:
  - logging
  - retries
  - timeout handling
  - memoization
  - successful-status checks
- **Attachment** — file attachment support
- **Media** — request media containers and members
- **Httr** — concrete implementation backed by `httr`

## Current status

The core layers are in place. ReJudge continues to evolve toward a declarative model where ejudge interactions are described through composable lazy objects rather than direct imperative calls.
