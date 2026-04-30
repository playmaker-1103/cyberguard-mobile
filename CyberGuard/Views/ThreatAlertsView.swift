import SwiftUI

struct ThreatAlertsView: View {
    @ObservedObject var viewModel: SecurityDashboardViewModel

    var body: some View {
        NavigationStack {
            List(viewModel.threatAlerts) { alert in
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(alert.title)
                            .font(.headline)
                        Spacer()
                        Text(alert.severity.rawValue)
                            .font(.caption.weight(.semibold))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(severityColor(alert.severity).opacity(0.16))
                            .foregroundStyle(severityColor(alert.severity))
                            .clipShape(Capsule())
                    }

                    Text(alert.detail)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Text(alert.timestamp)
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                }
                .padding(.vertical, 6)
            }
            .navigationTitle("Threat Alerts")
        }
    }

    private func severityColor(_ severity: ThreatSeverity) -> Color {
        switch severity {
        case .low:
            return .green
        case .medium:
            return .orange
        case .high:
            return .red
        }
    }
}
