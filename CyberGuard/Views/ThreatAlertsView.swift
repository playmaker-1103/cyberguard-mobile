import SwiftUI

struct ThreatAlertsView: View {
    enum AlertFilter: String, CaseIterable, Identifiable {
        case all = "All"
        case high = "High"
        case medium = "Medium"
        case low = "Low"

        var id: String { rawValue }

        var severity: ThreatSeverity? {
            switch self {
            case .all: return nil
            case .high: return .high
            case .medium: return .medium
            case .low: return .low
            }
        }
    }

    @ObservedObject var viewModel: SecurityDashboardViewModel
    @State private var selectedFilter: AlertFilter = .all
    @State private var searchText: String = ""

    var body: some View {
        NavigationStack {
            List(filteredAlerts) { alert in
                NavigationLink {
                    AlertDetailView(alert: alert, onResolve: {
                        viewModel.resolveAlert(alert)
                    })
                } label: {
                    AlertRowView(alert: alert)
                }
            }
            .navigationTitle("Threat Alerts")
            .searchable(text: $searchText, prompt: "Search alerts")
            .safeAreaInset(edge: .top) {
                Picker("Severity", selection: $selectedFilter) {
                    ForEach(AlertFilter.allCases) { filter in
                        Text(filter.rawValue).tag(filter)
                    }
                }
                .pickerStyle(.segmented)
                .padding([.horizontal, .top])
                .padding(.bottom, 8)
                .background(Color(.systemBackground))
            }
        }
    }

    private var filteredAlerts: [ThreatAlert] {
        viewModel.threatAlerts.filter { alert in
            let matchesSeverity = selectedFilter.severity.map { alert.severity == $0 } ?? true
            let matchesSearch = searchText.isEmpty
                || alert.title.localizedCaseInsensitiveContains(searchText)
                || alert.detail.localizedCaseInsensitiveContains(searchText)
            return matchesSeverity && matchesSearch
        }
    }
}

private struct AlertRowView: View {
    let alert: ThreatAlert

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(alert.title)
                    .font(.headline)
                Spacer()
                SeverityBadge(severity: alert.severity)
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
}

private struct SeverityBadge: View {
    let severity: ThreatSeverity

    var body: some View {
        Text(severity.rawValue)
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(color.opacity(0.16))
            .foregroundStyle(color)
            .clipShape(Capsule())
    }

    private var color: Color {
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
