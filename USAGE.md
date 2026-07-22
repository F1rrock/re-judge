# Usage

This guide covers installation, configuration, writing solutions, and using RStudio addins.

For a detailed map of every layer in the codebase, see [README.md](README.md).

------------------------------------------------------------------------

## Prerequisites

| Requirement | Details                                                     |
|-------------|-------------------------------------------------------------|
| R           | 4.0 or newer                                                |
| RStudio     | Required for addins and interactive prompts                 |
| R packages  | `dotenv`, `httr`, `xml2`, `rvest`, `jsonlite`, `rstudioapi` |

The installation scripts install any missing packages automatically from CRAN.

------------------------------------------------------------------------

## Installation

### Overview

ReJudge is installed by running a **fixture script** from [`RePackage/Installation/Fixtures/`](RePackage/Installation/Fixtures/). Each script:

1.  Installs required R packages.
2.  Removes any previously installed `ReJudge` package.
3.  Downloads the project archive into the **current working directory**.
4.  Validates package metadata.
5.  Runs `R CMD INSTALL` on `RePackage`.
6.  Verifies the installed package loads.
7.  Prompts for ejudge login, password, and contest ID.
8.  Creates a `.env` file with your credentials and server settings.
9.  Verifies authorization against ejudge.
10. Configures RStudio (shows hidden files, opens `Src/Example.R`).

Choose an empty directory as your working directory before running a script — the installer will populate it with project files.

### Choosing a script

| Script | When to use | Archive source | `BASE_URL` | `CLIENT_PATH` |
|----|----|----|----|----|
| [`GitHub.R`](RePackage/Installation/Fixtures/GitHub.R) | Public internet, latest code from GitHub | `https://github.com/F1rrock/re-judge/archive/refs/heads/main.zip` | `10.21.17.68` | `new-client` |
| [`MSU.R`](RePackage/Installation/Fixtures/MSU.R) | MSU internal network, faster local download | `http://10.21.17.68/files/re-judge/re-judge-main.zip` | `10.21.17.68` | `new-client` |
| [`LocalHost.R`](RePackage/Installation/Fixtures/LocalHost.R) | Local development server | `http://0.0.0.0:8000/re-judge-main.zip` | `0.0.0.0:90` | `ejudge` |

All three scripts share the same installation logic; only the download URL and ejudge server settings differ.

### Step-by-step

1.  Open the [`RePackage/Installation/Fixtures/`](RePackage/Installation/Fixtures/) directory on GitHub (or in your local clone).

2.  Open the script that matches your environment (see table above).

3.  Select all script contents and copy them.

4.  In RStudio, set the working directory to an **empty folder** where you want the project.

5.  Paste the script into the R console and press Enter.

6.  When prompted, enter:

    -   **Ejudge login**
    -   **Ejudge password** (input is hidden)
    -   **Contest ID** (default: `1`)

7.  Wait until you see:

    ```         
    .env created.
    ReJudge installed.
    ```

8.  Restart RStudio: **Session → Restart R**.

9.  Check that addins appear under the **Addins** menu (hammer icon).

### What the installer creates

After a successful run, your working directory will contain:

```         
.
├── .env                 # credentials and server settings (created by installer)
├── ReJudge/             # core library sources
├── RePackage/           # R package with addins
├── Src/                 # example and solution files
│   └── Example.R
├── ReJudge.Rproj        # RStudio project file
├── README.md
└── USAGE.md
```

The `RePackage` package is installed into your R library and registered as RStudio addins.

### Troubleshooting installation

| Problem | What to try |
|----|----|
| `authorization failed` | Check login, password, and contest ID. Make sure the contest is open and accessible from your network. |
| `Failed to install required dependencies` | Install missing packages manually: `install.packages(c("dotenv", "httr", "xml2", "rvest", "jsonlite", "rstudioapi"))` |
| `download.file` error (GitHub script) | Check internet connection. Try the MSU script if you are on the MSU network. |
| `download.file` error (MSU script) | Make sure you are on the MSU network and the file server is reachable. |
| `download.file` error (LocalHost script) | Start the local HTTP server that serves `re-judge-main.zip` on port 8000. |
| Addins do not appear | Restart RStudio (**Session → Restart R**). Check that `RePackage` installed: `requireNamespace("ReJudge", quietly = TRUE)`. |
| Something else fails | Restart the R session and run the installer again in a clean empty directory. |

------------------------------------------------------------------------

## Configuration

### The `.env` file

ReJudge reads ejudge settings from a file named `.env` in the project root. The installer creates this file automatically. You can also create or edit it manually using [`.env.example`](.env.example) as a template:

``` env
LOGIN=your_login
PASSWORD=your_password
CONTEST_ID=91
BASE_URL=10.21.17.68
CLIENT_PATH=new-client
```

### Variables

| Variable | Required | Description | Example |
|----|----|----|----|
| `LOGIN` | yes | Your ejudge login | `student` |
| `PASSWORD` | yes | Your ejudge password | `secret` |
| `CONTEST_ID` | yes | Contest number | `91` |
| `BASE_URL` | yes | ejudge server host, optionally with port (no `http://` prefix) | `10.21.17.68` or `0.0.0.0:90` |
| `CLIENT_PATH` | yes | Web client path on the server | `new-client` or `ejudge` |

ReJudge builds request URLs as `{BASE_URL}/{CLIENT_PATH}/...`. Use the same values that the installer wrote, or match them to your ejudge deployment.

### Changing credentials manually

Edit `.env` directly and restart the R session (**Session → Restart R**).

### Switching contests

Use the **Switch contest** addin instead of editing `.env` by hand:

1.  Open **Addins → Switch contest**.
2.  Enter the new contest ID.
3.  The addin updates `CONTEST_ID` in `.env` and prints a confirmation.

If something does not work after a configuration change, restart the R session: **Session → Restart R**.

------------------------------------------------------------------------

## Writing a solution

### File location and naming

You can place your solution file anywhere and name it however you like. Keeping solutions in `Src/` is recommended for consistency.

### Problem comment (required)

Every solution file must contain a comment with the problem name. ReJudge uses this to identify which problem you are working on:

``` r
# problem: A3
```

The comment must be on its own line. The problem name must match the name shown in ejudge (case-sensitive).

### Language comment (optional)

If the programming language is not selected automatically, add a comment with the language number from the submission page dropdown. Numbering starts from 1:

``` r
# language: 3
```

ReJudge first tries to read the language from the problem page. If no language is pre-selected there, it falls back to the `# language` comment.

### Example

See [`Src/Example.R`](Src/Example.R) for a minimal solution file template.

------------------------------------------------------------------------

## Addins

All addins are available from the **Addins** menu in RStudio (hammer icon). Some require a problem comment in the currently open file; others work on the current contest regardless of the open file.

### Available problems

**Binding:** `problems`

Lists all problems available in the current contest. Use this to discover problem names without opening ejudge manually.

-   Does **not** require a problem comment in the current file.
-   Reads `CONTEST_ID` from `.env`.

### Solved problems

**Binding:** `solved`

Lists all solved problems in the current contest.

-   Does **not** require a problem comment in the current file.
-   Reads `CONTEST_ID` from `.env`.

### Description of the problem

**Binding:** `problem`

Fetches and displays the problem statement for the current file.

-   Requires `# problem: ...` in the currently open file.

### Previous solutions of the problem

**Binding:** `submissions`

Fetches and displays a table of previous submissions for the current problem.

-   Requires `# problem: ...` in the currently open file.

### Last report

**Binding:** `lastreport`

Fetches and displays the last report for the current problem.

-   Requires `# problem: ...` in the currently open file.

### Local testing

**Binding:** `testification`

Runs the currently open solution against sample tests from the ejudge problem statement. If the statement contains downloadable resources, ReJudge downloads them before running the test.

-   Requires `# problem: ...` in the currently open file.
-   Uses `# language: ...` if the language is not auto-detected.

### Switch contest

**Binding:** `switchcontest` (interactive)

Prompts for a new contest ID and updates `CONTEST_ID` in the `.env` file.

-   Does **not** require a problem comment.
-   Interactive: RStudio will ask for input when you run the addin.

### Submit the solution

**Binding:** `autosubmit`

Submits the currently open file to ejudge and waits for the verdict. The result table is printed in the console when testing completes.

-   Requires `# problem: ...` in the currently open file.
-   Does **not** run local sample tests before submitting.

### Submit with pre-test

**Binding:** `submit`

Runs the currently open file against sample tests first. If all sample tests pass, ReJudge submits the solution to ejudge and waits for the verdict. The result table is printed in the console when testing completes.

-   Requires `# problem: ...` in the currently open file.
-   Use this when local sample tests are available.
-   If local testing is not applicable for the problem, use **Submit the solution** instead.

------------------------------------------------------------------------

## Workflow

A typical session looks like this:

1.  **Install** ReJudge using a script from `RePackage/Installation/Fixtures/`.
2.  **Discover problems:** open **Addins → Available problems** (or **Solved problems**).
3.  **Create a solution file** in `Src/` with a problem comment, e.g. `# problem: M5`.
4.  **Read the statement:** **Addins → Description of the problem**.
5.  **Check history:** **Addins → Previous solutions of the problem**.
6.  **Write your solution.**
7.  **Test locally:** **Addins → Local testing**.
8.  **Submit:**
    -   **Addins → Submit with pre-test** — if sample tests exist and you want local validation first;
    -   **Addins → Submit the solution** — to submit directly.
9.  **Inspect the result:** **Addins → Last report**.
10. If the verdict requires changes, go back to step 4 or step 6.
11. To work on a different contest: **Addins → Switch contest**.

------------------------------------------------------------------------

## Regenerating installation scripts (for developers)

The fixture scripts in `RePackage/Installation/Fixtures/` are **generated** from composable installation code in `ReJudge/Installation/`. To regenerate a fixture after changing installation logic, run from the repository root:

``` r
source("RePackage/Installation/GitHub.R")    # writes Fixtures/GitHub.R
source("RePackage/Installation/MSU.R")       # writes Fixtures/MSU.R
source("RePackage/Installation/LocalHost.R") # writes Fixtures/LocalHost.R
```

Each generator calls `rejudge.load()`, builds an `installation.full(...)` pipeline with the appropriate config presets, and writes the resulting R code to the corresponding fixture file.

------------------------------------------------------------------------

## Quick reference

| Task | Action |
|----|----|
| Install from GitHub | Run `RePackage/Installation/Fixtures/GitHub.R` |
| Install from MSU server | Run `RePackage/Installation/Fixtures/MSU.R` |
| Install from localhost | Run `RePackage/Installation/Fixtures/LocalHost.R` |
| Change contest | **Addins → Switch contest** |
| List problems | **Addins → Available problems** |
| Read statement | **Addins → Description of the problem** |
| Test locally | **Addins → Local testing** |
| Submit with pre-test | **Addins → Submit with pre-test** |
| Submit directly | **Addins → Submit the solution** |
| View last report | **Addins → Last report** |
| Restart after config change | **Session → Restart R** |
