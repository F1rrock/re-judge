# Usage

## Prerequisites

- R 4.0 or newer
- RStudio
- Required R packages: `httr`, `xml2`, `rvest`, `jsonlite`, `rstudioapi`

## Installation

To install the addins package, open the `RePackage/Installation/` directory in the repository on GitHub and choose a suitable installation script.

Copy the script and run it in the R console in RStudio.

The installer will:

- download the project into the current working directory;
- install the `RePackage` package;
- register the RStudio addins.

After installation, configure the `.env` file. Some installers may create it automatically.

Restart RStudio. The addins will appear in the **Addins** menu.

## Configuration

Create a `.env` file (exactly that name) in the project (near to `.env.example`) root based on `.env.example` (just copy the contents):

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
| `CLIENT_PATH` | Web client path, for example `ejudge` or `new-client` |

## Writing a solution

You can place your solution file anywhere and name it however you like. Keeping solutions in `Src/` is recommended for consistency.

Every solution file must contain a comment with the problem name. This is how ReJudge identifies which problem you are working on:

```r
# problem: A3
```

Optionally, if the programming language is not selected automatically, add a second comment with the language number from the submission page dropdown. Numbering starts from 1.

```r
# language: 3
```

ReJudge first tries to read the language from the problem page. If no language is pre-selected there, it falls back to the `# language` comment.

### Reading input

Use `scan()` to read input:

```r
# problem: A
x <- scan(quiet = TRUE)
cat(x[1] + x[2])
```

## Addins

### Available problems

Lists all problems available in the contest. Use this addin to discover problem names without opening ejudge manually. This addin does not require a problem comment in the current file.

### Solved problems

Lists all solved problems in the contest. Use this addin to discover already solved problem names without opening ejudge manually. This addin does not require a problem comment in the current file.

### Description of the problem

Fetches and displays the problem statement. The currently open file must contain a problem comment, for example:

```r
# problem: A3
```

### Previous solutions of the problem

Fetches and displays a table of previous submissions for the current problem. The currently open file must contain a problem comment.

### Last report

Fetches and displays the last report for the current problem. The currently open file must contain a problem comment.

### Local testing

Runs the currently open solution against sample tests from the ejudge problem statement. If the statement contains downloadable resources, ReJudge downloads them before running the local test. The currently open file must contain a problem comment.

### Submit the solution

Submits the currently open file to ejudge and waits for the verdict. The result table is printed in the console when testing completes. The currently open file must contain a problem comment.

### Submit with pre-test

Runs the currently open file against the sample tests first. If all sample tests pass, ReJudge submits the solution to ejudge and waits for the verdict. The result table is printed in the console when testing completes. The currently open file must contain a problem comment.

Use this addin when local sample tests are available. If local testing is not applicable for the problem, use **Submit the solution** instead.

## Workflow

1. Open **Addins → Solved problems** to see the list of already solved problems.
2. Open **Addins → Available problems** to see the list of problems in the contest.
3. Create a solution file and add a problem comment, for example `# problem: M5`.
4. Open **Addins → Description of the problem** to read the problem statement.
5. Open **Addins → Previous solutions of the problem** to inspect previous submissions.
6. Open **Addins → Last report** to see the details of the latest report.
7. Write your solution.
8. Open **Addins → Local testing** to run the solution against sample tests.
9. Open **Addins → Submit with pre-test** to test locally and submit automatically, or **Addins → Submit the solution** to submit without local pre-testing.
10. If the verdict requires changes, return to step 4 or step 7.
