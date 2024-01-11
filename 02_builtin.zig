// Built-in Functions

// Zig Compiler provides builtin functions like `@import`.
// These functions are special, because they can provide functionality
// that is only possible with help from the compiler introspection.

const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    const bits: u8 = 0b11110000;
    const reversed: u8 = @bitReverse(bits);

    print("{b:0>8} backwards is {b:0>8}.\n", .{ bits, reversed });
    print("bits has type {}.\n", .{@TypeOf(bits)});
}
