import SwiftUI

struct SettingsView: View {
    @AppStorage("notifications_enabled") private var notificationsEnabled = true
    @AppStorage("biometric_lock_enabled") private var biometricLockEnabled = false
    @AppStorage("security_reminders_enabled") private var securityRemindersEnabled = true

    var body: some View {
        NavigationStack {
            Form {
                Section("Security Preferences") {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
                    Toggle("Biometric Lock (Simulated)", isOn: $biometricLockEnabled)
                    Toggle("Security Reminders", isOn: $securityRemindersEnabled)
                }

                Section("About") {
                    Text("CyberGuard Mobile is a demo cybersecurity dashboard for portfolio and internship learning purposes.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Settings")
        }
    }
}
