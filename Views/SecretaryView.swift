import SwiftUI

struct SecretaryView: View {
    @StateObject var vm = SecretaryViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                Section("待审核奏折") {
                    ForEach(vm.pendingReviewMemorials) { memorial in
                        MemorialRow(memorial: memorial)
                            .swipeActions(edge: .trailing) {
                                Button("转呈御览") { vm.forwardToEmperor(memorial) }
                                Button("发回重拟") { vm.returnForRevision(memorial) }
                            }
                    }
                }
                
                Section("流程监控") {
                    HStack {
                        ProcessChart(status: .draft, count: vm.processStats.draftCount)
                        ProcessChart(status: .reviewing, count: vm.processStats.reviewCount)
                        ProcessChart(status: .approved, count: vm.processStats.approvedCount)
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("司礼监文书房")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text("嘉靖(vm.currentYear)年")
                }
            }
        }
    }
}

class SecretaryViewModel: ObservableObject {
    @Published var pendingReviewMemorials: [Memorial] = []
    @Published var processStats = ProcessStats()
    var currentYear: Int { Calendar.current.component(.year, from: Date()) }
    
    func forwardToEmperor(_ memorial: Memorial) {
        // 转呈逻辑
    }
    
    func returnForRevision(_ memorial: Memorial) {
        // 退回逻辑
    }
}

struct ProcessChart: View {
    let status: MemorialStatus
    let count: Int
    
    var body: some View {
        VStack {
            Text(status.rawValue)
                .font(.caption)
            Text("\(count)")
                .font(.title2)
        }
        .frame(maxWidth: .infinity)
    }
}

struct ProcessStats {
    var draftCount = 12
    var reviewCount = 5
    var approvedCount = 32
}

enum MemorialStatus: String {
    case draft = "草拟"
    case reviewing = "审核"
    case approved = "已批红"
}