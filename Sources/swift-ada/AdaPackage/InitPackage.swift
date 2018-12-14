//
//  InitPackage.swift
//  ada-swiftpm
//
//  Created by v.a.prusakov on 04/12/2018.
//

import Foundation
import Files

final class InitPackage {
    
    private let name: String
    private let needsInitSwiftPM: Bool
    private let destinationFolder: Folder
    
    private let baseName = "AdaPackage"
    
    init(name: String, destinationFolder: Folder, initSwiftPM: Bool) {
        self.name = name
        self.destinationFolder = destinationFolder
        self.needsInitSwiftPM = initSwiftPM
    }
    
    func createPackage() throws {
        if needsInitSwiftPM {
            let result = Process.launch(command: "swift package init", arguments: "")
            print(result)
        }
        
        try createFolder()
        try createManifest()
        
    }
    
    private func createFolder() throws {
        try destinationFolder.createSubfolderIfNeeded(withName: "Ada")
    }
    
    private func createManifest() throws {
        
        let manifestFile = "\(baseName).swift"
        
        if destinationFolder.containsFile(named: manifestFile) {
            try destinationFolder.file(named: manifestFile).delete()
        }
        
        let content =
        """
        import AdaPackageDescriptor
        
        let ada = AdaPackage(dependencies: [
                    // .pod(name: /* pod name */, .branch("master"))
                ])
        
        """
        
        try destinationFolder.createFile(named: manifestFile, contents: content)
    }
}
