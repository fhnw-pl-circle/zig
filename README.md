# Zig: A General-Purpose Programming Language (Version 0.11.0)

## Features
- Robust, efficient, and reusable
- Simple
- Compile-time features

## What is Zig?
- Aims to be a modern replacement for C
- No preprocessor or macros
- No classes, no garbage collection
- Functions can be attached to structs, unions, and enums
- Powerful cross-compilation capabilities
- ...

## Hello World Example
```c
// main.zig

const std = @import("std");

pub fn main() !void {
    std.debug.print("Hello, World!\n", .{});
}
```
Build and run with:
```sh
zig run main.zig
```

## Resources
- [Ziglang Homepage](https://ziglang.org/)
- [Code Examples](https://ziglang.org/learn/samples/)
- [Official Documentation](https://ziglang.org/documentation/master/)
- [In depth Overview](https://ziglang.org/learn/overview/)
- [Cookbook](https://zigcc.github.io/zig-cookbook/) - some further examples
- [Zig Guide](https://zig.guide/)

### Talks by Andrew Kelly, Founder of Zig
- [Intro to the Zig Progarmming Language](https://www.youtube.com/watch?v=YXrb-DqsBNU)
- [The Road of Zig](https://www.youtube.com/watch?v=Gv2I7qTux7g)
- [Zig: A Programming Language designed for robustness, optimality, and clarity](https://www.youtube.com/watch?v=Z4oYSByyRak)
- [Practical DOD](https://vimeo.com/649009599)

### Talk About Allocators and Their Trade-offs
- [What's a Memory Allocator Anyway?](https://www.youtube.com/watch?v=vHWiDx_l4V0) - by Benjamin Feng

### Projects Built with Zig
- [River - Linux Wayland Tiling Window Manager](https://github.com/riverwm/river)
- [Bun - Toolkit for JS and TS](https://github.com/oven-sh/bun)
