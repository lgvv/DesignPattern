import SwiftUI

// 핸들러 프로토콜
protocol Handler {
    var successor: Handler? { get set }
    func handle(level: Level, message: String)
}

enum Level {
    case info
    case error
    case warning
    case debug
    
    var stringValue: String {
        switch self {
        case .info: return "INFO"
        case .error: return "ERROR"
        case .warning: return "WARNING"
        case .debug: return "DEBUG"
        }
    }
}

// 정보 로그 핸들러
class InfoHandler: Handler {
    var successor: Handler?

    func handle(level: Level, message: String) {
        if level == .info {
            print("INFO: \(message)")
        } else {
            successor?.handle(level: level, message: message)
        }
    }
}

// 경고 로그 핸들러
class WarningHandler: Handler {
    var successor: Handler?

    func handle(level: Level, message: String) {
        if level == .warning {
            print("WARNING: \(message)")
        } else {
            successor?.handle(level: level, message: message)
        }
    }
}

// 오류 로그 핸들러
class ErrorHandler: Handler {
    var successor: Handler?

    func handle(level: Level, message: String) {
        if level == .warning {
            print("ERROR: \(message)")
        } else {
            successor?.handle(level: level, message: message)
        }
    }
}

private struct ContentView: View {
    var body: some View {
        Button("Execute") {
            // 핸들러 체인 구성
            let errorHandler = ErrorHandler()
            let warningHandler = WarningHandler()
            warningHandler.successor = errorHandler
            let infoHandler = InfoHandler()
            infoHandler.successor = warningHandler

            // 로그 메시지 처리
            infoHandler.handle(level: .info, message: "This is an info message.")
            infoHandler.handle(level: .warning, message: "This is a warning message.")
            infoHandler.handle(level: .error, message: "This is an error message.")
            infoHandler.handle(level: .debug, message: "This is a debug message.")  // 처리되지 않음
        }
    }
}

#Preview {
    ContentView()
}
