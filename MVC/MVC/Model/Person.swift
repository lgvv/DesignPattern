//
//  Person.swift
//  MVC
//
//  Created by Hamlit Jason on 2022/04/08.
//

import Foundation

public class Person {
    public var name: String = ""
    private var secret: [String] = []
    
    init(name: String, secret: [String]) {
        self.name = name
        self.secret = secret
    }
    
    public func sayHello(to: String) -> String {
        return "Hello \(to)"
    }
}
