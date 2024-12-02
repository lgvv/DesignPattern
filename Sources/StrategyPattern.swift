import SwiftUI

protocol PaymentStrategy {
    func pay(amount: Double)
}

class CreditCardPayment: PaymentStrategy {
    func pay(amount: Double) {
        print("Paid \(amount) using Credit Card.")
    }
}

class PayPalPayment: PaymentStrategy {
    func pay(amount: Double) {
        print("Paid \(amount) using PayPal.")
    }
}

class ApplePayPayment: PaymentStrategy {
    func pay(amount: Double) {
        print("Paid \(amount) using Apple Pay.")
    }
}

class PaymentContext {
    private var strategy: PaymentStrategy

    init(strategy: PaymentStrategy) {
        self.strategy = strategy
    }

    func updateStrategy(_ strategy: PaymentStrategy) {
        self.strategy = strategy
    }

    func executePayment(amount: Double) {
        strategy.pay(amount: amount)
    }
}
private struct ContentView: View {
    var body: some View {
        Button("Execute") {
            // 초기 전략 설정
            let context = PaymentContext(strategy: CreditCardPayment())
            context.executePayment(amount: 100.0)

            // 런타임에 전략 변경
            context.updateStrategy(PayPalPayment())
            context.executePayment(amount: 200.0)

            context.updateStrategy(ApplePayPayment())
            context.executePayment(amount: 300.0)
        }
    }
}

#Preview {
    ContentView()
}
