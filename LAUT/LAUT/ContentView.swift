import SwiftUI

class QuizManager: ObservableObject {
    
    @Published var mockQuestions = [
        Question(title: "Was ist eine ADSR Hüllkurve?", answer: "A", options: ["A","B","C","D"]),
        Question(title: "Was ist eine 2?", answer: "A", options: ["A","B","C","D"]),
        Question(title: "Was ist eine ADSR Hüllkurve test 3?", answer: "A", options: ["A","B","C","D"]),
        Question(title: "Was ist eine ?", answer: "A", options: ["A","B","C","D"])
    ]
    
    func canSubmitQuiz() -> Bool {
        return mockQuestions.filter({$0.selection == nil }).isEmpty
    }
    
    func gradeQuiz() -> String {
        var correct: CGFloat = 0

        for question in mockQuestions {
            if question.answer == question.selection {
                correct += 1
            }
        }

        return "\((correct / CGFloat(mockQuestions.count)) * 100)%"
    }
    
}

struct ContentView: View {
    @StateObject var manager =  QuizManager()

    var body: some View {
        TabView {
            ForEach(manager.mockQuestions.indices, id: \.self) { index in
                VStack {
                    Spacer()
                    QuestionView(question: $manager.mockQuestions[index])
                    Spacer()

                    if let lastQuestion = manager.mockQuestions.last,
                       lastQuestion.id == manager.mockQuestions[index].id {
                        Button {
                            print(manager.gradeQuiz())
                        } label: {
                            Text("Submit")
                                .padding()
                                .foregroundColor(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .fill(Color("AppColor"))
                                        .frame(width: 340)
                                )
                        }
                        .buttonStyle(.plain)
                        .disabled(!manager.canSubmitQuiz())
                    }
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

