//
//  PackageConverter.swift
//  swift-ada
//
//  Created by v.a.prusakov on 13/12/2018.
//

import Foundation
import Files

final class PackageConverter {
    
    private let destinationFolder: Folder
    
    private let packageName = "Package.swift"
    
    init(destinationFolder: Folder) {
        self.destinationFolder = destinationFolder
    }
    
    func convert(toPodspec package: File) throws {
        let packageString = try package.readAsString()
        
        print(packageString)
    }
    
}
