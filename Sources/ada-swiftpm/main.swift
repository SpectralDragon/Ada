
import Files
import Commander
import Foundation


final class Ada {
    
    private(set) var group: Group!
    
    func bindCommands() {
        self.group = Group { mainGroup in
            mainGroup.group("swift", closure: { (swiftGroup) in
                swiftGroup.group("ada", nil, closure: { adaGroup in
                    adaGroup.command("init", description: "Initialize ada package", {
                        print("kek")
                    })
                })
            })
            
            
        }
    }
    
    func run() {
        self.group.run()
    }
}

let ada = Ada()
ada.bindCommands()
ada.run()
