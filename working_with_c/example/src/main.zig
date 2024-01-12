// Run the build script:
// zig build run

const std = @import("std");
const math = @cImport({ 
    @cInclude("math.h"); 
});

pub fn main() !void {
    const a = 4;
    const b = 2;

    const result = math.add(a, b);
    std.debug.print("{} + {} = {}\n" , .{a, b, result});
}
