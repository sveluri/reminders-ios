import SwiftUI

struct AddReminderView: View {
    @ObservedObject var viewModel: RemindersViewModel
    @Binding var isPresented: Bool
    
    @State private var title = ""
    @State private var description = ""
    @State private var selectedPriority = Reminder.Priority.medium
    @State private var selectedCategory = "General"
    @State private var dueDate: Date?
    @State private var showDatePicker = false
    
    var isValid: Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Reminder Details") {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description, axis: .vertical)
                        .lineLimit(3...5)
                }
                
                Section("Priority & Category") {
                    Picker("Priority", selection: $selectedPriority) {
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
                    
                    TextField("Category", text: $selectedCategory)
                }
                
                Section("Due Date") {
                    Toggle("Add due date", isOn: Binding(
                        get: { dueDate != nil },
                        set: { if $0 { dueDate = Date() } else { dueDate = nil } }
                    ))
                    
                    if let date = dueDate {
                        DatePicker(
                            "Due Date",
                            selection: Binding(
                                get: { date },
                                set: { dueDate = $0 }
                            ),
                            displayedComponents: [.date, .hourAndMinute]
                        )
                    }
                }
            }
            .navigationTitle("New Reminder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        let reminder = Reminder(
                            title: title,
                            description: description,
                            dueDate: dueDate,
                            priority: selectedPriority,
                            category: selectedCategory
                        )
                        viewModel.addReminder(reminder)
                        isPresented = false
                    }
                    .disabled(!isValid)
                }
            }
        }
    }
}

#Preview {
    AddReminderView(viewModel: RemindersViewModel(), isPresented: .constant(true))
}
