# Reminders iOS

A modern, feature-rich iOS Reminders application built with SwiftUI and Swift.

## Overview

This app provides a complete reminders management solution with a clean, intuitive interface. Users can create, organize, and track their reminders with priority levels, categories, and due dates.

## Key Features

- ✅ **CRUD Operations**: Create, read, update, and delete reminders
- 🎯 **Priority Levels**: Low, Medium, High priority indicators
- 🏷️ **Categories**: Organize reminders by custom categories
- 📅 **Due Dates**: Set optional due dates and times
- 🔍 **Search & Filter**: Find reminders quickly with search and filter by priority
- ✓ **Completion Tracking**: Mark reminders as complete
- 💾 **Persistent Storage**: Data saved locally with UserDefaults
- 🎨 **Modern UI**: SwiftUI-based responsive design

## Getting Started

### Requirements
- iOS 17 or later
- Xcode 15 or later
- Swift 5.9 or later

### Running the App

1. Clone the repository
2. Open in Xcode or run via Swift Package Manager
3. Build and run on simulator or device
4. Start creating reminders!

## Project Architecture

The app follows a clean MVVM architecture:

```
Sources/
├── App/
│   ├── RemindersApp.swift      # App entry point
│   └── AppConfig.swift         # Configuration constants
├── Models/
│   └── Reminder.swift          # Data model with Codable support
├── ViewModels/
│   └── RemindersViewModel.swift # State management with @MainActor
└── Views/
    ├── ContentView.swift       # Main list view with search/filter
    ├── ReminderDetailView.swift # Detailed reminder display
    ├── AddReminderView.swift   # Create new reminder form
    └── EditReminderView.swift  # Edit existing reminder form
```

## Data Model

### Reminder Structure
```swift
struct Reminder {
    var id: UUID                      // Unique identifier
    var title: String                 // Required title
    var description: String           // Optional description
    var isCompleted: Bool             // Completion status
    var dueDate: Date?                // Optional due date
    var priority: Priority            // Low, Medium, High
    var category: String              // Custom category
    var createdAt: Date               // Creation timestamp
    var updatedAt: Date               // Last update timestamp
}
```

## Usage Examples

### Creating a Reminder
1. Tap the **+** button in the toolbar
2. Enter title and optional description
3. Select priority and category
4. Optionally set a due date
5. Tap "Add"

### Filtering Reminders
- Use the search bar to find reminders by title or description
- Tap priority chips to filter by priority level
- Combine filters for refined results

### Marking Complete
- Tap the circle icon next to a reminder to toggle completion
- Completed reminders show a green checkmark and strikethrough text

## Storage

Reminders are stored locally using `UserDefaults` with JSON encoding. On first launch, sample reminders are provided as examples. All changes are automatically persisted.

## Future Enhancements

- CloudKit synchronization across devices
- Recurring/repeating reminders
- Local push notifications
- Home Screen widget support
- Reminder templates
- Advanced filtering options
- Tags and hashtag support
- Dark mode refinements

## Development

### Adding New Features
1. Create models in `Sources/Models/`
2. Add state management in `Sources/ViewModels/`
3. Implement UI in `Sources/Views/`
4. Update `RemindersViewModel` for any data changes

### Code Style
Follow Swift best practices:
- Use descriptive variable and function names
- Leverage Swift type system
- Implement Codable for data persistence
- Use @MainActor for UI updates

## License

MIT
