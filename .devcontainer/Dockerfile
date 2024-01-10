FROM mcr.microsoft.com/vscode/devcontainers/base:0-alpine

ADD https://ziglang.org/download/0.11.0/zig-linux-x86_64-0.11.0.tar.xz /zig.tar.xz
RUN tar -xvf /zig.tar.xz && mv /zig-linux-x86_64-0.11.0 /zig && chown -R vscode /zig
ENV PATH="/zig:${PATH}"