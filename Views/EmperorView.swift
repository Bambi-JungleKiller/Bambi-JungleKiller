import SwiftUI

struct EmperorView: View {
    @StateObject var vm = EmperorViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                Section("待批红奏折") {
                    ForEach(vm.pendingMemorials) { memorial in
                        MemorialRow(memorial: memorial)
                            .swipeActions(edge: .trailing) {
                                Button("批红") { vm.approve(memorial) }
                                Button("驳回") { vm.reject(memorial) }
                            }
                    }
                }
                
                Section("紧急政务") {
                    Chart(vm.affairsData) { item in
                        BarMark(x: .value("类型", item.category), y: .value("数量", item.count))
                    }
                    .frame(height: 200)
                }
            }
            .navigationTitle("乾清宫政务系统")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text(formatDate(Date()))
                }
            }
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "嘉靖yyyy年MM月dd日"
        return formatter.string(from: date)
    }
}

class EmperorViewModel: ObservableObject {
    @Published var pendingMemorials: [Memorial] = []
    @Published var affairsData: [AffairsData] = []
    
    func approve(_ memorial: Memorial) {
        // 批红逻辑
    }
    
    func reject(_ memorial: Memorial) {
        // 驳回逻辑
    }
}

struct Memorial: Identifiable {
    let id = UUID()
    let title: String
    let content: String
    let submitter: String
    let date: Date
}

struct AffairsData: Identifiable {
    let id = UUID()
    let category: String
    let count: Int
}

struct MemorialRow: View {
    let memorial: Memorial
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(memorial.title)
                .font(.headline)
            Text(memorial.content.prefix(20) + "...")
                .font(.subheadline)
                .foregroundColor(.secondary)
            HStack {
                Text(memorial.submitter)
                Spacer()
                Text(memorial.date, style: .date)
            }
        }
    }
}