# ReJudge

ReJudge is an R library for working with **ejudge** directly from RStudio. It allows you to browse contest problems, read statements, run sample tests, submit solutions, and inspect reports without leaving the RStudio console.

The codebase is organized as a set of small, composable layers. Each layer exposes a narrow interface (`contents`, `items`, `code`, `perform`, and others) and can be combined without knowing concrete implementations. See [USAGE.md](USAGE.md) for installation and day-to-day usage.

## Repository layout

| Path | Purpose |
|----|----|
| [`ReJudge/`](ReJudge/) | Core library: all composable layers, domain logic, and installation generators |
| [`RePackage/`](RePackage/) | R package that exposes RStudio addins; thin wrappers over `ReJudge/App` |
| [`Src/`](Src/) | Example and user solution files |
| [`.env.example`](.env.example) | Template for ejudge credentials and server settings |
| [`USAGE.md`](USAGE.md) | Installation, configuration, addins, and workflow |

Entry point for loading the library in development:

``` r
source("ReJudge/Manifest.R")
```

RStudio addins are registered through `RePackage` after installation.

------------------------------------------------------------------------

## `ReJudge/` — layer reference

Everything under `ReJudge/` is plain R source loaded via `source()` and `Manifest.R` files. There is no package structure inside this folder; `RePackage` wraps selected `App` workflows for RStudio.

### `ReJudge/App/`

Top-level user workflows. Each file defines an `app.*` object that can be executed with `perform(...)`. Most addins in `RePackage` call these apps.

| File | Role |
|----|----|
| `App.R` | Defines the `perform()` generic |
| `Lambda.R` | Anonymous `app` wrapper around a function |
| `Delegate.R` | Delegates `perform` to a nested app |
| `Effect.R` | Adapts an `effect` (side effect) into an `app` via `realize()` |
| `Problems.R` | Lists available problems in the current contest |
| `Solved.R` | Lists solved problems in the current contest |
| `Problem.R` | Fetches and displays a problem statement |
| `Submissions.R` | Shows previous submissions for the current problem |
| `LastReport.R` | Shows the last report for the current problem |
| `Testification.R` | Runs local sample tests against the open solution file |
| `Submit.R` | Pre-tests locally, then submits if all sample tests pass |
| `AutoSubmit.R` | Submits the open file without local pre-testing |
| `SwitchContest.R` | Prompts for a new contest ID and updates `.env` |

Apps read credentials from `.env` via `Workspace/Env`, authenticate through `Session`, navigate pages through `Page`, and print output through `Workspace/Console`.

------------------------------------------------------------------------

### `ReJudge/Text/`

Lazy text values. The central generic is `contents(x)`, which materializes text when needed. Many other layers (`File`, `Number`, `Token`, `Workspace/Env`) reuse this interface.

Core combinators:

| File | Role |
|----|----|
| `Text.R` | Defines `contents()` |
| `Lambda.R` | Deferred text computed by a function |
| `Delegate.R` | Delegates to another text object |
| `Required.R` | Fails with a message if inner text is empty |
| `NonEmpty.R` | Validates non-empty text |
| `Then.R` | Sequential validation/composition of text values |
| `Bind.R` | Monadic bind for text |
| `Join.R` | Joins a collection of text fragments |
| `Fstring.R` | `sprintf`-style formatting |
| `Regex.R` | Regex-based extraction |
| `Trimmed.R` | Trims whitespace |
| `Token.R` | Wraps a domain token as text |
| `Palette.R` | ANSI color wrappers (`text.green`, etc.) |
| `Payload.R`, `Result.R`, `Scalar.R` | Supporting text adapters |
| `Logged.R`, `Delayed.R`, `Asserted.R` | Debugging and control helpers |
| `Empty.R`, `Default.R`, `First.R` | Fallback and selection helpers |

Code-generation helpers (used heavily by `Installation/`):

| File             | Role                                                     |
|------------------|----------------------------------------------------------|
| `Interpolated.R` | Template interpolation via `` `@@`(name) `` placeholders |
| `Literal.R`      | Embeds a literal R value into generated code             |
| `Pretty.R`       | Formats generated R code with `styler`                   |
| `Code.R`         | Wraps an `installation` object as text via `code()`      |

Presets (`Presets/`):

| File          | Role                               |
|---------------|------------------------------------|
| `Paragraph.R` | Multi-line paragraph text          |
| `Fresh.R`     | Clears the console before printing |

------------------------------------------------------------------------

### `ReJudge/Collection/`

Lazy sequence transformations. The central generic is `items(x)`.

| File                    | Role                                  |
|-------------------------|---------------------------------------|
| `Collection.R`          | Defines `items()`                     |
| `Lambda.R`              | Deferred collection                   |
| `Map.R`                 | Maps a function over items            |
| `Filter.R`              | Filters items                         |
| `Take.R`, `TakeUntil.R` | Takes prefix of a collection          |
| `Drop.R`, `DropUntil.R` | Drops prefix of a collection          |
| `SplitWhen.R`           | Splits on a predicate                 |
| `Lines.R`               | Splits text into lines                |
| `Pairs.R`               | Pairs adjacent items                  |
| `Cookies.R`             | Parses HTTP cookies into a collection |

Used when parsing HTML tables, splitting console output, and walking lists of problems or submissions.

------------------------------------------------------------------------

### `ReJudge/Dom/`

HTML navigation abstracted over a DOM engine.

| Path                 | Role                                        |
|----------------------|---------------------------------------------|
| `Xml2.R`             | Concrete engine backed by `xml2` / `rvest`  |
| `Engine/`            | Engine interface (`Engine.R`, `Manifest.R`) |
| `Element/Element.R`  | Base element type                           |
| `Element/Lambda.R`   | Deferred element lookup                     |
| `Element/Delegate.R` | Delegates to another element                |
| `Element/Required.R` | Fails if element is missing                 |
| `Element/First.R`    | Selects the first matching element          |
| `Element/Text.R`     | Extracts text content                       |
| `Element/Table.R`    | Parses HTML tables                          |

Domain code uses the engine interface so parsing logic does not depend directly on `xml2`.

------------------------------------------------------------------------

### `ReJudge/Http/`

HTTP request construction and response handling.

| Path | Role |
|----|----|
| `Driver/` | Selects a concrete HTTP backend |
| `Request/` | Builds requests (method, URL, headers, body) |
| `Connection/Connection.R` | Connection object that produces a response |
| `Connection/Logged.R` | Logs requests and responses |
| `Connection/Retried.R` | Retries failed requests |
| `Connection/Timed.R` | Applies a timeout |
| `Connection/Memo.R` | Memoizes responses |
| `Connection/Successful.R` | Checks HTTP success status |
| `Connection/Fake.R` | Fake connection for testing |
| `Connection/Presets/` | Ready-to-use connection presets |
| `Media/` | Request media containers and members (text, multipart, etc.) |
| `Attachment/` | File attachment support |
| `Httr/` | Concrete implementation backed by `httr` (`Driver.R`, `Connection.R`, `Request.R`, `Attachment.R`) |

Typical usage: `httr.driver` → `request(driver)` → build URL/headers/body → `connection.ready(...)` → `response(...)`.

------------------------------------------------------------------------

### `ReJudge/Session/`

Authenticated ejudge session objects.

| File | Role |
|----|----|
| `Session.R` | Base session type and generics |
| `Ejudge.R` | Builds a login POST and returns an ejudge session |
| `Fake.R` | Fake session for testing |
| `Logged.R` | Logs session operations |
| `Presets/Ready.R` | Wraps a raw session into a ready-to-use session with tokens |

Sessions carry cookies and tokens (`Domain/Token`) needed for subsequent page requests.

------------------------------------------------------------------------

### `ReJudge/Page/`

Ejudge pages represented as functions over a session.

| File        | Role                              |
|-------------|-----------------------------------|
| `Main.R`    | Main contest page (problem list)  |
| `Problem.R` | Individual problem statement page |
| `Submit.R`  | Solution submission page          |
| `Status.R`  | Run status / report page          |

Each page object knows how to build the HTTP request for that ejudge URL and returns a connection given a session.

------------------------------------------------------------------------

### `ReJudge/Domain/`

Business logic for ejudge entities. This layer sits above `Page`, `Dom`, and `Session`.

#### `Domain/Problem/`

Logic for a single problem:

| File | Role |
|----|----|
| `Id.R` | Parses problem identifier from a file comment |
| `Description.R` | Extracts problem statement text |
| `Examples.R`, `Example.R` | Sample input/output pairs from the statement |
| `Languages.R`, `Language.R` | Available and selected submission languages |
| `Submissions.R` | Previous submissions for the problem |
| `Attachments.R` | Downloadable resources attached to the statement |

#### `Domain/Problems/`

| File       | Role                              |
|------------|-----------------------------------|
| `List.R`   | Lists all problems in the contest |
| `Solved.R` | Lists solved problems             |

#### `Domain/Token/`

| File      | Role                        |
|-----------|-----------------------------|
| `Ejsid.R` | Parses `EJSID` cookie/token |
| `Sid.R`   | Parses `SID` session token  |

#### `Domain/Submission/`

| File         | Role                             |
|--------------|----------------------------------|
| `Title.R`    | Submission title                 |
| `File.R`     | Submission file handling         |
| `Language.R` | Selected language for submission |

#### `Domain/Run/`

| File                | Role                             |
|---------------------|----------------------------------|
| `Id.R`              | Run identifier                   |
| `Status.R`          | Run status text                  |
| `Last.R`            | Finds the last run for a problem |
| `State/Testing.R`   | Run is still testing             |
| `State/Completed.R` | Run has completed                |
| `State/Undefined.R` | Unknown run state                |

#### `Domain/Report/`

| File        | Role                            |
|-------------|---------------------------------|
| `Title.R`   | Report title                    |
| `Table.R`   | Verdict table                   |
| `Details.R` | Detailed report sections        |
| `Pooling.R` | Polls until the report is ready |
| `Entire.R`  | Full report text                |

------------------------------------------------------------------------

### `ReJudge/Json/`

Lazy JSON parsing with the `fields(...)` interface.

| File         | Role                                 |
|--------------|--------------------------------------|
| `Json.R`     | Defines `fields()`                   |
| `Lambda.R`   | Deferred JSON parsing                |
| `JsonLite.R` | Concrete parser backed by `jsonlite` |
| `Parser/`    | Parser interface                     |

------------------------------------------------------------------------

### `ReJudge/Status/`

Run and operation status with the `ok(...)` interface.

| File         | Role                                |
|--------------|-------------------------------------|
| `Status.R`   | Defines `ok()`                      |
| `Always.R`   | Always succeeds                     |
| `First.R`    | Returns the first successful status |
| `Logged.R`   | Logs status checks                  |
| `Delegate.R` | Delegates to another status object  |

------------------------------------------------------------------------

### `ReJudge/Script/`

Executable scripts with the `result(...)` interface. Used for local testing of solutions.

| File                | Role                                                  |
|---------------------|-------------------------------------------------------|
| `Script.R`          | Defines `result()`                                    |
| `RScript.R`         | Runs an R script file                                 |
| `WithResources.R`   | Executes a script with downloaded resources available |
| `Context/Context.R` | Script execution context                              |
| `Context/Lambda.R`  | Deferred context                                      |
| `Context/Empty.R`   | Empty context                                         |
| `Context/StdIn/`    | Standard input injection for scripts                  |
| `Context/Presets/`  | Ready-made contexts                                   |

------------------------------------------------------------------------

### `ReJudge/Resource/`

Downloadable resources required by local tests (files linked from problem statements).

| File         | Role                            |
|--------------|---------------------------------|
| `Resource.R` | Base resource type              |
| `Url.R`      | Downloads a resource from a URL |

------------------------------------------------------------------------

### `ReJudge/File/`

Files represented as composable objects with path, name, and extension accessors.

| File          | Role                     |
|---------------|--------------------------|
| `File.R`      | Base file type           |
| `RFile.R`     | R source file            |
| `Url.R`       | File identified by URL   |
| `Name.R`      | File name accessor       |
| `Extension.R` | File extension accessor  |
| `Required.R`  | Fails if file is missing |

------------------------------------------------------------------------

### `ReJudge/Spec/`

Input/output specifications for sample tests.

| File           | Role                                         |
|----------------|----------------------------------------------|
| `Spec.R`       | Base spec type                               |
| `Normalized.R` | Normalizes spec formatting before comparison |

------------------------------------------------------------------------

### `ReJudge/Token/`

Named tokens extracted from HTTP responses or sessions.

| File      | Role                                        |
|-----------|---------------------------------------------|
| `Token.R` | Base token type                             |
| `Plain.R` | Plain string token with optional expiration |

------------------------------------------------------------------------

### `ReJudge/Number/`

Numeric values as a small composable layer.

| File           | Role                      |
|----------------|---------------------------|
| `Number.R`     | Base number type          |
| `Lambda.R`     | Deferred number           |
| `Str.R`        | Number as string          |
| `Difference.R` | Numeric difference helper |

------------------------------------------------------------------------

### `ReJudge/Workspace/`

Integration with the user's R environment and RStudio.

#### `Workspace/Env/`

Working with environment variables and the `.env` file.

| File | Role |
|----|----|
| `Lookup.R` | Reads a variable via `dotenv::load_dot_env()` |
| `Assign.R` | Updates a variable in `.env` (used by Switch contest) |
| `Presets/Variable.R` | Named `.env` variable as a text object |

#### `Workspace/RStudio/`

Adapters from RStudio API to the `text` interface.

| File           | Role                                 |
|----------------|--------------------------------------|
| `Current.R`    | Currently open file in RStudio       |
| `Prompt.R`     | `rstudioapi::showPrompt` as text     |
| `PassPrompt.R` | `rstudioapi::askForPassword` as text |

#### `Workspace/Console/`

Console output helpers.

| File                | Role                                        |
|---------------------|---------------------------------------------|
| `Write.R`           | Writes text to the console                  |
| `WithReport.R`      | Wraps output with a report header           |
| `Presets/Message.R` | `console.message` effect for colored output |

------------------------------------------------------------------------

### `ReJudge/Effect/`

Side effects with the `realize(...)` interface. Effects compose with `effect.then` and are adapted into apps via `app.effect`.

| File       | Role                              |
|------------|-----------------------------------|
| `Effect.R` | Defines `realize()`               |
| `Lambda.R` | Deferred effect                   |
| `Then.R`   | Sequential composition of effects |

------------------------------------------------------------------------

### `ReJudge/Installation/`

Composable **generators** that produce R installation scripts as strings. Used to build the scripts in `RePackage/Installation/Fixtures/`.

Core interface:

| File | Role |
|----|----|
| `Installation.R` | Defines `code(x)` — materializes an installation pipeline to R source |
| `Lambda.R` | Deferred installation step |

Pipeline steps (each wraps an inner step and prepends/appends generated code):

| File | Role |
|----|----|
| `WithOptions.R` | Sets `options(pkgType = "binary", ...)` |
| `WithDeps.R` | Installs required CRAN packages |
| `CleanUp.R` | Removes previously installed `ReJudge` package |
| `From.R` | Downloads and unpacks the project archive |
| `WellFormed.R` | Validates `DESCRIPTION` and addins manifest |
| `Package.R` | Runs `R CMD INSTALL` on `RePackage` |
| `Consistent.R` | Checks NAMESPACE exports match R sources |
| `Available.R` | Verifies the installed package loads |
| `Env.R` | Writes `.env` with interpolated credentials |
| `RStudio.R` | Opens example file and navigates RStudio panes |
| `Verbose.R` | Appends `message(...)` after a step |
| `WithGlobal.R` | Introduces a cached global binding (`login <- local({...})`) |

#### `Installation/Binding/`

Named bindings for generated global variables (replaces the old `installation.bind`).

| File           | Role                                                |
|----------------|-----------------------------------------------------|
| `Binding.R`    | Generics `val()`, `name()`, `ref()`                 |
| `OfText.R`     | Binding from a name and a text value                |
| `Thunk.R`      | Wraps a binding in a cached `local({...})` function |
| `Presets/Of.R` | `binding.of(name, value)` preset                    |

#### `Installation/Credentials/`

Code generators for credential prompts in the **installed** script:

| File           | Role                                                  |
|----------------|-------------------------------------------------------|
| `Login.R`      | Prompts for ejudge login                              |
| `Pass.R`       | Prompts for password                                  |
| `Contest.R`    | Prompts for contest ID                                |
| `Authorized.R` | Verifies ejudge authorization after `.env` is written |

#### `Installation/Config/`

Presets for installation targets (used as arguments to `installation.full`):

| Path                   | Role                             |
|------------------------|----------------------------------|
| `Provider/GitHub.R`    | Download from GitHub archive     |
| `Provider/MSU.R`       | Download from MSU file server    |
| `Provider/LocalHost.R` | Download from local HTTP server  |
| `Endpoint/MSU.R`       | MSU ejudge host (`10.21.17.68`)  |
| `Endpoint/LocalHost.R` | Local ejudge host (`0.0.0.0:90`) |
| `Client/NewClient.R`   | Client path `new-client`         |
| `Client/Ejudge.R`      | Client path `ejudge`             |

#### `Installation/Presets/`

| File | Role |
|----|----|
| `Full.R` | Full installation pipeline: `installation.full(src, server, client)` |

To regenerate a fixture from the repository root:

``` r
source("RePackage/Installation/GitHub.R")    # → Fixtures/GitHub.R
source("RePackage/Installation/MSU.R")       # → Fixtures/MSU.R
source("RePackage/Installation/LocalHost.R") # → Fixtures/LocalHost.R
```

------------------------------------------------------------------------

## `RePackage/` — RStudio addins package

| Path | Role |
|----|----|
| `R/` | Thin exported functions (`problems`, `submit`, `switchcontest`, etc.) that load `ReJudge` and call `perform(app.*)` |
| `R/Bootstrap.R` | Finds or creates the `.Rproj`, loads `ReJudge/Manifest.R` |
| `inst/rstudio/addins.dcf` | Addin names, descriptions, and bindings |
| `Installation/` | Generators that write fixture scripts |
| `Installation/Fixtures/` | Ready-to-copy installation scripts for end users |

------------------------------------------------------------------------

## Core interfaces

| Interface    | Generic       | Typical use                             |
|--------------|---------------|-----------------------------------------|
| Text         | `contents(x)` | Lazy strings, prompts, formatted output |
| Collection   | `items(x)`    | Lists of problems, lines, cookies       |
| Installation | `code(x)`     | Generated R installation scripts        |
| Effect       | `realize(x)`  | Console output, file writes             |
| App          | `perform(x)`  | Top-level user workflows                |
| Script       | `result(x)`   | Local test execution                    |
| Status       | `ok(x)`       | Success/failure checks                  |
| JSON         | `fields(x)`   | Parsed JSON fields                      |

------------------------------------------------------------------------

## Current status

The core layers and RStudio addins are in place. The project continues to evolve toward a declarative model where ejudge interactions are described through composable lazy objects rather than direct imperative calls.
