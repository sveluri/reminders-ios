import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RemindersViewModel()
    @State private var showingAddReminder = false
    
    var body: some View {
        NavigationStack {
            VStack {
                // Search and filter bar
                SearchBar(text: $viewModel.searchText)
                    .padding()
                
                // Filter chips
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(Reminder.Priority.allCases, id: \.self) { priority in
                            FilterChip(
                                title: priority.rawValue,
                                isSelected: viewModel.selectedPriority == priority,
                                action: {
                                    viewModel.selectedPriority = viewModel.selectedPriority == priority ? nil : priority
                                }
                            )
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Reminders list
                if viewModel.filteredReminders.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 48))
                            .foregroundStyle(.green)
                        Text("No Reminders")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text("You're all caught up!")
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxHeight: .infinity)
                    .padding()
                } else {
                    List {
                        ForEach(viewModel.filteredReminders) { reminder in
                            NavigationLink(destination: ReminderDetailView(reminder: reminder, viewModel: viewModel)) {
                                ReminderRowView(reminder: reminder, viewModel: viewModel)
                            }
                        }
                        .onDelete { indices in
                            indices.forEach { index in
                                viewModel.deleteReminder(viewModel.filteredReminders[$0])
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Reminders")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { showingAddReminder = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    HStack(spacing: 4) {
                        Image(systemName: "checkmark.circle")
                            .font(.caption)
                        Text("\(viewModel.pendingRemindersCount)")
                            .font(.caption)
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.secondary)
                }
            }
            .sheet(isPresented: $showingAddReminder) {
                AddReminderView(viewModel: viewModel, isPresented: $showingAddReminder)
            }
        }
    }
}

struct ReminderRowView: View {
    let reminder: Reminder
    @ObservedObject var viewModel: RemindersViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            Button(action: { viewModel.toggleCompleted(reminder) }) {
                Image(systemName: reminder.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(reminder.isCompleted ? .green : .gray)
                    .font(.title2)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(reminder.title)
                    .font(.body)
                    .fontWeight(.semibold)
                    .strikethrough(reminder.isCompleted)
                    .foregroundStyle(reminder.isCompleted ? .gray : .primary)
                
                if !reminder.description.isEmpty {
                    Text(reminder.description)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
                
                HStack(spacing: 8) {
                    Label(reminder.category, systemImage: "tag.fill")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                    
                    if let dueDate = reminder.dueDate {
                        Label(dueDate.formatted(date: .abbreviated, time: .omitted), systemImage: "calendar")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Circle()
                    .fill(Color(reminder.priority.color))
                    .frame(width: 8, height: 8)
            }
        }
        .padding(.vertical, 4)
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.gray)
            
            TextField("Search reminders", text: $text)
            
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.gray)
                }
            }
        }
        .padding(10)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.caption)
                .fontWeight(.semibold)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(isSelected ? Color.blue : Color(.systemGray5))
                .foregroundStyle(isSelected ? .white : .primary)
                .cornerRadius(8)
        }
    }
}

#Preview {
    ContentView()
}
