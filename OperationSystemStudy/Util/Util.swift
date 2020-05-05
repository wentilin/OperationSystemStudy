//
//  Util.swift
//  OperationSystemStudy
//
//  Created by wentilin on 2020/5/5.
//  Copyright © 2020 wentilin. All rights reserved.
//

import Foundation

import Foundation

func abstract(_ object: AnyObject, _ function: StaticString = #function, _ file: StaticString = #file, _ line: Int = #line) -> Never {
    NSException(name: .invalidArgumentException, reason: "Abstract class \"\(type(of: object))\" function \"\(function)\" at line \(line) in file \"\(file)\"", userInfo: nil).raise()
    exit(1)
}

func abstract(_ `class`: AnyClass, _ function: StaticString = #function, _ file: StaticString = #file, _ line: Int = #line) -> Never {
    NSException(name: .invalidArgumentException, reason: "Abstract class \"\(`class`)\" function \"\(function)\" at line \(line) in file \"\(file)\"", userInfo: nil).raise()
    exit(1)
}

func notImplemented(_ function: StaticString = #function, _ file: StaticString = #file, _ line: Int = #line) -> Never {
    NSException(name: .invalidArgumentException, reason: "Unimplemented function \"\(function)\" at line \(line) in file \"\(file)\"", userInfo: nil).raise()
    exit(1)
}

func obsoleteImplementation(_ function: StaticString = #function, _ file: StaticString = #file, _ line: Int = #line) -> Never {
    NSException(name: .invalidArgumentException, reason: "Function \"\(function)\" at line \(line) in file \"\(file)\" was obsolete.", userInfo: nil).raise()
    exit(1)
}
