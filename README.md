# 😹 LOLCODE in (λ)

Implementation of [LOLCODE](https://en.wikipedia.org/wiki/LOLCODE) in [Racket](https://racket-lang.org/). Currently the plan is to hack everything in [spec 1.2](https://github.com/justinmeza/lolcode-spec/blob/master/v1.2/lolcode-spec-v1.2.md) together with `#lang br` to get a proof of concept down. Once thats done, I plan to do a proper rewrite in Typed Racket or Racket with Contracts. Finally, robust testing with `rackunit`.

Once 1.2 is down, I plan to branch it off to another branch off of `main`, and start work on 1.3 with *some* backwards compatibility.

## New / Breaking changes to LOLCODE 1.2

- Program "version number" (ew) is optional and never used
- String formatting is simplified
  - Removed ":>" (\g beep)
  - Removed ":[unicode char name]"
  - Removed ":\<unicode hex code>"
  - ":" isn't really an escape character, funny : shorthands e.x. ":)" => "/n" doesn't replace the ability to use "/n"
- Added first class functions / lambdas

```
I HAS A FIRST-CLASS-FUNCTION LAMDUH YR X AN YR Y SUM OF X AN Y LAMDONE
I IZ FIRST-CLASS-FUNCTION YR 20 AN YR 22
VISIBLE IT BTW prints 42

I IZ I IZ LAMDUH LAMDUH "nested" LAMDONE LAMDONE MKAY MKAY
VISIBLE IT BTW prints "nested"
```


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
- ✔️ IT
- ✔️ Comparison
- ✔️ If/else
- ✔️ Case
- ✔️ Loops
- ✔️ IO
- ✔️ String formatting (Note that string formatting is not being developed to the 1.2 spec, only var string interpolation is being implemented)

New features to be added:

- ❌ First class functions / Lambdas (FUNKSHUN)

### 🈴 Milestone: Rewrite in racket/base

### ⚖️ Milestone: Rewrite with types or contracts

_COMING SOON_

### 🧪 Milestone: Tests, tests, and more tests

_COMING SOON_

### 😼 Milestone: LOLCODE 1.3

_COMING SOON_

## ℹ️ More info

This is mainly an exercise in writing languages with Racket. My aim is to keep things concise and simple enough for anyone to open up any file and understand the code. I'm also just a second year college student, so the code will be rough. I hope to maintain this project for a while.

Contributions will eventually be welcome but as of right now the project is just too unfinished. I plan to open up for contributions once I have a good test suite and contracts/types.
