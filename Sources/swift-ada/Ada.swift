//
//  Ada.swift
//  ada-swiftpm
//
//  Created by v.a.prusakov on 04/12/2018.
//

import Files
import Commander
import Foundation

final class Ada {
    
    enum Mode {
        case initPackage(full: Bool)
        case resolve
        case update
    }
    
    func run() {
        self.bindCommands { error in handleError(error) }
        self.group.run()
    }
    
    private(set) var group: Group!
    
    private func bindCommands(errorHandler: @escaping (Error) -> Void) {
        
        let verboseFlag = Flag("verbose", default: false, flag: "v", description: "verbose all actions")
        
        self.group = Group {
            $0.group("ada", nil) { ada in
                ada.command("init", Flag("full", default: false, description: "Setup Swift Package Manager too"), verboseFlag, description: "Initialize ada package") { fullInit, verbose in
                    doOrError(try self.handleCommand(.initPackage(full: fullInit), verbose: verbose), errorHandler: errorHandler)
                }
                
                ada.command("install", verboseFlag, description: "Download and install dependencies to Package.swift") { verbose in
                    doOrError(try self.handleCommand(.install, verbose: verbose), errorHandler: errorHandler)
                }
                
                ada.command("update", verboseFlag, description: "Update all dependencies") { verbose in
                    doOrError(try self.handleCommand(.update, verbose: verbose), errorHandler: errorHandler)
                }
            }
        }
    }
    
    private func handleCommand(_ mode: Mode, verbose: Bool) throws {
        switch mode {
        case .initPackage(full: let fullInit):
            let currentFolder = Folder.current
            
            guard currentFolder.containsFile(named: "Package.swift") && !fullInit else {
                throw Ada.Error.problem("Package.swift not found")
            }
            
            let package = InitPackage(name: currentFolder.nameExcludingExtension, destination: currentFolder, initSwiftPM: fullInit)
            try package.createPackage()
        case .resolve:
            print("resolve")
        case .update:
            print("update")
        }
    }
}

func handleError(_ error: Error) -> Never {
    print(error.localizedDescription)
    exit(0)
}

extension Ada {
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
