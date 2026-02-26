# Contributing to the OpenAQ R client

We welcome contributions to the OpenAQ R client! Here's a guide on how to
contribute effectively.

## Code of Conduct

Please review and adhere to our Code of Conduct:
[https://github.com/openaq/.github/blob/main/CODE_OF_CONDUCT.md](https://github.com/openaq/.github/blob/main/CODE_OF_CONDUCT.md) and organizational contribution guide: [https://github.com/openaq/.github/blob/main/CONTRIBUTING.md](https://github.com/openaq/.github/blob/main/CONTRIBUTING.md)

## Getting Started

Before contributing, please read the [Development Guide](DEVELOPMENT.md) for
instructions on setting up the package locally, running tests, and checking
code style.

## Reporting Issues and Questions

Before creating a new issue, search the existing issues to see if your problem
has already been reported. When reporting bugs or proposing features, please use
one of the provided issue templates:

- **Bug Report:** Clearly describe the bug, including steps to reproduce it.
- **Feature Request:** Explain the desired feature and its benefits.
- **Documentation:** Provide feedback on documentation improvements.

For general questions and discussions, please use the project
[discussions](https://github.com/openaq/openaq-r/discussions) rather than the
issue tracker.

## Submitting Pull Requests

1. Fork the repository to your GitHub account.
2. Create a new branch for your feature or bug fix.
3. Make your changes following the guidelines below.
4. Push your branch and open a pull request linked to an existing issue.
   **(Pull requests must be linked to an existing issue.)**

### Guidelines

- **Code style:** Lint your changes with `lintr::lint_package()` before
  submitting.
- **Tests:** Include unit tests for any new or changed functionality. See the
  testing [README](tests/README.md) for details.
- **Dependencies:** Keep new external dependencies to a minimum. When possible,
  use base R. Contributions that introduce new dependencies should be discussed
  with the maintainer first.
- **Documentation:** Update roxygen2 comments and vignettes if relevant.
- **Commit messages:** Use clear, concise messages that describe what changed
  and why.
- **Be patient and respectful** of maintainer and reviewer time.
