//
//  StringCasesTestCase.swift
//  LARA
//
//  Created by Marcin Raburski on 26/09/2016.
//  Copyright © 2016 Utility Warehouse. All rights reserved.
//

import XCTest
import StringCase

class StringCasesTestCase: XCTestCase {
    
    func testCorrectlyDeterminesCase() {
        // Positives
        XCTAssertEqual("snake_case".getCase(), .snake)
        XCTAssertEqual("camelCase".getCase(), .camel)
        XCTAssertEqual("PascalCase".getCase(), .pascal)
        XCTAssertEqual("cobol-case".getCase(), .cobol)
        XCTAssertEqual("MACRO_CASE".getCase(), .macro)
        XCTAssertEqual("dot.super.case".getCase(), .dot)
        
        // Negatives
        XCTAssertEqual("No special case.".getCase(), .unknown)
        XCTAssertEqual("No_special case".getCase(), .unknown)
        XCTAssertEqual("noSpecial case.".getCase(), .unknown)
        XCTAssertEqual("-no-special-case".getCase(), .unknown)
    }
    
    func testConvertsSnakeCase() {
        XCTAssertEqual("snake_case".cased(.camel), "snakeCase")
        XCTAssertEqual("snake_case".cased(.cobol), "snake-case")
        XCTAssertEqual("snake_case".cased(.pascal), "SnakeCase")
        XCTAssertEqual("snake_case".cased(.dot), "snake.case")
        XCTAssertEqual("snake_case".cased(.snake), "snake_case")
        XCTAssertEqual("snake_case".cased(.macro), "SNAKE_CASE")
    }
    
    func testConvertsCamelCase() {
        XCTAssertEqual("camelCase".cased(.camel), "camelCase")
        XCTAssertEqual("camelCase".cased(.cobol), "camel-case")
        XCTAssertEqual("camelCase".cased(.pascal), "CamelCase")
        XCTAssertEqual("camelCase".cased(.dot), "camel.case")
        XCTAssertEqual("camelCase".cased(.snake), "camel_case")
        XCTAssertEqual("camelCase".cased(.macro), "CAMEL_CASE")
    }
    
    func testConvertsCobolCase() {
        XCTAssertEqual("cobol-case".cased(.camel), "cobolCase")
        XCTAssertEqual("cobol-case".cased(.cobol), "cobol-case")
        XCTAssertEqual("cobol-case".cased(.pascal), "CobolCase")
        XCTAssertEqual("cobol-case".cased(.dot), "cobol.case")
        XCTAssertEqual("cobol-case".cased(.snake), "cobol_case")
        XCTAssertEqual("cobol-case".cased(.macro), "COBOL_CASE")
    }
    
    func testConvertsPascalCase() {
        XCTAssertEqual("PascalCase".cased(.camel), "pascalCase")
        XCTAssertEqual("PascalCase".cased(.cobol), "pascal-case")
        XCTAssertEqual("PascalCase".cased(.pascal), "PascalCase")
        XCTAssertEqual("PascalCase".cased(.dot), "pascal.case")
        XCTAssertEqual("PascalCase".cased(.snake), "pascal_case")
        XCTAssertEqual("PascalCase".cased(.macro), "PASCAL_CASE")
    }
    
    func testConvertsDotCase() {
        XCTAssertEqual("dot.case".cased(.camel), "dotCase")
        XCTAssertEqual("dot.case".cased(.cobol), "dot-case")
        XCTAssertEqual("dot.case".cased(.pascal), "DotCase")
        XCTAssertEqual("dot.case".cased(.dot), "dot.case")
        XCTAssertEqual("dot.case".cased(.snake), "dot_case")
        XCTAssertEqual("dot.case".cased(.macro), "DOT_CASE")
    }
    
    func testConvertsMACROCase() {
        XCTAssertEqual("MACRO_CASE".cased(.camel), "macroCase")
        XCTAssertEqual("MACRO_CASE".cased(.cobol), "macro-case")
        XCTAssertEqual("MACRO_CASE".cased(.pascal), "MacroCase")
        XCTAssertEqual("MACRO_CASE".cased(.dot), "macro.case")
        XCTAssertEqual("MACRO_CASE".cased(.snake), "macro_case")
        XCTAssertEqual("MACRO_CASE".cased(.macro), "MACRO_CASE")
    }
}
