import SwiftUI

struct Applicant {
    var name: String
    var email: String
    var phase: Phase
    
    enum Phase {
        case applied          // 지원 완료
        case assignment       // 사전과제
        case interview        // 인터뷰
        case accepted         // 합격
        case rejected         // 탈락
    }
}

struct Email {
    var subject: String
    var message: String
}

struct EmailFacotry {
    
    func create(applicant: Applicant) -> Email {
        switch applicant.phase {
        case .applied:
            return .init(subject: "서류 제출 완료", message: "제출 완료 되었습니다")
        case .assignment:
            return .init(subject: "사전과제 안내", message: "사전과제 해주세요")
        case .interview:
            return .init(subject: "면접 안내", message: "화상면접 들어와주세요")
        case .accepted:
            return .init(subject: "합격 안내", message: "최종합격 했어요")
        case .rejected:
            return .init(subject: "불합격 안내", message: "다음기회에 다시 지원해주세요")
        }
    }
}

private struct ContentView: View {
    var body: some View {
        Button("Execute") {
            let facotry = EmailFacotry()
            var applicant = Applicant(
                name: "name",
                email: "email@example.com",
                phase: .applied
            )
            print(facotry.create(applicant: applicant))
            applicant.phase = .assignment
            print(facotry.create(applicant: applicant))
            applicant.phase = .interview
            print(facotry.create(applicant: applicant))
            applicant.phase = .accepted
            print(facotry.create(applicant: applicant))
            applicant.phase = .rejected
            print(facotry.create(applicant: applicant))
        }
    }
}

#Preview {
    ContentView()
}

