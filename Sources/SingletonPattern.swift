import SwiftUI

final actor Database {
    static var shared: Database = {
        return .init()
    }()
    
    private var instance: [String: String] = [:]
    
    private init() {}
    
    func write() {}
    
    func read() { }
}
