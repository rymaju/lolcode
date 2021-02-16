# 😹 LOLCODE in (λ)

Implementation of [LOLCODE](https://en.wikipedia.org/wiki/LOLCODE) in [Racket](https://racket-lang.org/). Currently the plan is to hack everything in [spec 1.2](https://github.com/justinmeza/lolcode-spec/blob/master/v1.2/lolcode-spec-v1.2.md) together  with `#lang br` to get a proof of concept down. Once thats done, I plan to do a proper rewrite in Typed Racket or Racket with Contracts. Finally, robust testing with `rackunit`.

Once 1.2 is down, I plan to branch it off to another branch off of `main`, and start work on 1.3 with backwards compatibility.

## 🔨 Current status

Legend:
- ✔️ Complete!
- 🚧 Work in Progress: at least partially implemented but failing at least one test
- ❌ Incomplete / Not Started

### 🌺 Milestone: proof of concept LOLCODE 1.2 in `#lang br`

- ✔️ Assignment and Variables
- ✔️ Casting
- ✔️ Functions
- ✔️ Math
- ✔️ Comparison
- 🚧 IT
- ✔️ Comparison
- ✔️ If/else
- ❌ Case
- ❌ Loops
- 🚧 IO
- ❌ String formatting

### ⚖️ Milestone: Rewrite with types or contracts

*COMING SOON*

### 🧪 Milestone: Tests, tests, and more tests

*COMING SOON*

### 😼 Milestone: LOLCODE 1.3

*COMING SOON*

## ℹ️ More info
This is mainly an exercise in writing languages with Racket. My aim is to keep things concise and simple enough for anyone to open up any file and understand the code. I'm also just a second year college student, so the code will be rough. I hope to maintain this project for a while.

Contributions will eventually be welcome but as of right now the project is just too unfinished. I plan to open up for contributions once I have a good test suite and contracts/types.
