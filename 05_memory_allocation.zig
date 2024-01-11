// Zig uses allocators, implemented in Zig, to allocate memory.
// There is No default allocator, only explicit allocators are used.

// Example allocators:
// - ArenaAllocator
// - HeapPageAllocator
// - FixedBufferAllocator
// - GeneralPurposeAllocator
// - TestingAllocator
// - ...
// - write your own
//
// (Talk about allocators: https://www.youtube.com/watch?v=vHWiDx_l4V0)
//

const std = @import("std");

const print = std.debug.print;


// Allocate array of 100 u8 values
pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();

    const bytes = try allocator.alloc(u8, 100);
    print("bytes = {*}", .{bytes});
    defer allocator.free(bytes);
}





// Showcase: forget deinit

test "detect leak" {
    var list = std.ArrayList(u21).init(std.testing.allocator);
    defer list.deinit();

    try list.append('☔');
    try std.testing.expect(list.items.len == 1);
}

