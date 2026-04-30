import XCTest
@testable import CyberGuard

final class RecommendationServiceTests: XCTestCase {
    func testSuspiciousLoginRecommendationContainsMFA() {
        let service = RecommendationService()
        let alert = ThreatAlert(title: "Suspicious Login", detail: "", severity: .high, timestamp: "", category: .suspiciousLogin)

        XCTAssertTrue(service.recommendation(for: alert).localizedCaseInsensitiveContains("MFA"))
    }
}
