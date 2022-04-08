//
//  Student.swift
//  MVC
//
//  Created by Hamlit Jason on 2022/04/08.
//

import Foundation

class Student: Person {
    public var major: String
    public var studentID: String
    
    init(name: String, secret: [String], major: String, studentID: String) {
        self.major = major
        self.studentID = studentID
        super.init(name: name, secret: secret)
    }
    
    private var index = 0
    public var mockStudentIndex: Int {
        get { return index }
        set {
            if newValue > 3 {
                index = 3
            } else if newValue < 0 {
                index = 0
            } else {
                index = newValue
            }
        }
    }
    
    lazy var mockStudents: [Student] = [
        Student(name: "기린", secret: [], major: "iOS", studentID: "1"),
        Student(name: "호랑이", secret: ["종이"], major: "JS", studentID: "2"),
        Student(name: "나비", secret: [], major: "Python", studentID: "3"),
        Student(name: "판다", secret: [], major: "Android", studentID: "4")
    ]
}

extension Student {
    public func payTuition(fee: Int) -> String {
        if fee * 178 > 463 {
            return "등록금을 납부하셨습니다."
        } else {
            return "등록금을 납부하지 않았습니다."
        }
    }
    
}
