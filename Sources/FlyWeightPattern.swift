import UIKit
import SwiftUI

class Character {
    // MARK: - Intrinsic State (공유 상태)
    let font: String
    let color: String

    init(font: String, color: String) {
        self.font = font
        self.color = color
    }

    func display(with text: String, at position: CGPoint) {
        print("Displaying '\(text)' at \(position) using font: \(font), color: \(color)")
    }
}

class CharacterFactory {
    private var characters: [String: Character] = [:]

    func getCharacter(font: String, color: String) -> Character {
        let key = "\(font)-\(color)"
        if let character = characters[key] {
            return character
        } else {
            let newCharacter = Character(font: font, color: color)
            characters[key] = newCharacter
            return newCharacter
        }
    }
}


private struct ContentView: View {
    var body: some View {
        Button("Execute") {
            let factory = CharacterFactory()

            // 내재 상태가 동일한 경우 재사용
            let redArial = factory.getCharacter(font: "Arial", color: "Red")
            redArial.display(with: "Hello", at: CGPoint(x: 10, y: 20)) // 외재 상태 전달

            let blueArial = factory.getCharacter(font: "Arial", color: "Blue")
            blueArial.display(with: "World", at: CGPoint(x: 30, y: 40)) // 외재 상태 전달

            let anotherRedArial = factory.getCharacter(font: "Arial", color: "Red")
            print("redArial === anotherRedArial: ", redArial === anotherRedArial) // true (공유된 객체)
            print("redArial === blueArial: ", redArial === blueArial) // true (공유된 객체)
        }
    }
}

#Preview {
    ContentView()
}
