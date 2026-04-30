import Foundation

protocol RecommendationServicing {
    func recommendation(for alert: ThreatAlert) -> String
    func recommendations(for categories: [AlertCategory]) -> [String]
}

struct RecommendationService: RecommendationServicing {
    func recommendation(for alert: ThreatAlert) -> String {
        recommendations(for: [alert.category]).first ?? defaultRecommendation
    }

    func recommendations(for categories: [AlertCategory]) -> [String] {
        let set = Set(categories)
        var output: [String] = []

        if set.contains(.account) {
            output.append("Enable MFA and reset passwords for account-related risks.")
        }
        if set.contains(.network) {
            output.append("Use a trusted VPN and avoid sensitive activity on unsafe Wi-Fi.")
        }
        if set.contains(.password) {
            output.append("Use a password manager and rotate reused passwords immediately.")
        }
        if set.contains(.phishing) {
            output.append("Avoid unknown links and review browser phishing protection settings.")
        }
        if set.contains(.privacy) {
            output.append("Review app permissions and revoke unnecessary access to sensitive data.")
        }
        if set.contains(.device) {
            output.append("Enable auto-lock and keep iOS updated to the latest security patch level.")
        }

        return output.isEmpty ? [defaultRecommendation] : output
    }

    private var defaultRecommendation: String {
        "Review recent activity, update software, and follow account hardening best practices."
    }
}
