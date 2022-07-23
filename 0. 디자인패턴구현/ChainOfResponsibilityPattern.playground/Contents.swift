 
import UIKit

// MARK: - Handler 프로토콜 정의
protocol CustomerServiceHandler: class {
    var nextHandler: CustomerServiceHandler? { get set }
    func setNext(handler: CustomerServiceHandler)
    func handle(request: String) -> String
}

extension CustomerServiceHandler {
    func setNext(handler: CustomerServiceHandler) {
        if self.nextHandler == nil {
            self.nextHandler = handler
        } else {
            self.nextHandler?.setNext(handler: handler)
        }
    }
}

// MARK: - Concrete Handler
class MainAppleServiceHandler: CustomerServiceHandler {
    var nextHandler: CustomerServiceHandler?
    
    func handle(request: String) -> String {
        if request == "Apple" {
            return "Apple 부서로 연결합니다."
        } else {
            if let response = nextHandler?.handle(request: request) {
                return response
            } else {
                return "해당 서비스는 제공되지 않습니다."
            }
        }
    }
}

class MobileServiceHandler: CustomerServiceHandler {
    var nextHandler: CustomerServiceHandler?
    
    func handle(request: String) -> String {
        if request == "Mobile" {
            return "Mobile 부서로 연결합니다."
        } else {
            if let response = nextHandler?.handle(request: request) {
                return response
            } else {
                return "해당 서비스는 제공되지 않습니다."
            }
        }
    }
}


class IPhoneServiceHandler: CustomerServiceHandler {
    var nextHandler: CustomerServiceHandler?
    
    func handle(request: String) -> String {
        if request == "iPhone" {
            return "iPhone 부서로 연결합니다."
        } else {
            if let response = nextHandler?.handle(request: request) {
                return response
            } else {
                return "해당 서비스는 제공되지 않습니다."
            }
        }
    }
}

class Client {
    private var firstHandler: CustomerServiceHandler?
    
    func request(request: String) -> String {
        return self.firstHandler?.handle(request: request) ?? "firstHandler를 설정해주세요"
    }
    
    func addHandler(handler: CustomerServiceHandler) {
        if let firstHandler = firstHandler {
            firstHandler.setNext(handler: handler)
        } else {
            self.firstHandler = handler
        }
    }
}

let client = Client()
let appleService = MainAppleServiceHandler()
let mobileService = MobileServiceHandler()
let iphoneService = IPhoneServiceHandler()

client.addHandler(handler: appleService)
client.addHandler(handler: mobileService)
client.addHandler(handler: iphoneService)

print(client.request(request: "iPhone"))
print(client.request(request: "iPad"))


