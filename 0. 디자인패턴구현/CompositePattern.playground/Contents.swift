import UIKit

protocol FileComponent {
    var size: Int { get set }
    var name: String { get set }
    func open()
    func getSize() -> Int
}

final class Directory: FileComponent {
    var size: Int
    var name: String
    var files: [FileComponent] = []
    func open() {
        print("\(self.name) Directory의 모든 File Open")
        for file in files {
            file.open()
        }
        print("\(self.name) Directory의 모든 File Open 완료\n")
    }
    
    func getSize() -> Int {
        var sum: Int = 0
        for file in files {
            sum += file.getSize()
        }
        return sum
    }
    
    func addFile(file: FileComponent) {
        self.files.append(file)
        self.size += file.size
    }
    
    init(size: Int, name: String) {
        self.size = size
        self.name = name
    }
}

final class MusicFile: FileComponent {
    var size: Int
    var name: String
    var artist: String
    
    func open() {
        print("\(self.name) Music Artist  : \(self.artist)")
    }
    
    func getSize() -> Int {
        return self.size
    }
    
    init(size: Int, name: String, artist: String) {
        self.size = size
        self.name = name
        self.artist = artist
    }
}

final class CodeFile: FileComponent {
    var size: Int
    var name: String
    var language: String
    
    func open() {
        print("\(self.name) Code Language : \(self.language)")
    }
    
    func getSize() -> Int {
        return self.size
    }
    
    init(size: Int, name: String, language: String) {
        self.size = size
        self.name = name
        self.language = language
    }
}

let rootDirectory = Directory(size: 0, name: "root")
let musicDirectory = Directory(size: 0, name: "music")
let codeDirectory = Directory(size: 0, name: "code")

let iuMusic = MusicFile(size: 10, name: "lilac", artist: "IU")
let lgvvMusic = MusicFile(size: 12, name: "lgvvPop", artist: "lgvv")

let keleubFile = CodeFile(size: 3, name: "Kaleun", language: "Swift")
let coreMLFile = CodeFile(size: 5, name: "CoreML", language: "Swift")
let flutterFile = CodeFile(size: 7, name: "Flutter", language: "Dart")

musicDirectory.addFile(file: iuMusic)
musicDirectory.addFile(file: lgvvMusic)

codeDirectory.addFile(file: keleubFile)
codeDirectory.addFile(file: coreMLFile)
codeDirectory.addFile(file: flutterFile)

rootDirectory.addFile(file: musicDirectory)
rootDirectory.addFile(file: codeDirectory)

print("rootDirectory size: \(rootDirectory.getSize())")
print("musicDirectory size: \(musicDirectory.getSize())")
print("codeDirectory size: \(codeDirectory.getSize())")

