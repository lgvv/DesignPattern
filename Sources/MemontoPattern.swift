import SwiftUI

// MARK: - Memento
struct GameState {
    let level: Int
    let score: Int
}

// MARK: - Originator
class Game {
    private var level: Int = 1
    private var score: Int = 0

    func play(level: Int, score: Int) {
        self.level = level
        self.score = score
        print("Playing game: Level \(level), Score \(score)")
    }

    func saveState() -> GameState {
        print("Saving state: Level \(level), Score \(score)")
        return GameState(level: level, score: score)
    }

    func restoreState(_ memento: GameState) {
        self.level = memento.level
        self.score = memento.score
        print("Restored state: Level \(level), Score \(score)")
    }
}

// MARK: - Caretaker
class GameSaver {
    private var states: [GameState] = []

    func save(_ state: GameState) {
        states.append(state)
    }

    func restore() -> GameState? {
        guard !states.isEmpty else { return nil }
        return states.removeLast()
    }
}

private struct ContentView: View {
    var body: some View {
        Button("Execute") {
            
            // MARK: - Example Usage
            let game = Game()
            let saver = GameSaver()

            // 플레이하고 상태 저장
            game.play(level: 1, score: 100)
            saver.save(game.saveState())

            game.play(level: 2, score: 300)
            saver.save(game.saveState())

            // 이전 상태로 복원
            if let previousState = saver.restore() {
                game.restoreState(previousState)
            }

            if let initialState = saver.restore() {
                game.restoreState(initialState)
            }

        }
    }
}

#Preview {
    ContentView()
}
