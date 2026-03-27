# ReJudge

ReJudge is an R library for working with **ejudge** directly from **RStudio**.

The goal of the project is to make common contest actions available from the R console without switching to the browser: viewing pages, extracting session data, submitting files, inspecting tests, and building higher-level workflows on top of ejudge.

## Current direction

The project is built around a small set of composable layers:

- **Text** — lazy text values with `contents(...)`
- **Media** — normalized containers for request parts
- **Driver** — technology-specific gateway to an HTTP implementation
- **Connection** — decorated access to a response
- **Session** — domain-facing session object with `html(...)` and `cookies(...)`
- **Domain** — ejudge-specific projections such as `SID` and `EJSID`

This structure is meant to keep ejudge logic separate from the concrete HTTP tool used underneath.

## Features

At the current stage, the project already supports:

- building authenticated ejudge sessions
- retrieving session HTML
- retrieving cookies
- extracting `SID` and `EJSID`
- composing connection policies such as:
  - logging
  - retries
  - timeout
  - memoization
  - successful-status checks

Planned goals include:

- browsing problems
- submitting solutions
- viewing tests and reports
- navigating contest pages from the R console
- exposing these actions as composable R objects instead of ad-hoc scripts

## Environment

Create a `.env` file based on `.env.example`.

Example:

```env
LOGIN=your_login
PASSWORD=your_password
CONTEST_ID=1
BASE_URL=http://0.0.0.0:90
