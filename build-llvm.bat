@echo off

set CC=clang
set CFLAGS=-c -O3 -I../include -std=c17 -pedantic -Wall -Wextra -Wno-deprecated-declarations
set LFLAGS=-luser32 -lgdi32
set SRC=%1

if not defined SRC (
    set SRC=*
)

pushd build

echo compiling with %CC%...
call %CC% ../src/%SRC%.c %CFLAGS%
echo done!
echo -----------------------------

if %errorlevel% == 0 (
    echo creating archive...
    if not exist ..\lib mkdir ..\lib
    call llvm-ar rcs ../lib/easy2d.lib *.o
    echo done!
    echo -----------------------------
)

popd
