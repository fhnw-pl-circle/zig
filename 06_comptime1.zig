const std     = @import("std");
const builtin = @import("builtin");

const print       = std.debug.print;
const assert      = std.debug.assert;
const expect      = std.testing.expect;
const expectEqual = std.testing.expectEqual;


pub fn main() void {
    print("run the tests!\n", .{});
}

// Currently used OS

const os = builtin.os.tag;

test "conditional compilation" {
    if (os == .windows) {
        @compileError("Something went wrong!");
    } else if (os == .macos) {
        @compileError("Something went wrong!");
    } else if (os == .linux) {
        try expectEqual(os, .linux);
    }
}




// Types are value

test "types are values" {
    const my_int: type = i32;
    try expectEqual(my_int, i32);

    const my_str = @TypeOf("hello world");
    try expectEqual(my_str, *const [11:0]u8);
}




// Mutable comptime variables

test "mutable comptime variables" {
    comptime var count = 0;

    count += 1;
    const a1: [count]u8 = .{'A'} ** count; // ** repeat

    count += 1;
    const a2: [count]u8 = .{'B'} ** count;

    count += 1;
    const a3: [count]u8 = .{'C'} ** count;

    try expectEqual(a1, .{'A'});
    try expectEqual(a2, .{ 'B', 'B' });
    try expectEqual(a3, .{ 'C', 'C', 'C' });
}




// Inline for-loops (for-loop at comptime)

const TestObject = struct {
    size: u32,
    x: f64,
    y: f64,
};

test "inline for" {
    const fields = @typeInfo(TestObject).Struct.fields;
    comptime var len = 0;
    inline for (fields) |field| {
        len += field.name.len;
    }
    try expectEqual(len, 6);
}





test "inline for 2" {
    inline for (.{ u8, u16, u32, u64 }, 3..) |T, i| {
        const n_bits = @typeInfo(T).Int.bits;
        const index  = @as(f64, i);
        const i_exp  = @exp2(index);

        // @compileLog(expected_bits);
        // @compileLog(n_bits);

        try expectEqual(i_exp, n_bits);
    }
}



// Call same function at comptime and runtime

fn fibonacci(index: u32) u32 {
    if (index < 2) return index;
    return fibonacci(index - 1) + fibonacci(index - 2);
}

test "fibonacci" {
    // test fibonacci at run-time
    try expect(fibonacci(7) == 13);

    // test fibonacci at compile-time
    try comptime expect(fibonacci(7) == 13);
}




// Create types

fn GetBiggerInt(comptime T: type) type {
    return @Type(.{
        .Int = .{
            .bits = @typeInfo(T).Int.bits + 1,
            .signedness = @typeInfo(T).Int.signedness,
        },
    });
}

test "Increase integer size" {
    try expect(GetBiggerInt(u8) == u9);
    try expect(GetBiggerInt(i31) == i32);
}
