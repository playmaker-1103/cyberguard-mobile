import SwiftUI
import Combine

final class SecurityDashboardViewModel: ObservableObject {
    @Published var securityScore: Int = 84
    @Published var riskLevel: String = "Moderate"

    @Published var threatAlerts: [ThreatAlert] = [
        ThreatAlert(title: "Suspicious Login Attempt", detail: "New sign-in from unknown device in Austin, TX.", severity: .high, timestamp: "2h ago"),
        ThreatAlert(title: "Public Wi-Fi Exposure", detail: "Connection detected on unsecured network.", severity: .medium, timestamp: "5h ago"),
        ThreatAlert(title: "Password Reuse Warning", detail: "A saved password matches a known breach.", severity: .low, timestamp: "1d ago")
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

    var alertCount: Int { threatAlerts.count }

    var openIssueCount: Int {
        protectionTasks.filter { !$0.isCompleted }.count
    }

    var completedTaskCount: Int {
        protectionTasks.filter(\.isCompleted).count
    }

    func toggleTask(_ task: ProtectionTask) {
        guard let index = protectionTasks.firstIndex(where: { $0.id == task.id }) else {
            return
        }
        protectionTasks[index].isCompleted.toggle()
    }
}
