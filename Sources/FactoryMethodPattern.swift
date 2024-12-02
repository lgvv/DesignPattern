import SwiftUI

protocol Transport {
    func deliver()
}

class Truck: Transport {
    func deliver() {
        print("Delivering by truck!")
    }
}

class Ship: Transport {
    func deliver() {
        print("Delivering by ship!")
    }
}

protocol Logistics {
    func createTransport() -> Transport
}

class RoadLogistics: Logistics {
    func createTransport() -> Transport {
        return Truck()
    }
}

class SeaLogistics: Logistics {
    func createTransport() -> Transport {
        return Ship()
    }
}

private struct ContentView: View {
    var body: some View {
        Button("Execute") {
            // 사용 예시
            let roadLogistics = RoadLogistics()
            let transport = roadLogistics.createTransport()
            transport.deliver() // Output: Delivering by truck!
        }
    }
}

#Preview {
    ContentView()
}
