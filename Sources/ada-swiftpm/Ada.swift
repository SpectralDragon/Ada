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
        self.bindCommands()
        self.group.run()
    }
    
    private(set) var group: Group!
    
    private func bindCommands(errorHandler: @escaping (Error) throws -> Void) rethrows {
        
        let verboseFlag = Flag("verbose", default: false, flag: "v", description: "verbose all actions")
        
        self.group = Group { mainGroup in
            mainGroup.group("ada", nil, closure: { ada in
                ada.command("init", Flag("full", default: false, description: "Setup Swift Package Manager too"), verboseFlag, description: "Initialize ada package") { fullInit, verbose in
                    errorHandler(try self.handleCommand(.initPackage(full: fullInit), verbose: verbose))
                }
                
                ada.command("install", verboseFlag, description: "Download and install dependencies to Package.swift") { verbose in
                    self.handleCommand(.resolve, verbose: verbose)
                }
                
                ada.command("update", verboseFlag, description: "Update all dependencies", { verbose in
                    self.handleCommand(.update, verbose: verbose)
                })
            })
        }
    }
    
    private func handleCommand(_ mode: Mode, verbose: Bool) {
        switch mode {
        case .initPackage(full: let fullInit):
            let currentFolder = Folder.current
            
            guard currentFolder.containsFile(named: "Package.swift") else {
                
            }
            
            let package = InitPackage(name: currentFolder.nameExcludingExtension)
            
        case .resolve:
            print("resolve")
        case .update:
            print("update")
        }
    }
}


final class InitPackage {
    
    init(name: String) {
        
    }
}
