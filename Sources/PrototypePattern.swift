import SwiftUI
import Foundation

protocol Copyable {
    init(_ prototype: Self)
}

extension Copyable {
    func copy() -> Self {
        return type(of: self).init(self)
    }
}

class Monster: Copyable {
    
    var health: Int
    var level: Int
    
    init(health: Int, level: Int) {
        self.health = health
        self.level = level
    }
    
    required convenience init(_ monster: Monster) {
        self.init(health: monster.health, level: monster.level)
    }
}

class EyeballMonster: Monster {
    
    var redness = 0
    
    init(health: Int, level: Int, redness: Int) {
        self.redness = redness
        super.init(health: health, level: level)
    }
    
    required convenience init(_ prototype: Monster) {
        self.init(health: prototype.health,
                  level: prototype.level,
                  redness: 0)
    }
}

private struct ContentView: View {
    var body: some View {
        Button("Execute") {
            // MARK: - Example Usage
            let monster = Monster(health: 700, level: 37)
            let monster2 = monster.copy()
            
            print(monster === monster2)
            
            monster2.level = 30
            print(monster.level, monster2.level)
            
            let eyeball = EyeballMonster(
                health: 3002,
                level: 60,
                redness: 999
            )
            let eyeball2 = eyeball.copy()
            
            print(eyeball2.redness)
            
            let eyeballMonster3 = EyeballMonster(monster)
            print(type(of: eyeballMonster3))
        }
    }
}

#Preview {
    ContentView()
}
