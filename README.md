# quartr

It takes a fair bit of boilerplate to spin up any new project. I wanted to have
a repo I could clone for [Quart](https://quart.palletsprojects.com/en/latest/)
projects as a starting point.

Some of the things this repo has to offer:

* A Quart "Hello World"-style app as a starting point
* A linting/test suite for this app with 100% coverage and no warnings
* A Dockerfile for containerizing the app and running it under hypercorn
* A fully-functioning devcontainer configuration

Take a look at the [Makefile](./Makefile) or do `make help` for guidance on how
to build and run quartr.

For things I _want_ this repo to have, take a peek at [TODO.md](./TODO.md).
