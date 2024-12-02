import SwiftUI
import Foundation

// MARK: - State Protocol
protocol PlayerState {
    var player: VideoPlayer { get }
    
    func play()
    func pause()
    func stop()
}

// MARK: - Context
final class VideoPlayer {
    private var state: PlayerState? = nil

    init() {}

    func setState(_ state: PlayerState) {
        self.state = state
    }

    func play() {
        state?.play()
    }
    
    func pause() {
        state?.pause()
    }
    
    func stop() {
        state?.stop()
    }
}

// MARK: - Concrete States
class PlayingState: PlayerState {
    var player: VideoPlayer

    init(player: VideoPlayer) {
        self.player = player
    }

    func play() {
        print("Already playing.")
    }

    func pause() {
        print("Pausing playback...")
        player.setState(PausedState(player: player))
    }

    func stop() {
        print("Stopping playback...")
        player.setState(StoppedState(player: player))
    }
}

class PausedState: PlayerState {
    var player: VideoPlayer

    init(player: VideoPlayer) {
        self.player = player
    }

    func play() {
        print("Resuming playback...")
        player.setState(PlayingState(player: player))
    }

    func pause() {
        print("Already paused.")
    }

    func stop() {
        print("Stopping playback...")
        player.setState(StoppedState(player: player))
    }
}

class StoppedState: PlayerState {
    var player: VideoPlayer

    init(player: VideoPlayer) {
        self.player = player
    }

    func play() {
        print("Starting playback...")
        player.setState(PlayingState(player: player))
    }

    func pause() {
        print("Cannot pause. Player is stopped.")
    }

    func stop() {
        print("Already stopped.")
    }
}

private struct ContentView: View {
    var body: some View {
        Button("Execute") {
            // MARK: - Example Usage
            let player = VideoPlayer()
            player.setState(PlayingState(player: player))
            
            player.play()
            player.pause()
            player.stop()
            player.play()
             
        }
    }
}

#Preview {
    ContentView()
}
                                                   
                                                    
