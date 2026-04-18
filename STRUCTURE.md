# Reminders iOS App

A modern iOS Reminders application built with SwiftUI.

## Features

- ✅ Create, read, update, and delete reminders
- 🎯 Priority levels (Low, Medium, High)
- 🏷️ Categorize reminders
- 📅 Set due dates and times
- 🔍 Search and filter reminders
- ✓ Mark reminders as complete
- 💾 Persistent storage with UserDefaults

## Project Structure

```
Sources/
├── App/
│   └── RemindersApp.swift          # App entry point
├── Models/
│   └── Reminder.swift              # Data model
├── ViewModels/
│   └── RemindersViewModel.swift    # State management
└── Views/
    ├── ContentView.swift           # Main list view
    ├── ReminderDetailView.swift    # Detail view
    ├── AddReminderView.swift       # Create reminder
    └── EditReminderView.swift      # Edit reminder

Resources/
└── Assets                           # Images and colors
```

## Requirements

- iOS 17+
- Swift 5.9+
- Xcode 15+

## Getting Started

1. Open the project in Xcode
2. Build and run on a simulator or device
3. Create your first reminder!

## Data Model

Each reminder contains:
- **Title**: Required field for the reminder
- **Description**: Optional detailed description
- **Priority**: Low, Medium, or High
- **Category**: Custom categorization
- **Due Date**: Optional date and time
- **Is Completed**: Boolean to mark as done
- **Timestamps**: Created and updated dates

## Views

### ContentView
Main view displaying:
- List of reminders
- Search bar for filtering
- Priority filter chips
- Add button to create new reminders
- Pending reminders counter

### ReminderDetailView
Shows detailed information:
- Full reminder title and status
- Priority and category
- Description
- Due date
- Creation and update timestamps
- Edit button

### AddReminderView
Form to create new reminders with:
- Title and description inputs
- Priority selection
- Category input
- Optional due date picker

### EditReminderView
Form to modify existing reminders with:
- All create form fields
- Completion status toggle
- Save and cancel actions

## Storage

Reminders are stored locally using `UserDefaults` and encoded as JSON. On first launch, sample reminders are loaded.

## Future Enhancements

- CloudKit sync
- Recurring reminders
- Notifications
- Widget support
- Dark mode optimization
- Reminder templates
