import SwiftUI

struct AlertDetailView: View {
    let alert: ThreatAlert
    let onResolve: () -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(alert.title)
                    .font(.title2)
                    .fontWeight(.bold)

                HStack(spacing: 10) {
                    Label(alert.severity.rawValue, systemImage: "exclamationmark.shield")
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(.thinMaterial)
                        .clipShape(Capsule())

                    Text(alert.timestamp)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                detailSection(title: "Description", text: alert.detail)
                detailSection(title: "Recommended Action", text: alert.recommendedAction)

                Button {
                    onResolve()
                    dismiss()
                } label: {
                    Text("Mark as Resolved")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                }
                .padding(.top, 8)
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Alert Detail")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func detailSection(title: String, text: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            Text(text)
                .font(.body)
                .foregroundStyle(.secondary)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color(.systemBackground))
                )
        }
    }
}
