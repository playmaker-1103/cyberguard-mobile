import SwiftUI

struct ThreatAlertsView: View {
    enum AlertListMode: String, CaseIterable, Identifiable { case active = "Active", resolved = "Resolved"; var id: String { rawValue } }
    enum AlertFilter: String, CaseIterable, Identifiable {
        case all = "All", high = "High", medium = "Medium", low = "Low"
        var id: String { rawValue }
        var severity: ThreatSeverity? {
            switch self { case .all: nil; case .high: .high; case .medium: .medium; case .low: .low }
        }
    }

    @ObservedObject var viewModel: SecurityDashboardViewModel
    @State private var listMode: AlertListMode = .active
    @State private var selectedFilter: AlertFilter = .all
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            List(filteredAlerts) { alert in
                NavigationLink {
                    AlertDetailView(alert: alert, recommendation: viewModel.recommendation(for: alert), onResolve: {
                        viewModel.resolveAlert(alert)
                    })
                } label: {
                    AlertRowView(alert: alert)
                }
            }
            .navigationTitle("Threat Alerts")
            .searchable(text: $searchText, prompt: "Search alerts")
            .safeAreaInset(edge: .top) {
                VStack(spacing: 10) {
                    Picker("Alert Status", selection: $listMode) {
                        ForEach(AlertListMode.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .pickerStyle(.segmented)

                    Picker("Severity", selection: $selectedFilter) {
                        ForEach(AlertFilter.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .pickerStyle(.segmented)
                }
                .padding([.horizontal, .top])
                .padding(.bottom, 8)
                .background(Color(.systemBackground))
            }
        }
    }

    private var sourceAlerts: [ThreatAlert] {
        listMode == .active ? viewModel.activeAlerts : viewModel.resolvedAlerts
    }

    private var filteredAlerts: [ThreatAlert] {
        sourceAlerts.filter { alert in
            let matchesSeverity = selectedFilter.severity.map { alert.severity == $0 } ?? true
            let matchesSearch = searchText.isEmpty || alert.title.localizedCaseInsensitiveContains(searchText) || alert.detail.localizedCaseInsensitiveContains(searchText)
            return matchesSeverity && matchesSearch
        }
    }
}

private struct AlertRowView: View {
    let alert: ThreatAlert
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack { Text(alert.title).font(.headline); Spacer(); SeverityBadge(severity: alert.severity) }
            Text(alert.detail).font(.subheadline).foregroundStyle(.secondary)
            Text(alert.timestamp).font(.caption).foregroundStyle(.tertiary)
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
    private var color: Color { switch severity { case .low: .green; case .medium: .orange; case .high: .red } }
}
