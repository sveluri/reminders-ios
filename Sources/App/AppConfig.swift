import Foundation

/// App configuration constants
enum AppConfig {
    /// App display name
    static let appName = "Reminders"
    
    /// App version
    static let version = "1.0.0"
    
    /// Build number
    static let buildNumber = "1"
    
    /// Minimum iOS version
    static let minIOSVersion = "17.0"
    
    /// UserDefaults storage key for reminders
    static let remindersStorageKey = "reminders_storage"
    
    /// Maximum reminders to display in list
    static let maxRemindersPerPage = 50
    
    /// Default category name
    static let defaultCategory = "General"
}

/// UI Constants
enum UIConstants {
    /// Standard corner radius
    static let cornerRadius: CGFloat = 12
    
    /// Standard padding
    static let standardPadding: CGFloat = 16
    
    /// Small padding
    static let smallPadding: CGFloat = 8
    
    /// Large padding
    static let largePadding: CGFloat = 24
}

/// Animation durations
enum AnimationDuration {
    static let short: CGFloat = 0.2
    static let medium: CGFloat = 0.3
    static let long: CGFloat = 0.5
}
