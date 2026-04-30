import SwiftUI

struct AISecurityTipsView: View {
    @ObservedObject var viewModel: SecurityDashboardViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 14) {
                    ForEach(viewModel.securityTips) { tip in
                        HStack(alignment: .top, spacing: 12) {
                            Image(systemName: tip.iconName)
                                .font(.title3)
                                .foregroundStyle(.blue)
                                .frame(width: 34)

                            VStack(alignment: .leading, spacing: 4) {
                                Text(tip.title)
                                    .font(.headline)
                                Text(tip.detail)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }

                            Spacer()
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(Color(.systemBackground))
                                .shadow(color: .black.opacity(0.05), radius: 8, y: 4)
                        )
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("AI Security Tips")
        }
    }
}
