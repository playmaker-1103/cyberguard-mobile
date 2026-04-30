import Foundation

enum ThreatSeverity: String, CaseIterable, Identifiable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"

    var id: String { rawValue }
}

enum AlertCategory: String, CaseIterable, Identifiable {
    case account = "Account"
    case network = "Network"
    case password = "Password"
    case phishing = "Phishing"
    case privacy = "Privacy"
    case device = "Device"
    case unknown = "General Threat"

    var id: String { rawValue }
}

enum AlertStatus: String, CaseIterable, Identifiable {
    case active = "Active"
    case resolved = "Resolved"

    var id: String { rawValue }
}

struct ThreatAlert: Identifiable {
    let id: UUID
    let title: String
    let detail: String
    let severity: ThreatSeverity
    let timestamp: String
    let category: AlertCategory
    var status: AlertStatus

    init(id: UUID = UUID(), title: String, detail: String, severity: ThreatSeverity, timestamp: String, category: AlertCategory, status: AlertStatus = .active) {
        self.id = id
        self.title = title
        self.detail = detail
        self.severity = severity
        self.timestamp = timestamp
        self.category = category
        self.status = status
    }
}

struct ScanResult {
    let finalScore: Int
    let riskLevel: String
    let issuesFound: Int
    let summary: String
    let generatedRecommendations: [String]
    let generatedAlerts: [ThreatAlert]
}
