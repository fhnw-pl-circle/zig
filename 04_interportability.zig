// Zig should be as compatible as possible with its "predecessor" C.

// Run the file with linked libs:
// zig run -lc <filename>.zig

const std = @import("std");


const c = @cImport({
    @cInclude("unistd.h");
    @cInclude("stdio.h");
});

pub fn main() void {
    const write_result = c.write(2, "c.write\n", 8);
    const puts_result  = c.puts("c.puts");

    std.debug.print("c.write: {d} chars written\n", .{write_result});
    std.debug.print("c.puts:  {d} chars written\n", .{puts_result});
}
