import Foundation

struct Reminder: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String
    var description: String = ""
    var isCompleted: Bool = false
    var dueDate: Date?
    var priority: Priority = .medium
    var category: String = "General"
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
    
    enum Priority: String, Codable, CaseIterable {
        case low = "Low"
        case medium = "Medium"
        case high = "High"
        
        var color: String {
            switch self {
            case .low: return "green"
            case .medium: return "orange"
            case .high: return "red"
            }
        }
    }
}

extension Reminder {
    static let sampleReminders = [
        Reminder(title: "Buy groceries", description: "Milk, eggs, bread", priority: .medium),
        Reminder(title: "Call dentist", description: "Schedule appointment", priority: .high, dueDate: Date().addingTimeInterval(86400)),
        Reminder(title: "Review project", description: "Check the Q2 deliverables", priority: .high, isCompleted: false),
        Reminder(title: "Gym session", description: "45 minutes workout", priority: .low, category: "Health")
    ]
}
