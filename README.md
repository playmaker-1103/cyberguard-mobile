# CyberGuard Mobile

CyberGuard Mobile is a native iOS SwiftUI portfolio project that showcases a mobile cybersecurity dashboard with actionable threat monitoring and account-protection workflows.

## Features

- **Dashboard Metrics**
  - Calculated security score (0–100) based on active threat severity and incomplete protection tasks
  - Dynamic risk level indicator (Low / Moderate / High)
  - Active threat count, open account issues, and completed protection tasks
- **Threat Alerts**
  - List of mock cybersecurity alerts with severity badges
  - Severity filtering via segmented control (**All, High, Medium, Low**)
  - Search alerts by title or description
  - Tap alert to open a full **Alert Detail** screen
  - Resolve alerts with **Mark as Resolved**, removing them from active alert tracking
- **Account Protection**
  - Interactive checklist for account hardening tasks
  - Toggle completion to immediately affect dashboard security score and risk state
- **AI Security Tips**
  - Mock AI-style recommendations for practical mobile and account security improvements
- **Local Data Only**
  - No networking layer yet (intentionally scoped for portfolio clarity)

## Tech Stack

- **Language:** Swift
- **UI Framework:** SwiftUI
- **Architecture:** MVVM
- **Platform:** iOS

## Architecture (MVVM)

The app is organized into clear layers:

- **Models** (`Models/`)
  - `ThreatAlert.swift`: threat item + severity + recommended action data
  - `ProtectionTask.swift`: checklist item and completion state
  - `SecurityTip.swift`: AI recommendation card content
- **ViewModel** (`ViewModels/`)
  - `SecurityDashboardViewModel.swift`: source of truth for local state, computed metrics (score/risk/counts), and mutation actions (`toggleTask`, `resolveAlert`)
- **Views** (`Views/` + `ContentView.swift`)
  - `ContentView.swift`: root `TabView` container
  - `DashboardView.swift`: overview cards for score and metrics
  - `ThreatAlertsView.swift`: searchable/filterable alert feed
  - `AlertDetailView.swift`: detailed alert context + resolution action
  - `AccountProtectionView.swift`: interactive protection checklist
  - `AISecurityTipsView.swift`: AI tips feed
  - `SharedComponents.swift`: reusable UI card component

## Security Score Formula

Starting score: **100**

- High severity alert: **-20**
- Medium severity alert: **-10**
- Low severity alert: **-5**
- Each incomplete protection task: **-8**

Final score is clamped to **0...100**.

## How to Run

1. Open `CyberGuard.xcodeproj` in Xcode.
2. Choose an iOS Simulator device (for example, iPhone 16).
3. Run the app with **Cmd + R**.

## Portfolio CV Bullet Points

- Built a native iOS cybersecurity dashboard app with SwiftUI and a multi-tab architecture for threat monitoring, account protection, and AI security coaching.
- Implemented MVVM state management with computed risk scoring and real-time UI updates driven by alert severity and task completion.
- Delivered interactive threat workflows including severity filters, search, drill-down alert details, and in-app resolution actions.
- Designed modern, reusable SwiftUI components using SF Symbols, rounded cards, and dynamic system colors for accessibility-friendly UI.

## Future Improvements

- Persist data with SwiftData/Core Data for offline session continuity.
- Add local notifications for high-severity alerts and stale unresolved items.
- Integrate real backend threat feeds and account telemetry APIs.
- Add authentication and secure settings for personalized dashboards.
- Introduce unit/UI tests for score logic, filtering, search, and alert resolution flows.
