//
//  ManifestLoader.swift
//  ada-swiftpm
//
//  Created by v.a.prusakov on 04/12/2018.
//

import Files
import Foundation

class ManifestLoader {
    
    private let file: File
    
    init(file: File) {
        self.file = file
    }
    
    func parse() throws {
        let read = try self.file.read()
        
    }
    
}
