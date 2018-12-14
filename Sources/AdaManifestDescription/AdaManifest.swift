import Foundation

//public final class AdaManifest {
//    
//    public class Dependency: Encodable {
//        
//        public enum Requirement {
//            public enum Git {
//                case branch(String)
//                case commit(String)
//                case tag(String)
//            }
//            case git(url: String, Git)
//            case path(url: String)
//        }
//        
//        public let name: String
//        public let requirement: Requirement
//        
//        public var url: String {
//            switch requirements {
//            case let .path(url: url):
//                return url
//            case let .git(url: url, _):
//                return url
//            }
//        }
//        
//        var isLocalPackage: Bool {
//            if case .path = requirements {
//                return true
//            }
//            
//            return false
//        }
//        
//        init(name: String, requirement: Requirement) {
//            self.name = name
//            self.requirement = requirement
//        }
//    }
//    
//    public var dependencies: [Dependency]
//    
//    init(dependencies: [Dependency]) {
//        self.dependencies = dependencies
//    }
//    
//}
//
//extension AdaManifest.Dependency {
//    
//    public static func pod(name: String, _ requirement: Requirement) -> AdaManifest.Dependency {
//        return AdaManifest.Dependency(name: name, requirement: requirement)
//    }
//}
