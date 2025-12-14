# CSAT Component

A beautiful and interactive Customer Satisfaction (CSAT) survey component built with SwiftUI for iOS applications.

## Features

- Clean and modern UI design
- 5-star rating system
- Multi-select feedback options for low ratings
- Additional comments text field
- Three-state experience flow:
  1. Rating selection
  2. Detailed feedback (for ratings ≤ 3)
  3. Thank you confirmation
- Smooth animations and transitions
- Responsive design

## Architecture

The project follows the **MVVM (Model-View-ViewModel)** architecture pattern:

```
CSAT_component/
├── Model/
│   └── CSATModel.swift          # Data models
├── View/
│   └── CSATView.swift           # UI components (CSATPopupView, FeedbackButton)
├── ViewModel/
│   └── CSATViewModel.swift      # Business logic and state management
├── ContentView.swift            # Main app view
└── CSAT_componentApp.swift      # App entry point
```

## How It Works

1. **Initial State**: Users see a welcome screen with a "Share Feedback" button
2. **Rating Selection**: Tapping the button shows a popup with a 5-star rating system
3. **Conditional Flow**:
   - **High ratings (4-5 stars)**: Shows immediate thank you message
   - **Low ratings (1-3 stars)**: Expands to show feedback options and comment field
4. **Submission**: After submitting, users see a thank you confirmation

## Components

### CSATViewModel

Manages the survey state including:

- `showPopup`: Controls popup visibility
- `selectedRating`: Tracks star rating (1-5)
- `isExpanded`: Controls expanded feedback form
- `showThankYou`: Controls thank you screen
- `additionalComments`: Stores user comments
- `selectedFeedbackOptions`: Tracks selected feedback tags

### CSATPopupView

Main survey popup component with:

- Animated slide-up presentation
- Dynamic height based on state
- Close button
- Star rating interface
- Feedback options (for low ratings)
- Comment text field
- Submit button

### FeedbackButton

Reusable button component for quick feedback options:

- "Too slow"
- "Poor experience"
- "Confusing"
- "Not helpful"

## Requirements

- iOS 15.0+
- Xcode 13.0+
- Swift 5.5+

## Usage

Simply integrate the `CSATPopupView` into your SwiftUI view:

```swift
import SwiftUI

struct YourView: View {
    @StateObject private var viewModel = CSATViewModel()

    var body: some View {
        ZStack {
            // Your main content

            VStack {
                Spacer()
                CSATPopupView(viewModel: viewModel)
            }
        }
    }
}
```

Trigger the survey popup:

```swift
Button("Show Survey") {
    viewModel.showPopup = true
}
```

## Customization

You can customize colors, text, and feedback options by modifying:

- Star colors in `CSATView.swift`
- Feedback button options
- Text copy and messaging
- Animation durations
- UI dimensions and spacing

## License

This project is available for educational and commercial use.

## Author

Created by harsh chauhan on 14/12/25
