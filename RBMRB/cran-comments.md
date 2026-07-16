## Resubmission notes

This is a major update (3.0.0) to the RBMRB package, originally submitted
in 2021. The update addresses the following critical issues and adds
significant new functionality.

### Why this update is necessary

1. **Broken API endpoint** — The old endpoint (`webapi.bmrb.wisc.edu/v2`)
   was decommissioned. All users of RBMRB 1.x currently receive HTTP errors.
   This release migrates to the current endpoint (`api.bmrb.io/v2`).

2. **Archived dependency** — The `httr` package was archived on CRAN.
   This release migrates to `httr2`.

3. **Archived dependency** — The `rjson` package behaviour diverged from
   expectations. This release migrates to `jsonlite`.

### Test environments

* macOS Sequoia 15.x, R 4.6.0 (local)
* Ubuntu 24.04, R 4.4.0 (GitHub Actions)
* Windows Server 2022, R-devel (win-builder)

### R CMD CHECK results

* 0 ERRORs
* 0 WARNINGs
* 1 NOTE: "New submission" / "checking CRAN incoming feasibility"
  (expected for a major version update with new dependencies)

### Notes on examples

All examples that make network requests are wrapped in `\dontrun{}` to
comply with CRAN policy on internet access in examples. A `bmrb_test()`
function is provided for users to verify connectivity interactively.

### Downstream dependencies

RBMRB has no known reverse dependencies on CRAN.
