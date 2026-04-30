import XCTest
@testable import CyberGuard

final class SecurityScanServiceTests: XCTestCase {
    func testRiskLevelMapping() {
        let service = SecurityScanService()
        XCTAssertEqual(service.riskLevel(for: 85), "Low Risk")
        XCTAssertEqual(service.riskLevel(for: 65), "Moderate Risk")
        XCTAssertEqual(service.riskLevel(for: 20), "High Risk")
    }

    func testScanResultIssueCount() {
        let service = SecurityScanService()
        let alerts = [
            ThreatAlert(title: "A", detail: "", severity: .high, timestamp: "", category: .account),
            ThreatAlert(title: "B", detail: "", severity: .low, timestamp: "", category: .privacy, status: .resolved)
        ]
        let tasks = [ProtectionTask(title: "1", detail: "", isCompleted: false)]
        let result = service.performScan(alerts: alerts, tasks: tasks)
        XCTAssertEqual(result.issuesFound, 2)
    }
}
