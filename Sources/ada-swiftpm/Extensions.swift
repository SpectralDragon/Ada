//
//  Ada.swift
//  ada-swiftpm
//
//  Created by v.a.prusakov on 03/12/2018.
//

import Foundation

extension Process {
    public func shell(command: String) -> String {
        launchPath = "/bin/bash"
        arguments = ["-c", command]
        
        let outputPipe = Pipe()
        standardOutput = outputPipe
        launch()
        
        let data = outputPipe.fileHandleForReading.readDataToEndOfFile()
        guard let outputData = String(data: data, encoding: String.Encoding.utf8) else { return "" }
        
        return outputData
    }
}


public func launch(command: String, arguments: String...) -> String {
    let process = Process()
    let command = "\(command) \(arguments.joined(separator: " "))"
    return process.shell(command: command)
}
