import SwiftUI

struct ReminderDetailView: View {
    @State var reminder: Reminder
    @ObservedObject var viewModel: RemindersViewModel
    @Environment(\.dismiss) var dismiss
    @State private var isEditing = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header with status
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(reminder.title)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        HStack(spacing: 12) {
                            Label(reminder.priority.rawValue, systemImage: "exclamationmark.circle.fill")
                                .font(.caption)
                                .foregroundStyle(Color(reminder.priority.color))
                            
                            Label(reminder.category, systemImage: "tag.fill")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: { viewModel.toggleCompleted(reminder) }) {
                        Image(systemName: reminder.isCompleted ? "checkmark.circle.fill" : "circle")
                            .font(.title)
                            .foregroundStyle(reminder.isCompleted ? .green : .gray)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // Description
                if !reminder.description.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Description")
                            .font(.headline)
                        
                        Text(reminder.description)
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                
                // Due Date
                if let dueDate = reminder.dueDate {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Due Date")
                            .font(.headline)
                        
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundStyle(.blue)
                            Text(dueDate.formatted(date: .complete, time: .omitted))
                                .font(.body)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    }
                }
                
                // Dates
                VStack(alignment: .leading, spacing: 8) {
                    Text("Info")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("Created")
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text(reminder.createdAt.formatted(date: .abbreviated, time: .shortened))
                                .font(.caption)
                        }
                        
                        Divider()
                        
                        HStack {
                            Text("Updated")
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text(reminder.updatedAt.formatted(date: .abbreviated, time: .shortened))
                                .font(.caption)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit") {
                    isEditing = true
                }
            }
        }
        .sheet(isPresented: $isEditing) {
            EditReminderView(reminder: $reminder, viewModel: viewModel, isPresented: $isEditing)
        }
    }
}

#Preview {
    NavigationStack {
        ReminderDetailView(reminder: Reminder.sampleReminders[0], viewModel: RemindersViewModel())
    }
}
