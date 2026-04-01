# ReJudge

ReJudge is an R library for working with **ejudge** from R through a set of small composable objects.

The project aims to make ejudge interactions scriptable and reusable: authenticate, fetch pages, extract structured data from HTML, and build higher-level workflows on top of that foundation.

## Current architecture

The project is organized around several focused layers.

- **Text** — lazy text values and adapters with `contents(...)`
- **Collection** — lazy sequence-like transformations with `items(...)`
- **Dom** — HTML navigation and extraction over a concrete DOM engine
- **Element** — lazy DOM nodes
- **Http** — HTTP-facing request construction and concrete adapters
- **Session** — authenticated ejudge session objects
- **Page** — page builders that return HTML-producing page objects
- **Token** — token-like values with `value(...)` and `expiration(...)`
- **Domain** — ejudge-specific projections and extractors

This split keeps ejudge-specific logic separate from:

- HTTP implementation details
- HTML parsing technology
- low-level collection processing

## HTTP layer

The old transport layer has been reshaped into a more explicit **Http** layer.

It currently includes:

- **Driver** — selects a concrete HTTP backend
- **Request** — request-related capabilities such as:
  - headers
  - body
  - cookie jar
- **Attachment** — HTTP attachment capabilities such as multipart file upload
- **Connection** — response-producing HTTP connection objects
- **Media** — request media containers and media members
- **Httr** — concrete implementation backed by `httr`

This makes low-level HTTP concerns more explicit and easier to swap or extend.

## HTML and extraction

HTML processing is split from HTTP and domain logic.

- **Dom** provides a DOM-like interface through an engine
- **Element** represents lazy DOM nodes
- **Collection** powers lazy traversal pipelines
- **Domain** extractors can work on top of pages without knowing about `xml2`, `rvest`, or `httr`

At the moment the project includes an `xml2`-based DOM engine and a declarative extractor for problem statements.

## Current capabilities

The project currently supports:

- building authenticated ejudge sessions
- retrieving session HTML
- retrieving cookies
- extracting `SID`
- extracting `EJSID`
- extracting token expiration where available
- fetching problem pages
- extracting problem statements from problem pages
- composing HTTP connection policies such as:
  - logging
  - retries
  - timeout
  - memoization
  - successful-status checks
- building multipart submit requests

## Direction

The project is moving toward a fully composable model where ejudge actions are described through objects instead of ad-hoc scripts.

This includes:

- treating pages as first-class objects
- treating tokens as their own values instead of plain text
- separating HTML traversal from domain extraction
- isolating HTTP backend details behind `Http/*`

## Environment

Create a `.env` file based on `.env.example`.

Example:

```env
LOGIN=your_login
PASSWORD=your_password
CONTEST_ID=1
BASE_URL=http://0.0.0.0:90
CLIENT_PATH=/ejudge
```

`CLIENT_PATH` should point to the ejudge web client route.  
Depending on the installation it may be something like:

- `/ejudge`
- `/new-client`

## Status

The project is under active redesign.  
The core layers are already in place, but naming and interface consistency are still being refined.
