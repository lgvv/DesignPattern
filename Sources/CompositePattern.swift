import SwiftUI

// Component
protocol FileSystemComponent {
    func display(indent: String)
}

// Leaf
class File: FileSystemComponent {
    private var name: String

    init(name: String) {
        self.name = name
    }

    func display(indent: String) {
        print("\(indent)File: \(name)")
    }
}

// Composite
class Directory: FileSystemComponent {
    private var name: String
    private var children: [FileSystemComponent] = []

    init(name: String) {
        self.name = name
    }

    func add(component: FileSystemComponent) {
        children.append(component)
    }

    func remove(component: FileSystemComponent) {
        if let index = children.firstIndex(where: { $0 as AnyObject === component as AnyObject }) {
            children.remove(at: index)
        }
    }

    func display(indent: String) {
        print("\(indent)Directory: \(name)")
        for child in children {
            child.display(indent: indent + "  ")
        }
    }
}

private struct ContentView: View {
    var body: some View {
        Button("Execute") {
            
            // 클라이언트 코드
            let file1 = File(name: "file1.txt")
            let file2 = File(name: "file2.txt")
            let file3 = File(name: "file3.txt")

            let dir1 = Directory(name: "dir1")
            let dir2 = Directory(name: "dir2")

            // 디렉토리에 파일 추가
            dir1.add(component: file1)
            dir1.add(component: file2)

            // 다른 디렉토리에 파일 추가
            dir2.add(component: file3)

            // 루트 디렉토리 생성 및 서브 디렉토리 추가
            let root = Directory(name: "root")
            root.add(component: dir1)
            root.add(component: dir2)

            // 전체 파일 시스템 구조 출력
            root.display(indent: "")

        }
    }
}

#Preview {
    ContentView()
}
