const std = @import("std");
const expect = @import("std").testing.expect;
const out = std.io.getStdOut().writer();
const in = std.io.getStdIn().reader();
const print = std.debug.print;

const MAX_INPUT_LEN = 100;
const MAX_ARGS = 10;

fn shellLoop(stdin: anytype, stdout: anytype) !void {
    while (true) {
        try stdout.print("⚡> ", .{});

        var inputBuffer: [MAX_INPUT_LEN]u8 = undefined;
        const inputStr = (try stdin.readUntilDelimiterOrEof(inputBuffer[0..], '\n')) orelse {
            try stdout.print("\n", .{});
            return;
        };
        if (inputStr.len == 0) continue;

        //fn execvpeZ(file: [*:0]const u8, argv_ptr: [*:null]const ?[*:0]const u8, envp: [*:null]const ?[*:0]const u8) ExecveError
        var args: [MAX_ARGS][MAX_INPUT_LEN:0]u8 = undefined;
        var argsPtr: [MAX_ARGS:null]?[*:0]u8 = undefined;

        var i: u8 = 0;

        var tokens = std.mem.splitAny(u8, inputStr, " ");

        while (tokens.next()) |token| : (i += 1) {
            @memcpy(args[i][0..token.len], token);
            args[i][token.len] = 0;
            argsPtr[i] = &args[i];
        }
        argsPtr[i] = null;
        const forkPid = try std.os.fork();

        if (forkPid == 0) {
            // child process
            const env = [_:null]?[*:0]u8{null};
            const result = std.os.execvpeZ(argsPtr[0].?, &argsPtr, &env);
            try stdout.print("ERROR: {}\n", .{result});

            return;
        } else {
            const waitResult = std.os.waitpid(forkPid, 0);
            if (waitResult.status != 0) {
                try stdout.print("Command returned with: {}\n", .{waitResult});
            }
        }
    }
}

pub fn main() !void {
    try out.print("THE ZIG SHELL\n", .{});
    try shellLoop(in, out);
}
