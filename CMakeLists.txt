cmake_minimum_required(VERSION 3.15)
project(ast_bison C)

set(CMAKE_C_STANDARD 11)

# Rutas comunes donde se instalan Flex y Bison en Windows
if(WIN32)
    list(APPEND CMAKE_PROGRAM_PATH "C:/msys64/usr/bin" "C:/winflexbison")
endif()

find_package(BISON REQUIRED)
find_package(FLEX REQUIRED)

include_directories(${CMAKE_CURRENT_BINARY_DIR})

# ---------------------------------------------
# Programa principal: AST con Flex + Bison
# ---------------------------------------------
BISON_TARGET(Parser parser.y ${CMAKE_CURRENT_BINARY_DIR}/parser.tab.c
        DEFINES_FILE ${CMAKE_CURRENT_BINARY_DIR}/parser.tab.h)
FLEX_TARGET(Lexer lexer.l ${CMAKE_CURRENT_BINARY_DIR}/lexer.yy.c)
ADD_FLEX_BISON_DEPENDENCY(Lexer Parser)

add_executable(ast_bison
        main.c
        ${BISON_Parser_OUTPUTS}
        ${FLEX_Lexer_OUTPUTS})

# ---------------------------------------------
# Un ejecutable por cada lexer dentro de lexers/
# Cada archivo .l debe incluir su propio main()
# ---------------------------------------------
file(GLOB LEXER_FILES CONFIGURE_DEPENDS ${CMAKE_SOURCE_DIR}/lexers/*.l)
foreach(LEXER_FILE ${LEXER_FILES})
    get_filename_component(LEXER_NAME ${LEXER_FILE} NAME_WE)
    FLEX_TARGET(${LEXER_NAME} ${LEXER_FILE} ${CMAKE_CURRENT_BINARY_DIR}/${LEXER_NAME}.yy.c)
    add_executable(${LEXER_NAME} ${FLEX_${LEXER_NAME}_OUTPUTS})
endforeach()