import SwiftUI

struct EditReminderView: View {
    @Binding var reminder: Reminder
    @ObservedObject var viewModel: RemindersViewModel
    @Binding var isPresented: Bool
    
    var isValid: Bool {
        !reminder.title.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Reminder Details") {
                    TextField("Title", text: $reminder.title)
                    TextField("Description", text: $reminder.description, axis: .vertical)
                        .lineLimit(3...5)
                }
                
                Section("Priority & Category") {
                    Picker("Priority", selection: $reminder.priority) {
                        ForEach(Reminder.Priority.allCases, id: \.self) { priority in
                            HStack {
                                Circle()
                                    .fill(Color(priority.color))
                                    .frame(width: 8, height: 8)
                                Text(priority.rawValue)
                            }
                            .tag(priority)
                        }
                    }
                    
                    TextField("Category", text: $reminder.category)
                }
                
                Section("Due Date") {
                    Toggle("Has due date", isOn: Binding(
                        get: { reminder.dueDate != nil },
                        set: { if $0 { reminder.dueDate = Date() } else { reminder.dueDate = nil } }
                    ))
                    
                    if let date = reminder.dueDate {
                        DatePicker(
                            "Due Date",
                            selection: Binding(
                                get: { date },
                                set: { reminder.dueDate = $0 }
                            ),
                            displayedComponents: [.date, .hourAndMinute]
                        )
                    }
                }
                
                Section("Status") {
                    Toggle("Completed", isOn: $reminder.isCompleted)
                }
            }
            .navigationTitle("Edit Reminder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        viewModel.updateReminder(reminder)
                        isPresented = false
                    }
                    .disabled(!isValid)
                }
            }
        }
    }
}

#Preview {
    @State var reminder = Reminder.sampleReminders[0]
    EditReminderView(reminder: $reminder, viewModel: RemindersViewModel(), isPresented: .constant(true))
}
