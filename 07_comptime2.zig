const std = @import("std");

const print  = std.debug.print;
const expect = std.testing.expect;


const RealDuck = struct {
    eggs: u8 = 0,
    location_x: i32 = 0,
    location_y: i32 = 0,

    fn quack(self: RealDuck) void {
        print("Quak Quak! - from {}", .{@TypeOf(self)});
    }

    fn waddle(self: *RealDuck, x: i32, y: i32) void {
        self.location_x += x;
        self.location_y += y;
    }
};


const RobotDuck = struct {
    location_x: i32 = 0,
    location_y: i32 = 0,

    fn quack(self: RobotDuck) void {
        print("Beep! Beep!- from {}", .{@TypeOf(self)});
    }

    fn waddle(self: *RobotDuck, x: i32, y: i6) void {
        self.location_x += x;
        self.location_y += y;
    }
};


const Dog = struct {
    fn bark(self: Dog) void {
        print("Wuff Wuff! - from {}", .{@TypeOf(self)});

    }
};


fn is_a_duck(value: anytype) bool {
    const ValueType = @TypeOf(value);

    const quacks_like_duck = @hasDecl(ValueType, "quack");
    const walks_like_duck  = @hasDecl(ValueType, "waddle");

    const is_duck = walks_like_duck and quacks_like_duck;

    if (is_duck) {
        return true;
    }
    return false;
}


test "is this a duck?" {
    const roboDuck = RobotDuck{};
    const realDuck = RealDuck{};
    const dog      = Dog{};

    try expect(is_a_duck(roboDuck));
    try expect(is_a_duck(realDuck));
    try expect(! is_a_duck(dog));
}




pub fn main() void {
    print("run the tests!\n", .{});
}