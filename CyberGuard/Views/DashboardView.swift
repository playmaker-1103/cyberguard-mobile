import SwiftUI

struct DashboardView: View {
    @ObservedObject var viewModel: SecurityDashboardViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Cybersecurity Overview")
                        .font(.title2)
                        .fontWeight(.semibold)

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 14) {
                        InfoCard(title: "Security Score", value: "\(viewModel.securityScore)", iconName: "gauge.with.dots.needle.50percent", color: .blue)
                        InfoCard(title: "Risk Level", value: viewModel.riskLevel, iconName: "shield.lefthalf.filled", color: .orange)
                        InfoCard(title: "Threat Alerts", value: "\(viewModel.alertCount)", iconName: "exclamationmark.triangle.fill", color: .red)
                        InfoCard(title: "Open Issues", value: "\(viewModel.openIssueCount)", iconName: "person.crop.circle.badge.exclamationmark", color: .yellow)
                        InfoCard(title: "Tasks Completed", value: "\(viewModel.completedTaskCount)", iconName: "checkmark.seal.fill", color: .green)
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Dashboard")
        }
    }
}
