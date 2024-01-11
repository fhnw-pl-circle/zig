const std = @import("std");

const print  = std.debug.print;
const expect = std.testing.expectEqual;


fn zeroes(comptime T: type, comptime size: usize) [size]T {
    return .{0} ** size;
}


pub fn main() !void {
    const four_zeroes = zeroes(i32, 4);

    for (1.., four_zeroes) |i, n| {
        print("{}: {}\n", .{ i, n });
    }
}


test "zeroes of different types" {
    const size = 3;

    const int_array = zeroes(u8, size);
    try expect(@TypeOf(int_array), [size]u8);

    const float_array = zeroes(f64, size);
    try expect(@TypeOf(float_array), [size]f64);
}
