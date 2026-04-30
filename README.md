# CyberGuard Mobile

CyberGuard Mobile is a SwiftUI iOS portfolio app that simulates a cybersecurity dashboard with alert triage, account-protection workflows, and risk scoring.

## Features

- Multi-tab app: Dashboard, Threat Alerts, Account Protection, AI Tips, Settings
- Rule-based risk score engine (0...100 clamp) driven by active alerts and incomplete tasks
- Simulated security scan (`Run Security Scan`) with async loading state and new generated alert
- Alert lifecycle support: Active vs Resolved alerts
- Search and severity filters for alerts
- Alert detail view with rule-based recommendation engine and resolve action
- AppStorage-backed settings for notifications, biometric lock simulation, and reminders
- Local mock data only (no networking)

## Tech Stack

- Swift
- SwiftUI
- XCTest
- MVVM + Services

## Architecture

- `Models/`: data contracts (`ThreatAlert`, `ProtectionTask`, `SecurityTip`)
- `ViewModels/`: UI state and actions (`SecurityDashboardViewModel`)
- `Services/`:
  - `RiskScoringService`: encapsulates risk formula rules
  - `RecommendationService`: generates category/severity-based recommendations
  - `SecurityStorageService`: placeholder persistence abstraction for future expansion
- `Views/`: screen and reusable component layer

## Risk Scoring Rules

Base score starts at **100**:
- High alert: **-20**
- Medium alert: **-10**
- Low alert: **-5**
- Each incomplete task: **-8**
- Clamp final score between **0** and **100**

## Unit Tests

Added test files for:
- Risk score calculation
- Recommendation generation
- Task toggle behavior
- Active/resolved alert lifecycle behavior

> Note: Configure/enable the `CyberGuardTests` target in Xcode if it is not already present in your local project settings.

## Run Instructions

1. Open `CyberGuard.xcodeproj` in Xcode.
2. Choose an iOS simulator (e.g., iPhone 16).
3. Press `Cmd + R` to run.
4. Press `Cmd + U` to run tests (after test target is configured).

## CV Bullet Points

- Built a SwiftUI cybersecurity dashboard app with MVVM + Services architecture and state-driven UI.
- Implemented a rule-based risk scoring engine and alert lifecycle (active/resolved) for realistic dashboard behavior.
- Developed searchable, filterable alert triage workflows with detail drill-down and rule-based recommendations.
- Added async security scan simulation and persistent user preferences with AppStorage.

## Future Roadmap

- Persist alerts/tasks with SwiftData or Core Data
- Add local notifications for high-risk events
- Integrate real backend threat intelligence APIs
- Add authentication and biometric enforcement
- Expand automated test coverage and UI tests
