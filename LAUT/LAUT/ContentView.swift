import SwiftUI

class QuizManager: ObservableObject {
    var mockQuestions = [
        Question(title: "Was ist eine ADSR Hüllkurve?", answer: "A", options: ["A","B","C","D"]),
        Question(title: "Was ist eine 2?", answer: "A", options: ["A","B","C","D"]),
        Question(title: "Was ist eine ADSR Hüllkurve test 3?", answer: "A", options: ["A","B","C","D"]),
        Question(title: "Was ist eine ?", answer: "A", options: ["A","B","C","D"])
    ]
    
    func canSubmitQuiz() -> Bool {
        return mockQuestions.filter({$0.selection == nil }).isEmpty
    }
}

struct ContentView: View {
    @State var manager =  QuizManager()

    var body: some View {
        TabView {
            ForEach(manager.mockQuestions, id: \.id) { question in
                VStack {
                    Spacer()
                    // Assuming QuestionView is implemented correctly
                    QuestionView(question: question)
                    Spacer()

                    if let lastQuestion = manager.mockQuestions.last,
                        lastQuestion.id == question.id {
                        Button {
                            // Implement logic for handling the submit action
                            print("Submit tapped")
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

