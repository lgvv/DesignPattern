import SwiftUI

// 서브시스템: 상품 검색
class ProductCatalog {
    func searchProduct(name: String) -> String {
        return "상품 '\(name)'을(를) 찾았습니다."
    }
}

// 서브시스템: 장바구니 관리
class ShoppingCart {
    private var items: [String] = []
    
    func addItem(item: String) {
        items.append(item)
        print("장바구니에 '\(item)'을(를) 추가했습니다.")
    }
    
    func viewCart() -> [String] {
        return items
    }
}

// 서브시스템: 결제 처리
class PaymentProcessor {
    func processPayment(amount: Double) {
        print("결제 처리 중: \(amount) 원이 청구되었습니다.")
    }
}

// Facade 클래스
class ShoppingFacade {
    private let productCatalog: ProductCatalog
    private let shoppingCart: ShoppingCart
    private let paymentProcessor: PaymentProcessor
    
    init() {
        self.productCatalog = ProductCatalog()
        self.shoppingCart = ShoppingCart()
        self.paymentProcessor = PaymentProcessor()
    }
    
    func purchaseProduct(name: String, price: Double) {
        let productInfo = productCatalog.searchProduct(name: name)
        print(productInfo)
        
        shoppingCart.addItem(item: name)
        
        let totalAmount = price
        paymentProcessor.processPayment(amount: totalAmount)
        
        print("구매가 완료되었습니다.")
    }
}

private struct ContentView: View {
    var body: some View {
        Button("Execute") {
            // 사용 예
            let shoppingFacade = ShoppingFacade()
            shoppingFacade.purchaseProduct(name: "아이폰 14", price: 1000000)

        }
    }
}

#Preview {
    ContentView()
}
