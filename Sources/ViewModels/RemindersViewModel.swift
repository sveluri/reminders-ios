import Foundation

@MainActor
class RemindersViewModel: ObservableObject {
    @Published var reminders: [Reminder] = []
    @Published var searchText: String = ""
    @Published var selectedPriority: Reminder.Priority? = nil
    @Published var selectedCategory: String? = nil
    
    private let storageKey = "reminders_storage"
    
    init() {
        loadReminders()
        if reminders.isEmpty {
            loadSampleReminders()
        }
    }
    
    // MARK: - Computed Properties
    
    var filteredReminders: [Reminder] {
        reminders.filter { reminder in
            let matchesSearch = searchText.isEmpty || 
                reminder.title.localizedCaseInsensitiveContains(searchText) ||
                reminder.description.localizedCaseInsensitiveContains(searchText)
            
            let matchesPriority = selectedPriority == nil || reminder.priority == selectedPriority
            let matchesCategory = selectedCategory == nil || reminder.category == selectedCategory
            
            return matchesSearch && matchesPriority && matchesCategory
        }
    }
    
    var categories: [String] {
        let categories = Set(reminders.map { $0.category })
        return Array(categories).sorted()
    }
    
    var pendingRemindersCount: Int {
        reminders.filter { !$0.isCompleted }.count
    }
    
    // MARK: - CRUD Operations
    
    func addReminder(_ reminder: Reminder) {
        var newReminder = reminder
        newReminder.id = UUID()
        newReminder.createdAt = Date()
        newReminder.updatedAt = Date()
        reminders.append(newReminder)
        saveReminders()
    }
    
    func updateReminder(_ reminder: Reminder) {
        if let index = reminders.firstIndex(where: { $0.id == reminder.id }) {
            var updatedReminder = reminder
            updatedReminder.updatedAt = Date()
            reminders[index] = updatedReminder
            saveReminders()
        }
    }
    
    func deleteReminder(_ reminder: Reminder) {
        reminders.removeAll { $0.id == reminder.id }
        saveReminders()
    }
    
    func toggleCompleted(_ reminder: Reminder) {
        if let index = reminders.firstIndex(where: { $0.id == reminder.id }) {
            reminders[index].isCompleted.toggle()
            reminders[index].updatedAt = Date()
            saveReminders()
        }
    }
    
    // MARK: - Persistence
    
    private func saveReminders() {
        if let encoded = try? JSONEncoder().encode(reminders) {
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }
    }
    
    private func loadReminders() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let decoded = try? JSONDecoder().decode([Reminder].self, from: data) {
            reminders = decoded
        }
    }
    
    private func loadSampleReminders() {
        reminders = Reminder.sampleReminders
        saveReminders()
    }
}
