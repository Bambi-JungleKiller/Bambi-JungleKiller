import SwiftUI

struct MinisterView: View {
    @StateObject var vm = MinisterViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                Section("拟票新奏折") {
                    TextField("题本", text: $vm.newMemorialTitle)
                    TextEditor(text: $vm.newMemorialContent)
                        .frame(height: 200)
                    Button("呈递司礼监") {
                        vm.submitMemorial()
                    }
                }
                
                Section("已呈奏折") {
                    ForEach(vm.submittedMemorials) { memorial in
                        MemorialRow(memorial: memorial)
                    }
                }
            }
            .navigationTitle("内阁票拟系统")
        }
    }
}

class MinisterViewModel: ObservableObject {
    @Published var newMemorialTitle = ""
    @Published var newMemorialContent = ""
    @Published var submittedMemorials: [Memorial] = []
    
    func submitMemorial() {
        let newMemorial = Memorial(
            title: newMemorialTitle,
            content: newMemorialContent,
            submitter: "臣工姓名",
            date: Date(),
            status: .draft
        )
        submittedMemorials.append(newMemorial)
        newMemorialTitle = ""
        newMemorialContent = ""
    }
}