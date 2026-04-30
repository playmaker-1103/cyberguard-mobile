import Foundation

protocol RecommendationServicing {
    func recommendation(for alert: ThreatAlert) -> String
}

struct RecommendationService: RecommendationServicing {
    func recommendation(for alert: ThreatAlert) -> String {
        switch (alert.category, alert.severity) {
        case (.suspiciousLogin, .high), (.suspiciousLogin, .medium):
            return "Enable MFA, reset your password immediately, and review recent account sessions."
        case (.unsafeWiFi, _):
            return "Disconnect from unsafe Wi-Fi and use a trusted VPN before signing into sensitive accounts."
        case (.passwordReuse, _):
            return "Use a password manager to create unique passwords and rotate reused credentials now."
        case (.malware, .high):
            return "Isolate the device, run a trusted malware scan, and remove untrusted apps."
        default:
            return "Review recent activity, update device software, and apply account hardening best practices."
        }
    }
}
