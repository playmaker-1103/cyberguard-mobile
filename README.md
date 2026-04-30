# CyberGuard Mobile

CyberGuard Mobile is a native iOS SwiftUI portfolio project that presents a mobile cybersecurity dashboard experience. It is designed to showcase product thinking, clean UI implementation, and foundational mobile architecture for a Software Engineering Intern – Mobile role.

## Features

- **Dashboard** with key security metrics:
  - Security score
  - Risk level
  - Threat alert count
  - Open account issue count
  - Completed protection task count
- **Threat Alerts** tab with mock alerts and severity badges (Low, Medium, High)
- **Account Protection** checklist with interactive task completion toggles
- **AI Security Tips** tab with mock AI-style recommendations for safer account and device behavior
- Local mock data only (no networking)

## Tech Stack

- **Language:** Swift
- **UI Framework:** SwiftUI
- **Pattern:** MVVM (lightweight, portfolio-friendly)
- **Platform:** iOS

## Architecture

The project uses a simple MVVM structure:

- `Models/`
  - `ThreatAlert.swift`
  - `ProtectionTask.swift`
  - `SecurityTip.swift`
- `ViewModels/`
  - `SecurityDashboardViewModel.swift`
- `Views/`
  - `DashboardView.swift`
  - `ThreatAlertsView.swift`
  - `AccountProtectionView.swift`
  - `AISecurityTipsView.swift`
  - `SharedComponents.swift`

`ContentView.swift` hosts the root `TabView` and wires shared state from the view model into each screen.

## How to Run

1. Open `CyberGuard.xcodeproj` in Xcode.
2. Select an iOS Simulator (for example, iPhone 16).
3. Build and run with **Cmd + R**.

## CV Bullet Points

- Built a native iOS cybersecurity dashboard app using Swift and SwiftUI with a multi-tab user experience.
- Implemented a lightweight MVVM architecture to separate models, UI state, and views for maintainability.
- Designed modern SwiftUI card-based interfaces with SF Symbols, dynamic system colors, and rounded visual components.
- Delivered interactive security workflows, including threat severity visualization and account-protection task tracking.
