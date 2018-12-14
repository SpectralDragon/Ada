//
//  Ada.swift
//  ada-swiftpm
//
//  Created by v.a.prusakov on 04/12/2018.
//

import Files
import Commander
import Foundation

final class AdaTool {
    
    enum Mode {
        case initPackage
        case resolve
        case update
        case convert
    }
    
    private let args: [String]
    
    init(args: [String]) {
        self.args = args
    }
    
    func run() {
        
        do {
            
            let commandTool = CommandTool(toolName: "ada", usage: "", key: Mode.self)
            commandTool.bind(command: "init", key: .initPackage)
            commandTool.bind(command: "update", key: .update)
            
            let result = try commandTool.parse(arguments: self.args)
            
            try handleCommand(result, verbose: true)
            
        } catch {
            handleError(error)
        }
    }
    
    private func bindCommands() throws {
        
        
    }
    
    private func handleCommand(_ command: Command<Mode>, verbose: Bool) throws {
        
        let currentFolder = Folder.current
        
        switch command.type {
        case .initPackage:
            
            let fullInit = command.contains("fullInit")
            
            guard currentFolder.containsFile(named: "Package.swift") && !fullInit else {
                throw AdaTool.Error.problem("Package.swift not found")
            }
            
            let package = InitPackage(name: currentFolder.nameExcludingExtension, destinationFolder: currentFolder, initSwiftPM: fullInit)
            try package.createPackage()
        case .resolve:
            print("resolve")
        case .update:
            print("update")
        case .convert:
            let packageFile = try currentFolder.file(named: "Package.swift")
            
            let converter = PackageConverter(destinationFolder: currentFolder)
            try converter.convert(toPodspec: packageFile)
        }
    }
}

func handleError(_ error: Error) -> Never {
    print(error.localizedDescription)
    exit(0)
}

extension AdaTool {
    enum Error: LocalizedError {
        case problem(String)
        
        var errorDescription: String? {
            switch self {
            case .problem(let problem):
                return problem
            }
        }
    }
}

final class CommandTool<T> {
    
    private let toolName: String
    private let usage: String
    
    private var commands: [Command<T>]
    
    init(toolName: String, usage: String, key: T.Type) {
        self.toolName = toolName
        self.usage = usage
        self.commands = []
    }
    
    func bind(command name: String, arguments: [Argument] = [], key: T) {
        let command = Command(name: name, key: key, arguments: arguments)
        self.commands.append(command)
    }
    
    func parse(arguments args: [String]) throws -> Command<T> {
        guard !args.isEmpty else { throw AdaTool.Error.problem(usage) }
        
        var arguments = args
        
        let toolName = arguments.removeFirst()
        
        guard toolName == self.toolName else { throw AdaTool.Error.problem("It's not correct tool name") }
        
        let commandArgument = arguments.removeFirst()
        
        guard let command = self.commands.first(where: { $0.name == commandArgument }) else { throw AdaTool.Error.problem("Can't find") }
        return command
    }
}



struct Argument {
    let name: String
    let shortName: String
}

final class Command<T> {
    
    let name: String
    let type: T
    let arguments: [Argument]
    
    init(name: String, key: T, arguments: [Argument]) {
        self.name = name
        self.type = key
        self.arguments = arguments
    }
    
    func contains(_ argName: String) -> Bool {
        return self.arguments.contains { $0.name == argName || $0.shortName == argName }
    }
    
    func argument(by name: String) -> Argument? {
        return self.arguments.first { $0.name == name || $0.shortName == name }
    }
    
}
