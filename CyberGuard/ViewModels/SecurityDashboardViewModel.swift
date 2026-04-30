import Foundation

@MainActor
final class SecurityDashboardViewModel: ObservableObject {
    @Published var alerts: [ThreatAlert] = [
        ThreatAlert(title: "Suspicious Login Attempt", detail: "New sign-in from unknown device in Austin, TX.", severity: .high, timestamp: "2h ago", category: .suspiciousLogin),
        ThreatAlert(title: "Public Wi-Fi Exposure", detail: "Connection detected on unsecured network.", severity: .medium, timestamp: "5h ago", category: .unsafeWiFi),
        ThreatAlert(title: "Password Reuse Warning", detail: "A saved password matches a known breach.", severity: .low, timestamp: "1d ago", category: .passwordReuse)
    ]

    @Published var protectionTasks: [ProtectionTask] = [
        ProtectionTask(title: "Enable Multi-Factor Authentication", detail: "Protect accounts with a second verification step.", isCompleted: true),
        ProtectionTask(title: "Rotate Critical Passwords", detail: "Update passwords for email and banking accounts.", isCompleted: false),
        ProtectionTask(title: "Review App Permissions", detail: "Revoke unnecessary camera and location access.", isCompleted: true),
        ProtectionTask(title: "Configure Device Auto-Lock", detail: "Set lock timeout to 30 seconds.", isCompleted: false)
    ]

    @Published var securityTips: [SecurityTip] = [
        SecurityTip(title: "Prioritize MFA for High-Value Accounts", detail: "Start with email, banking, and developer tools where account takeover risk is highest.", iconName: "person.badge.shield.checkmark"),
        SecurityTip(title: "Use Unique Passwords", detail: "Adopt a password manager and generate unique credentials for every service.", iconName: "key.fill"),
        SecurityTip(title: "Turn On Breach Monitoring", detail: "Track leaked credentials and rotate impacted passwords immediately.", iconName: "eye.trianglebadge.exclamationmark"),
        SecurityTip(title: "Harden Mobile Browsing", detail: "Avoid unknown links and keep iOS plus browser updates enabled.", iconName: "safari.fill")
    ]

    @Published var isRunningScan = false

    private let riskScoringService: RiskScoringServicing
    private let recommendationService: RecommendationServicing

    init(
        riskScoringService: RiskScoringServicing = RiskScoringService(),
        recommendationService: RecommendationServicing = RecommendationService()
    ) {
        self.riskScoringService = riskScoringService
        self.recommendationService = recommendationService
    }

    var activeAlerts: [ThreatAlert] { alerts.filter { $0.status == .active } }
    var resolvedAlerts: [ThreatAlert] { alerts.filter { $0.status == .resolved } }

    var securityScore: Int {
        riskScoringService.calculateScore(alerts: alerts, tasks: protectionTasks)
    }

    var riskLevel: String {
        switch securityScore {
        case 80...100: return "Low"
        case 50..<80: return "Moderate"
        default: return "High"
        }
    }

    var alertCount: Int { activeAlerts.count }
    var openIssueCount: Int { protectionTasks.filter { !$0.isCompleted }.count }
    var completedTaskCount: Int { protectionTasks.filter(\.isCompleted).count }

    func toggleTask(_ task: ProtectionTask) {
        guard let idx = protectionTasks.firstIndex(where: { $0.id == task.id }) else { return }
        protectionTasks[idx].isCompleted.toggle()
    }

    func resolveAlert(_ alert: ThreatAlert) {
        guard let idx = alerts.firstIndex(where: { $0.id == alert.id }) else { return }
        alerts[idx].status = .resolved
    }

    func recommendation(for alert: ThreatAlert) -> String {
        recommendationService.recommendation(for: alert)
    }

    func runSecurityScan() async {
        guard !isRunningScan else { return }
        isRunningScan = true
        try? await Task.sleep(for: .seconds(2))
        alerts.insert(
            ThreatAlert(
                title: "Unknown App Network Spike",
                detail: "Background traffic from an unrecognized app exceeded normal behavior.",
                severity: .medium,
                timestamp: "Just now",
                category: .malware
            ),
            at: 0
        )
        isRunningScan = false
    }
}
