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

                    Text("Simulated rule-based scan (demo only; not a real device security scan).")
                        .font(.footnote)
                        .foregroundStyle(.secondary)

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 14) {
                        InfoCard(title: "Security Score", value: "\(viewModel.securityScore)", iconName: "gauge.with.dots.needle.50percent", color: .blue)
                        InfoCard(title: "Risk Level", value: viewModel.riskLevel, iconName: "shield.lefthalf.filled", color: .orange)
                        InfoCard(title: "Threat Alerts", value: "\(viewModel.alertCount)", iconName: "exclamationmark.triangle.fill", color: .red)
                        InfoCard(title: "Open Issues", value: "\(viewModel.openIssueCount)", iconName: "person.crop.circle.badge.exclamationmark", color: .yellow)
                    }

                    Button { Task { await viewModel.runSecurityScan() } } label: {
                        HStack { if viewModel.isRunningScan { ProgressView().tint(.white) }; Text(viewModel.isRunningScan ? "Running Security Scan..." : "Run Security Scan").fontWeight(.semibold) }
                            .frame(maxWidth: .infinity).padding().background(Color.blue).foregroundStyle(.white).clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    }
                    .disabled(viewModel.isRunningScan)

                    if let scan = viewModel.lastScanResult {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Latest Scan Summary").font(.headline)
                            Text(scan.summary).font(.subheadline).foregroundStyle(.secondary)
                            Text("Score: \(scan.finalScore) • \(scan.riskLevel)")
                            Text("Issues Found: \(scan.issuesFound)")
                            Text("Top Recommendations").font(.subheadline).fontWeight(.semibold)
                            ForEach(scan.generatedRecommendations.prefix(3), id: \.self) { Text("• \($0)").font(.subheadline) }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 14).fill(Color(.systemBackground)))
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Dashboard")
        }
    }
}
