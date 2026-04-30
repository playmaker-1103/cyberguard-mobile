import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = SecurityDashboardViewModel()

    var body: some View {
        TabView {
            DashboardView(viewModel: viewModel)
                .tabItem {
                    Label("Dashboard", systemImage: "square.grid.2x2.fill")
                }

            ThreatAlertsView(viewModel: viewModel)
                .tabItem {
                    Label("Threat Alerts", systemImage: "exclamationmark.triangle.fill")
                }

            AccountProtectionView(viewModel: viewModel)
                .tabItem {
                    Label("Protection", systemImage: "checklist")
                }

            AISecurityTipsView(viewModel: viewModel)
                .tabItem {
                    Label("AI Tips", systemImage: "lightbulb.max.fill")
                }
        }
        .tint(.blue)
    }
}

#Preview {
    ContentView()
}
