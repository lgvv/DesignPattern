import SwiftUI

// Receiver
class TextEditor {
    private var text: String = ""
    
    func write(_ text: String) {
        self.text += text
        print("Current text: \(self.text)")
    }
    
    func cut() {
        text = ""
        print("Text cut.")
    }
    
    func copy() -> String {
        return text
    }
    
    func paste(_ text: String) {
        self.text += text
        print("Text pasted: \(text)")
    }
}

protocol Command {
    func execute()
}

class CutCommand: Command {
    private let editor: TextEditor
    
    init(editor: TextEditor) {
        self.editor = editor
    }
    
    func execute() {
        editor.cut()
    }
}

class CopyCommand: Command {
    private let editor: TextEditor
    private var copiedText: String = ""
    
    init(editor: TextEditor) {
        self.editor = editor
    }
    
    func execute() {
        copiedText = editor.copy()
        print("Copied text: \(copiedText)")
    }
    
    func getCopiedText() -> String {
        return copiedText
    }
}

class PasteCommand: Command {
    private let editor: TextEditor
    private let text: String
    
    init(editor: TextEditor, text: String) {
        self.editor = editor
        self.text = text
    }
    
    func execute() {
        editor.paste(text)
    }
}

// Invoker
class CommandInvoker {
    private var commands: [Command] = []
    
    func addCommand(_ command: Command) {
        commands.append(command)
    }
    
    func executeCommands() {
        for command in commands {
            command.execute()
        }
        commands.removeAll()
    }
}

private struct ContentView: View {
    var body: some View {
        Button("Execute") {
            let editor = TextEditor()
            let invoker = CommandInvoker()

            // 문자 작성
            editor.write("Hello, ")
            editor.write("World!")

            // 잘라내기
            let cutCommand = CutCommand(editor: editor)
            invoker.addCommand(cutCommand)

            // 복사하기
            let copyCommand = CopyCommand(editor: editor)
            invoker.addCommand(copyCommand)

            // 복사하기 커맨드 실행
            copyCommand.execute()

            // 붙여넣기
            let copiedText = copyCommand.getCopiedText()
            let pasteCommand = PasteCommand(editor: editor, text: copiedText)
            invoker.addCommand(pasteCommand)

            // 커맨드 실행
            invoker.executeCommands()
        }
    }
}

#Preview {
    ContentView()
}
