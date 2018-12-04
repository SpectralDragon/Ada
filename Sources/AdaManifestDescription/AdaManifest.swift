
import Foundation

public final class AdaManifest {
    
    public class Dependency: Encodable {
        public let url: String
        
        enum Requirements {
            
        }
        
        init(url: String) {
            self.url = url
        }
    }
    
    public var dependencies: [Dependency]
    
    init(dependencies: [Dependency]) {
        self.dependencies = dependencies
    }
    
}

extension AdaManifest.Dependency {
    
    public static func pod(name: String, _ requirement: ) -> AdaManifest.Dependency {
        
    }
    
}
