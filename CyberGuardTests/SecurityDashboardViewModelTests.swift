import XCTest
@testable import CyberGuard

@MainActor
final class SecurityDashboardViewModelTests: XCTestCase {
    func testToggleTaskUpdatesCompletion() {
        let vm = SecurityDashboardViewModel()
        let task = vm.protectionTasks[1]
        let initial = task.isCompleted

        vm.toggleTask(task)

        XCTAssertNotEqual(vm.protectionTasks[1].isCompleted, initial)
    }

    func testResolveAlertMovesToResolvedBucket() {
        let vm = SecurityDashboardViewModel()
        let alert = vm.activeAlerts[0]

        vm.resolveAlert(alert)

        XCTAssertEqual(vm.activeAlerts.contains(where: { $0.id == alert.id }), false)
        XCTAssertEqual(vm.resolvedAlerts.contains(where: { $0.id == alert.id }), true)
    }
}
