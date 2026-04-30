import XCTest
@testable import CyberGuard

final class RiskScoringServiceTests: XCTestCase {
    func testScoreCalculationWithMixedAlertsAndTasks() {
        let service = RiskScoringService()
        let alerts = [
            ThreatAlert(title: "A", detail: "", severity: .high, timestamp: "", category: .unknown),
            ThreatAlert(title: "B", detail: "", severity: .medium, timestamp: "", category: .unknown),
            ThreatAlert(title: "C", detail: "", severity: .low, timestamp: "", category: .unknown)
        ]
        let tasks = [
            ProtectionTask(title: "1", detail: "", isCompleted: false),
            ProtectionTask(title: "2", detail: "", isCompleted: false)
        ]

        XCTAssertEqual(service.calculateScore(alerts: alerts, tasks: tasks), 49)
    }
}
