# CyberGuard Mobile

CyberGuard Mobile is a SwiftUI portfolio app demonstrating a **simulated rule-based cybersecurity dashboard** for internship-level mobile engineering projects.

## Features
- Dashboard with rule-based score, risk level, issue counts, and scan summary
- Threat alerts with active/resolved lifecycle, severity filters, and search
- Alert detail with category-based recommendations
- Account protection checklist that affects risk score
- AI tips and settings (AppStorage toggles)
- **Simulated Security Scan** (not a real device scan)

## MVVM + Services Architecture
- `Models/`: `ThreatAlert`, `ProtectionTask`, `SecurityTip`, `ScanResult`
- `ViewModels/`: `SecurityDashboardViewModel`
- `Services/`:
  - `RiskScoringService`
  - `RecommendationService`
  - `SecurityScanService`
  - `SecurityStorageService` (future persistence placeholder)

## Security Scan Algorithm (Simulated)
1. Analyze **active threat alerts** and **incomplete protection tasks**.
2. Score starts at **100**.
3. Subtract penalties:
   - High alert: -20
   - Medium alert: -10
   - Low alert: -5
   - Each incomplete task: -8
4. Clamp final score to **0...100**.
5. Map risk level:
   - `>= 80` => **Low Risk**
   - `>= 60 and < 80` => **Moderate Risk**
   - `< 60` => **High Risk**
6. Produce `ScanResult` with:
   - `finalScore`
   - `riskLevel`
   - `issuesFound`
   - `summary`
   - `generatedRecommendations`
   - `generatedAlerts` (if rule thresholds are met)

## Recommendation Rules
- Account risk -> enable MFA + reset password
- Network risk -> use VPN + avoid sensitive activity
- Password risk -> password manager + rotate reused passwords
- Phishing risk -> avoid unknown links + review browser protection
- Privacy risk -> review app permissions
- Device risk -> enable auto-lock + update iOS

## Unit Tests
- Risk score calculation
- Risk level mapping
- Recommendation generation
- Scan issue-count validation

## Run
1. Open `CyberGuard.xcodeproj` in Xcode.
2. Choose a simulator.
3. `Cmd + R` to run.
4. `Cmd + U` to run tests.

## CV Bullet Points
- Built a SwiftUI cybersecurity dashboard using MVVM + Services and rule-based scan logic.
- Implemented deterministic risk scoring and actionable recommendation generation.
- Designed alert lifecycle workflows and scan summaries suitable for product demos.

## Roadmap
- Persist scan history with SwiftData/Core Data
- Add UI tests and richer simulated scan heuristics
- Integrate real backend intelligence feeds
