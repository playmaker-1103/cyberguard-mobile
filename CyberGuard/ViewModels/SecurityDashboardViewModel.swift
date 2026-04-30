import Foundation

@MainActor
final class SecurityDashboardViewModel: ObservableObject {
    @Published var alerts: [ThreatAlert] = [
        ThreatAlert(title: "Suspicious Login Attempt", detail: "New sign-in from unknown device in Austin, TX.", severity: .high, timestamp: "2h ago", category: .account),
        ThreatAlert(title: "Public Wi-Fi Exposure", detail: "Connection detected on unsecured network.", severity: .medium, timestamp: "5h ago", category: .network),
        ThreatAlert(title: "Password Reuse Warning", detail: "A saved password matches a known breach.", severity: .low, timestamp: "1d ago", category: .password)
    ]

    @Published var protectionTasks: [ProtectionTask] = [
        ProtectionTask(title: "Enable Multi-Factor Authentication", detail: "Protect accounts with a second verification step.", isCompleted: true),
        ProtectionTask(title: "Rotate Critical Passwords", detail: "Update passwords for email and banking accounts.", isCompleted: false),
        ProtectionTask(title: "Review App Permissions", detail: "Revoke unnecessary camera and location access.", isCompleted: true),
        ProtectionTask(title: "Configure Device Auto-Lock", detail: "Set lock timeout to 30 seconds.", isCompleted: false)
    ]

    @Published var securityTips: [SecurityTip] = []
    @Published var isRunningScan = false
    @Published var lastScanResult: ScanResult?

    private let riskScoringService: RiskScoringServicing
    private let recommendationService: RecommendationServicing
    private let scanService: SecurityScanServicing

    init(riskScoringService: RiskScoringServicing = RiskScoringService(), recommendationService: RecommendationServicing = RecommendationService(), scanService: SecurityScanServicing = SecurityScanService()) {
        self.riskScoringService = riskScoringService
        self.recommendationService = recommendationService
        self.scanService = scanService
    }

    var activeAlerts: [ThreatAlert] { alerts.filter { $0.status == .active } }
    var resolvedAlerts: [ThreatAlert] { alerts.filter { $0.status == .resolved } }
    var securityScore: Int { riskScoringService.calculateScore(alerts: alerts, tasks: protectionTasks) }
    var riskLevel: String { scanService.riskLevel(for: securityScore) }
    var alertCount: Int { activeAlerts.count }
    var openIssueCount: Int { protectionTasks.filter { !$0.isCompleted }.count }
    var completedTaskCount: Int { protectionTasks.filter(\.isCompleted).count }

    func toggleTask(_ task: ProtectionTask) { guard let idx = protectionTasks.firstIndex(where: { $0.id == task.id }) else { return }; protectionTasks[idx].isCompleted.toggle() }
    func resolveAlert(_ alert: ThreatAlert) { guard let idx = alerts.firstIndex(where: { $0.id == alert.id }) else { return }; alerts[idx].status = .resolved }
    func recommendation(for alert: ThreatAlert) -> String { recommendationService.recommendation(for: alert) }

    func runSecurityScan() async {
        guard !isRunningScan else { return }
        isRunningScan = true
        try? await Task.sleep(for: .seconds(2))
        let result = scanService.performScan(alerts: alerts, tasks: protectionTasks)
        if !result.generatedAlerts.isEmpty { alerts.insert(contentsOf: result.generatedAlerts, at: 0) }
        lastScanResult = result
        isRunningScan = false
    }
}
