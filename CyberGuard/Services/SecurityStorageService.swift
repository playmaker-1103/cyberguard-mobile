import Foundation

protocol SecurityStorageServicing {
    func loadAlerts() -> [ThreatAlert]?
    func saveAlerts(_ alerts: [ThreatAlert])
}

struct SecurityStorageService: SecurityStorageServicing {
    private let alertsKey = "saved_alerts"

    func loadAlerts() -> [ThreatAlert]? {
        nil
    }

    func saveAlerts(_ alerts: [ThreatAlert]) {
        _ = alerts
        UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: alertsKey)
    }
}
