# Usage

## Prerequisites

- R (≥ 4.0)
- RStudio
- Packages: `httr`, `xml2`, `rvest`, `jsonlite`, `rstudioapi`

```r
install.packages(c("httr", "xml2", "rvest", "jsonlite", "rstudioapi"))
```

## Installation

To install the addins package, open the `RePackage/Installation/` directory in the repository on GitHub and choose a suitable installation script.

Copy the script and run it in the R console in RStudio.

This will:

- download the project into the current working directory,
- install the `RePackage` package,
- register the addins in RStudio.

After installation, you only need to configure the `.env` file.

Restart RStudio. The addins will appear in the **Addins** menu.

## Configuration

Create a `.env` file in your project root based on `.env.example`:

```env
LOGIN={LOGIN}
PASSWORD={PASSWORD}
CONTEST_ID=91
BASE_URL=http://10.21.17.68
CLIENT_PATH=new-client
```

| Variable | Description |
|---|---|
| `LOGIN` | Your ejudge login |
| `PASSWORD` | Your ejudge password |
| `CONTEST_ID` | Contest number |
| `BASE_URL` | ejudge server URL |
| `CLIENT_PATH` | Web client path (`/ejudge` or `/new-client`) |

## Writing a solution

You can place your solution file anywhere and name it however you like. Keeping solutions in `Src/` is preferred for consistency.

Every file must contain a comment with the problem name. This is how the addins identify which problem you are working on:

```r
# problem: A3
```

Optionally, if the language for the problem is not selected automatically, add a second comment with the serial number of the language as it appears in the submission language selector (1-based):

```r
# language: 15
```

ReJudge first tries to read the language from the problem page. If no language is pre-selected there, it falls back to `# language`.

### Reading input

Use `scan()` to read numbers:

```r
# problem: A
x <- scan(quiet = TRUE)
cat(x[1] + x[2])
```

If you use `readline()` or `readLines()`, always pass `file = "stdin"` explicitly:

```r
line <- readline(file = "stdin")
```

## Addins

### Available problems

Lists all problems available in the contest. Use this to discover problem names without opening ejudge manually. This addin does not require a problem comment in the current file.

### Solved problems

Lists all solved problems in the contest. Use this to discover names of solved problems without opening ejudge manually. This addin does not require a problem comment in the current file.

### Description of the problem

Fetches and displays the problem statement. The currently open file must contain a problem comment (e.g. `# problem: A3`).

### Local testing

Tests that submission passes sample test from ejudge problem description. The currently open file must contain a problem comment (e.g. `# problem: A3`).

### Submit the solution

Submits the currently open file to ejudge and waits for the verdict. The result table is printed in the console when testing completes. The currently open file must contain a problem comment (e.g. `# problem: A3`).

## Workflow

1. Open **Addins → Available problems** to see the list of problems in the contest
2. Create a solution file, add a comment with the chosen problem name (e.g. `# problem: M5`)
3. Open **Addins → Description of the problem** to read the problem statement
4. Write your solution
5. Open **Addins → Submit the solution** to submit
6. Go to step 4 if the verdict requires changes
