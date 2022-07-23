/// Copyright (c) 2019 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Combine // 컴바인 프레임워크를 추가합니다.
import Foundation

public class QuestionGroup: Codable {
  
  public class Score: Codable {
    // didSet을 이용하여 변화가 일어나면 updateRunningPercentage호출
    public var correctCount: Int = 0 {
      didSet { updateRunningPercentage() }
    }
    public var incorrectCount: Int = 0 {
      didSet { updateRunningPercentage() }
    }
    @Published public var runningPercentage: Double = 0 // 백분률을 처리하기 위한 프로퍼티를 선언합니다. -> 컴파일 error 발생(원인: 컴파일러가 인코딩 혹은 디코딩 하는 방법을 모르기 때문)
    
    public init() { }
        
    // 컴파일 에러 해결하는 부분
    // 1. enum으로 CodingKey를 상속받아 선언, 컴파일러가 runningPercentage에서 인코더와 디코더 메소드를 자동으로 생성하는걸 무시한다.
    private enum CodingKeys: String, CodingKey {
      case correctCount
      case incorrectCount
    }

    // 2. Score가 디코딩 된 경우 실제 runningPercentage를 설정해야 한다. 이렇게 하려면 init을 통해 커스텀 이니셜라이져를 만들고, 프로퍼티를 세팅한 후 업데이트하는 메소드를 호출합니다.
    public required init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      self.correctCount = try container.decode(Int.self, forKey: .correctCount)
      self.incorrectCount = try container.decode(Int.self, forKey: .incorrectCount)
      updateRunningPercentage()
    }

    // 3. 러닝 퍼센티지을 설정한다.
    private func updateRunningPercentage() {
      let totalCount = correctCount + incorrectCount
      guard totalCount > 0 else {
        runningPercentage = 0
        return
      }
      runningPercentage = Double(correctCount) / Double(totalCount)
    }
    
    // runningPercentage에 대한 subscribers를 만들기 전에 약간의 변화가 필요한데, 닫는 중괄호 앞에 Score 메소드를 추가합니다.
    // 이 메소드는 점수를 재설정하는 경우, QuestionGroup을 다시 시작할 때 마다 사용합니다.
    public func reset() {
      correctCount = 0
      incorrectCount = 0
    }
  }
  
  public let questions: [Question]
  public private(set) var score: Score // 외부 클래스가 score직접 설정하는 것을 방지. 이렇게 하면 runningPercentage의 subscriber가 실수로 지워지는 일을 예방한다.
  public let title: String
    
  public init(questions: [Question],
              score: Score = Score(),
              title: String) {
    self.questions = questions
    self.score = score
    self.title = title
  }
}
