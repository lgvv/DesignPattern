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

import UIKit

public class SelectQuestionGroupViewController: UIViewController {
  
  // MARK: - Outlets
  @IBOutlet internal var tableView: UITableView! {
    didSet {
      // 테이블 뷰가 갱신될 때마다 공백으로 설정됩니다. 이 트릭은 불필요한 빈 테이블 뷰 셀을 그리는 것을 방지하기 위한 것
      tableView.tableFooterView = UIView()
    }
  }
  
  // MARK: - Properties
  public let questionGroups = QuestionGroup.allGroups()
  private var selectedQuestionGroup: QuestionGroup!
}

// MARK: - UITableViewDataSource
extension SelectQuestionGroupViewController: UITableViewDataSource {
  
  public func tableView(_ tableView: UITableView,
                        numberOfRowsInSection section: Int)
  -> Int {
    return questionGroups.count // 전체 그룹이 몇개 있는지
  }
  
  public func tableView(_ tableView: UITableView,
                        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionGroupCell") as! QuestionGroupCell
    let questionGroup = questionGroups[indexPath.row]
    cell.titleLabel.text = questionGroup.title
    return cell
  }
}

extension SelectQuestionGroupViewController: UITableViewDelegate {
  
  public func tableView(_ tableView: UITableView,
                        willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    // 세그가 수행된 다음에 didSelectRowAt이 트리거(수행) 된다.
    // willSelectRowAt -> 세그(prepare) -> didSelectRowAt 순서이다.
    /* 만약 아래의 코드가 didSelectRow에 있다면
     selectedQuestionGroup = questionGroups[indexPath.row]
     viewController.questionGroup = selectedQuestionGroup가 didSelectRowAt에 있다면
     여전히 nil이기 때문이다.
     */
    selectedQuestionGroup = questionGroups[indexPath.row]
    return indexPath
  }
  
  public func tableView(_ tableView: UITableView,
                        didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true) // 테이블 뷰 셀의 회색으로 선택되어 있는데, 그것을 해제해주는 nicety한 코드!
  }
  
  public override func prepare(for segue: UIStoryboardSegue,
                               sender: Any?) {
    guard let viewController = segue.destination
            as? QuestionViewController else { return } // 만일을 대비하여 guard 문으로 설정
    viewController.questionGroup = selectedQuestionGroup
    viewController.delegate = self // delegate 패턴으로 내가 위임받아서 구현하겠다는 의미
  }
}

// MARK: - QuestionViewControllerDelegate
extension SelectQuestionGroupViewController: QuestionViewControllerDelegate {
  
  public func questionViewController(
    _ viewController: QuestionViewController,
    didCancel questionGroup: QuestionGroup,
    at questionIndex: Int) {
      
      navigationController?.popToViewController(self,
                                                animated: true)
    }
  
  public func questionViewController(
    _ viewController: QuestionViewController,
    didComplete questionGroup: QuestionGroup) {
      
      navigationController?.popToViewController(self,
                                                animated: true)
    }
}
