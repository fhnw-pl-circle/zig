// Zig has no exceptions, instead we can use errors.
// Errors are created in "error sets", which are just a collection of named errors.

const std = @import("std");
const print = std.debug.print;

// Custom errors
const NumberError = error{
    TooSmall,
    TooBig,
};

pub fn main() void {

    var num_or_error: NumberError!u8 = undefined;
    num_or_error = 12;
    num_or_error = NumberError.TooSmall;


    const result: u32 = addFive(37) catch |err| {
        _ = err;
        return 0;
    };
    print("result={}\n", .{result});


    if (addFive(37)) |value| {
        print("value={}\n", .{value});
    } else |err| {
        switch (err) {
            NumberError.TooSmall => print("error={}\n", .{err}),
            NumberError.TooBig   => print("error={}\n", .{err}),
        }
    }
}

fn addFive(n: u32) NumberError!u32 {
    //try is a shortcut for: detect(n) catch |err| return err;
    const x = try detect(n);

    return x + 5;
}

fn detect(n: u32) NumberError!u32 {
    if (n < 10) return NumberError.TooSmall;
    if (n > 20) return NumberError.TooBig;
    return n;
}
