import Foundation

protocol RiskScoringServicing {
    func calculateScore(alerts: [ThreatAlert], tasks: [ProtectionTask]) -> Int
}

struct RiskScoringService: RiskScoringServicing {
    func calculateScore(alerts: [ThreatAlert], tasks: [ProtectionTask]) -> Int {
        let alertPenalty = alerts
            .filter { $0.status == .active }
            .reduce(0) { $0 + penalty(for: $1.severity) }
        let taskPenalty = tasks.filter { !$0.isCompleted }.count * 8
        return max(0, min(100, 100 - alertPenalty - taskPenalty))
    }

    private func penalty(for severity: ThreatSeverity) -> Int {
        switch severity {
        case .high: return 20
        case .medium: return 10
        case .low: return 5
        }
    }
}
