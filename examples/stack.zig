const std   = @import("std");

const print= std.debug.print;
const expectEqual = std.testing.expectEqual;

fn Stack(comptime T: type) type {

    const StackNode = struct {
        const Self = @This();
        value: T,
        next: ?*Self,
    };

    return struct {
        const Self = @This();

        head: ?*StackNode,
        alloc: std.mem.Allocator,
        size: usize,

        fn init(alloc: std.mem.Allocator) Self {
            return .{
                .alloc = alloc,
                .head = null,
                .size = 0,
            };
        }

        fn deinit(self: Self) void {
            var current = self.head;
            while (current) |node| {
                const next = node.next;
                self.alloc.destroy(node);
                current = next;
            }
        }

        fn push(self: *Self, value: T) !void {
            var elem = try self.alloc.create(StackNode);

            elem.next  = self.head;
            elem.value = value;
            self.head  = elem;
            self.size += 1;
        }

        fn pop(self: *Self) ?T {
            if (self.head) |head| {
                const returnValue = head.value;
                self.head = head.next;
                self.alloc.destroy(head);
                self.size -= 1;
                return returnValue;
            } 
            return null;
        }

        fn print(self: *Self) void {
            std.debug.print("Stack[{d}] of type: {}\n", .{self.size, @TypeOf(self)});
            var current = self.head;
            while (current) |elem| {
                std.debug.print(" - {d}\n", .{elem.value});
                current = elem.next;
            }
        }
    };
}

pub fn main() !void {
    // var allocator = std.heap.GeneralPurposeAllocator(.{}){};
    // defer _ = allocator.deinit();
    //
    // const gpa = allocator.allocator();
    
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();


    var stack = Stack(i32);
    stack.init(allocator);
    try stack.push(42);
    try stack.push(43);
    try stack.push(44);
    stack.print();
    _ = stack.pop();
    _ = stack.pop();
    stack.print();
}


test "push and pop" {
    const alloc = std.testing.allocator;
    var stack = Stack(i32).init(alloc);
    try stack.push(0);
    try stack.push(1);
    try stack.push(2);

    const two  = stack.pop();
    const one  = stack.pop();
    const zero = stack.pop();

    try expectEqual(zero, 0);
    try expectEqual(one,  1);
    try expectEqual(two,  2);
    // no deinit required, stack should be emtpy
}


test "deinit to free all allocated memory" {
    const alloc = std.testing.allocator;
    var stack = Stack(i32).init(alloc);
    try stack.push(42);
    try stack.push(42);
    try stack.push(42);
    stack.deinit();
}


test "length" {
    const alloc = std.testing.allocator;
    var stack = Stack(i32).init(alloc);
    try expectEqual(@as(usize, 0), stack.size);
    try stack.push(0);
    try expectEqual(@as(usize, 1), stack.size);
    try stack.push(1);
    try expectEqual(@as(usize, 2), stack.size);
    _ = stack.pop();
    try expectEqual(@as(usize, 1), stack.size);
    _ = stack.pop();
    try expectEqual(@as(usize, 0), stack.size);
}

