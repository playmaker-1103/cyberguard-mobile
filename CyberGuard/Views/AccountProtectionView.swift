import SwiftUI

struct AccountProtectionView: View {
    @ObservedObject var viewModel: SecurityDashboardViewModel

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.protectionTasks) { task in
                    Button {
                        viewModel.toggleTask(task)
                    } label: {
                        HStack(alignment: .top, spacing: 12) {
                            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                .font(.title3)
                                .foregroundStyle(task.isCompleted ? .green : .secondary)

                            VStack(alignment: .leading, spacing: 4) {
                                Text(task.title)
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                                    .strikethrough(task.isCompleted)
                                Text(task.detail)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }

                            Spacer()
                        }
                        .padding(.vertical, 4)
                    }
                    .buttonStyle(.plain)
                }
            }
            .navigationTitle("Account Protection")
        }
    }
}
