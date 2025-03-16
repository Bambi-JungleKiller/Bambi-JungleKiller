import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @State private var selectedRole: UserRole = .emperor
    
    var body: some View {
        VStack(spacing: 20) {
            Picker("身份", selection: $selectedRole) {
                ForEach(UserRole.allCases, id: \.self) { role in
                    Text(role.rawValue.localized)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            TextField("官牒编号", text: $viewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            SecureField("密符", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button(action: viewModel.authenticate) {
                Text("验符入值")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .disabled(!viewModel.isFormValid)
        }
        .navigationTitle("大明会典登录")
    }
}

class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var loginStatus = false
    
    var isFormValid: Bool {
        !username.isEmpty && !password.isEmpty
    }
    
    func authenticate() {
        // 后续对接CoreData验证逻辑
        loginStatus = true
    }
}