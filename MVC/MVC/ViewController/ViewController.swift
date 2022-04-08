//
//  ViewController.swift
//  MVC
//
//  Created by Hamlit Jason on 2022/04/08.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var studentLabel: UILabel!
    
    var model = Student(name: "", secret: [], major: "", studentID: "") // model
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI(with: self.model.mockStudents[self.model.mockStudentIndex])
    }
    
    @IBAction func next(_ sender: Any) {
        model.mockStudentIndex += 1
        updateUI(with: model)
    }
    
    @IBAction func previous(_ sender: Any) {
        model.mockStudentIndex -= 1
        updateUI(with: model)
    }
    
    @IBAction func sayHello(_ sender: Any) {
        let sayHello = model.sayHello(to: "\(model.mockStudents[model.mockStudentIndex].name)")
        studentLabel.text = sayHello
    }
    
    func updateUI(with student: Student) {
        let info = self.model.mockStudents[student.mockStudentIndex]
        let feeState = self.model.payTuition(fee: Int(info.studentID)!)
        studentLabel.text = """
                            이름: \(info.name)
                            전공: \(info.major)
                            학번: \(info.studentID)
                            \(feeState)
                            """
    }
}

