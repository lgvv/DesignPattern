import SwiftUI

enum VehicleType {
    case car
    case bike
}

protocol Vehicle {
    func drive()
}

class Car: Vehicle {
    func drive() {
        print("Driving a car!")
    }
}

class Bike: Vehicle {
    func drive() {
        print("Riding a bike!")
    }
}

class VehicleFactory {
    static func createVehicle(type: VehicleType) -> Vehicle {
        switch type {
        case .car:
            return Car()
        case .bike:
            return Bike()
        }
    }
}

private struct ContentView: View {
    var body: some View {
        Button("Execute") {
            let car = VehicleFactory.createVehicle(type: .car)
            car.drive()

        }
    }
}

#Preview {
    ContentView()
}

