import Foundation

protocol SecurityScanServicing {
    func performScan(alerts: [ThreatAlert], tasks: [ProtectionTask]) -> ScanResult
    func riskLevel(for score: Int) -> String
}

struct SecurityScanService: SecurityScanServicing {
    private let scoringService: RiskScoringServicing
    private let recommendationService: RecommendationServicing

    init(scoringService: RiskScoringServicing = RiskScoringService(), recommendationService: RecommendationServicing = RecommendationService()) {
        self.scoringService = scoringService
        self.recommendationService = recommendationService
    }

    func performScan(alerts: [ThreatAlert], tasks: [ProtectionTask]) -> ScanResult {
        let activeAlerts = alerts.filter { $0.status == .active }
        let score = scoringService.calculateScore(alerts: alerts, tasks: tasks)
        let level = riskLevel(for: score)
        let incompleteCount = tasks.filter { !$0.isCompleted }.count
        let categories = activeAlerts.map(\.category)
        let recs = recommendationService.recommendations(for: categories)

        let generatedAlerts: [ThreatAlert] = incompleteCount >= 3 ? [
            ThreatAlert(title: "Device Hardening Gap", detail: "Multiple unresolved protection tasks indicate elevated device risk.", severity: .medium, timestamp: "Just now", category: .device)
        ] : []

        let issuesFound = activeAlerts.count + incompleteCount
        let summary = "Simulated rule-based scan complete. \(issuesFound) issues found across alerts and account protection tasks."

        return ScanResult(
            finalScore: score,
            riskLevel: level,
            issuesFound: issuesFound,
            summary: summary,
            generatedRecommendations: recs,
            generatedAlerts: generatedAlerts
        )
    }

    func riskLevel(for score: Int) -> String {
        if score >= 80 { return "Low Risk" }
        if score >= 60 { return "Moderate Risk" }
        return "High Risk"
    }
}
