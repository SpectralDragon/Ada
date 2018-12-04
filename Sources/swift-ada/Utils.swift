//
//  Utils.swift
//  ada-swiftpm
//
//  Created by v.a.prusakov on 04/12/2018.
//

import Foundation

func doOrError(_ block: @autoclosure () throws -> Void, errorHandler: @escaping (Error) -> Void) {
    do {
        try block()
    } catch {
        errorHandler(error)
    }
}
