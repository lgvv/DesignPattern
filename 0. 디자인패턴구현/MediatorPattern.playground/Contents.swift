 
import UIKit

// Mediator
protocol Mediator {
    func notify(sender: Colleague, event: EventType)
}

enum EventType {
    case checkBoxSelect
    case checkBoxUnselect
}

// Base Colleague
class Colleague {
    var mediator: Mediator?
    
    func setMediator(mediator: Mediator) {
        self.mediator = mediator
    }
}

// Collegue
class CheckBox: Colleague {
    var isSelect: Bool = false {
        didSet {
            if isSelect {
                print("CheckBox 선택")
            } else {
                print("CheckBox 선택 해제")
            }
        }
    }
    
    func checkBoxClick() {
        self.isSelect = !self.isSelect
        if self.isSelect {
            self.mediator?.notify(sender: self, event: .checkBoxSelect)
        } else {
            self.mediator?.notify(sender: self, event: .checkBoxUnselect)
        }
    }
}

// Collegue
class TextField: Colleague {
    var isHidden: Bool = true {
        didSet {
            if isHidden {
                print("TextField 비활성화")
            } else {
                print("TextField 활성화")
            }
        }
    }
}

// Concrete Mediator
class ProfileUI: Mediator {
    var checkBox: CheckBox
    var textField: TextField
    
    init(checkBox: CheckBox, textField: TextField) {
        self.checkBox = checkBox
        self.textField = textField
        
        self.checkBox.setMediator(mediator: self)
        self.textField.setMediator(mediator: self)
    }
    
    func notify(sender: Colleague, event: EventType) {
        switch event {
        case .checkBoxSelect:
            self.textField.isHidden = false
        case .checkBoxUnselect:
            self.textField.isHidden = true
        }
    }
}

let checkBox = CheckBox()
let textField = TextField()
let profileUI = ProfileUI(checkBox: checkBox, textField: textField)

profileUI.checkBox.checkBoxClick()
profileUI.checkBox.checkBoxClick()

