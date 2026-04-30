import XCTest
@testable import CyberGuard

final class RecommendationServiceTests: XCTestCase {
    func testRecommendationsIncludeVPNForNetwork() {
        let service = RecommendationService()
        let recs = service.recommendations(for: [.network])
        XCTAssertTrue(recs.joined().localizedCaseInsensitiveContains("VPN"))
    }
}
