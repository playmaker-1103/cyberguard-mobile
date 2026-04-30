import Foundation

enum ThreatSeverity: String, CaseIterable, Identifiable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"

    var id: String { rawValue }
}

struct ThreatAlert: Identifiable {
    let id = UUID()
    let title: String
    let detail: String
    let severity: ThreatSeverity
    let timestamp: String
}
