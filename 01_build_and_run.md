# Create and Run Zig Projects

## Running a Zig file:
- Create a new executable project: `zig init-exe`
- Create a new library project: `zig init-lib`
- Execute a zig file: `zig run <filename>.zig`


## Running the Test Cases:
- Execute all tests in a file: `zig test <filename>.zig`


## Utilizing the Zig Build System
Build System is implemented in Zig.

- Create a new project: `zig init`
- Execute a build step: `zig build run`
- Get a build summary: `zig build --summary all`

## Generate the Documentation
- `zig run -femit-docs <filename>.zig`

## When to use the Build-System?
Provides another layer of abstraction.

- Offers an additional layer of abstraction.
- Ideal scenarios to use the build system:
    - When the command line becomes overly long.
    - When you need to build multiple components or the build process involves numerous steps.
    - To leverage concurrency and caching, thus reducing build times.
    - To expose configuration options for the project.
    - When the build process varies depending on the target system and other options.
    - When there are dependencies on other projects.
    - And more...
