import SwiftUI

fileprivate protocol Button {
    func render()
}

fileprivate protocol Checkbox {
    func toggle()
}

fileprivate class MacOSButton: Button {
    func render() {
        print("Rendering MacOS button.")
    }
}

fileprivate class MacOSCheckbox: Checkbox {
    func toggle() {
        print("Toggling MacOS checkbox.")
    }
}

fileprivate class WindowsButton: Button {
    func render() {
        print("Rendering Windows button.")
    }
}

fileprivate class WindowsCheckbox: Checkbox {
    func toggle() {
        print("Toggling Windows checkbox.")
    }
}

fileprivate protocol UIFactory {
    func createButton() -> Button
    func createCheckbox() -> Checkbox
}

fileprivate class MacOSFactory: UIFactory {
    func createButton() -> Button {
        return MacOSButton()
    }

    func createCheckbox() -> Checkbox {
        return MacOSCheckbox()
    }
}

fileprivate class WindowsFactory: UIFactory {
    func createButton() -> Button {
        return WindowsButton()
    }

    func createCheckbox() -> Checkbox {
        return WindowsCheckbox()
    }
}

private struct ContentView: View {
    var body: some View {
        SwiftUI.Button("Execute") {
            // 사용 예시
            let factory: UIFactory = MacOSFactory()
            let button = factory.createButton()
            button.render() // Output: Rendering MacOS button.
        }
    }
}

#Preview {
    ContentView()
}

