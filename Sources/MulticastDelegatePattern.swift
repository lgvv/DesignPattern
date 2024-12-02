import UIKit
import SwiftUI

/// Protocol that defines delegate behavior
protocol EventDelegate: AnyObject {
    func didReceiveEvent(_ message: String)
}

/// A class for managing multiple delegates
class MulticastDelegate<T> {
    private var delegates = NSHashTable<AnyObject>.weakObjects() // Weak references to avoid retain cycles

    /// Add a delegate
    func addDelegate(_ delegate: T) {
        delegates.add(delegate as AnyObject)
    }

    /// Remove a delegate
    func removeDelegate(_ delegate: T) {
        delegates.remove(delegate as AnyObject)
    }

    /// Notify all delegates
    func invokeDelegates(_ closure: (T) -> Void) {
        for delegate in delegates.allObjects {
            if let delegate = delegate as? T {
                closure(delegate)
            }
        }
    }
}

/// An example broadcaster that uses the multicast delegate
class EventBroadcaster {
    private let multicastDelegate = MulticastDelegate<EventDelegate>()

    func addDelegate(_ delegate: EventDelegate) {
        multicastDelegate.addDelegate(delegate)
    }

    func removeDelegate(_ delegate: EventDelegate) {
        multicastDelegate.removeDelegate(delegate)
    }

    func broadcastEvent(message: String) {
        print("Broadcasting event: \(message)")
        multicastDelegate.invokeDelegates { delegate in
            delegate.didReceiveEvent(message)
        }
    }
}

/// Example delegate classes
class FirstListener: EventDelegate {
    func didReceiveEvent(_ message: String) {
        print("FirstListener received: \(message)")
    }
}

class SecondListener: EventDelegate {
    func didReceiveEvent(_ message: String) {
        print("SecondListener received: \(message)")
    }
}

private struct ContentView: View {
    var body: some View {
        Button("Execute") {
            /// Example usage
            let broadcaster = EventBroadcaster()
            let firstListener = FirstListener()
            let secondListener = SecondListener()

            broadcaster.addDelegate(firstListener)
            broadcaster.addDelegate(secondListener)

            // Broadcast an event
            broadcaster.broadcastEvent(message: "Hello, Multicast Delegates!")

            // Remove a delegate and broadcast again
            broadcaster.removeDelegate(firstListener)
            broadcaster.broadcastEvent(message: "Only SecondListener should receive this.")
        }
    }
}

#Preview {
    ContentView()
}
