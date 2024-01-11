// Run the build script:
// zig build run

const std = @import("std");
const foo = @cImport({ 
    @cInclude("foo.h"); 
});

pub fn main() !void {
    const a = 4;
    const b = 2;

    const result = foo.foo_add(a, b);
    std.log.info("{} + {} = {}" , .{a, b, result});
}