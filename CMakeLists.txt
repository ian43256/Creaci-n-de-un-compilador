cmake_minimum_required(VERSION 3.15)
project(ast_bison C)

set(CMAKE_C_STANDARD 11)

if(WIN32)
    list(APPEND CMAKE_PROGRAM_PATH "C:/msys64/usr/bin" "C:/winflexbison")
endif()

find_package(BISON REQUIRED)
find_package(FLEX REQUIRED)

BISON_TARGET(Parser parser.y ${CMAKE_CURRENT_BINARY_DIR}/parser.tab.c
        DEFINES_FILE ${CMAKE_CURRENT_BINARY_DIR}/parser.tab.h)
FLEX_TARGET(Lexer lexer.l ${CMAKE_CURRENT_BINARY_DIR}/lexer.yy.c)
ADD_FLEX_BISON_DEPENDENCY(Lexer Parser)

include_directories(${CMAKE_CURRENT_BINARY_DIR})

add_executable(ast_bison
        main.c
        ${BISON_Parser_OUTPUTS}
        ${FLEX_Lexer_OUTPUTS})