import SwiftUI

struct UIModel {
    let title: String?
    let viewership: Int?
}

protocol UIModelBuilder {
    func setTitle(_ title: String) -> Self
    func setViewership(_ viewership: Int) -> Self
    func build() -> UIModel
}

class ListUIModelBuilder: UIModelBuilder {
    var title: String?
    var viewership: Int?
    
    func setTitle(_ title: String) -> Self {
        self.title = title
        return self
    }
    
    func setViewership(_ viewership: Int) -> Self {
        self.viewership = viewership
        return self
    }
    
    func build() -> UIModel {
        return UIModel(title: title, viewership: viewership)
    }
}

final class UIModelDirector {
    private let builder: UIModelBuilder
    
    init(builder: UIModelBuilder) {
        self.builder = builder
    }
    
    func constructHGrid() -> UIModel {
        return builder
            .setTitle("Director - HGrid")
            .setViewership(2000)
            .build()
    }
    
    func constructVGrid() -> UIModel {
        return builder
            .setTitle("Director - VGrid")
            .setViewership(1000)
            .build()
    }
    
}

private struct ContentView: View {
    var body: some View {
        Button("Execute") {
            let builder = ListUIModelBuilder()
            
            let uiModel = builder
                .setTitle("Builder - Title")
                .setViewership(1000)
                .build()
            
            print("request: ", uiModel.title, uiModel.viewership)
            
            let director1 = UIModelDirector(builder: builder).constructHGrid()
            let director2 = UIModelDirector(builder: builder).constructVGrid()
            print("director1: ", director1.title, director1.viewership)
            print("director2: ", director2.title, director2.viewership)
        }
    }
}

#Preview {
    ContentView()
}
