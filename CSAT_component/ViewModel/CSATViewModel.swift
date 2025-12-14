//
//  CSATViewModel.swift
//  CSAT_component
//
//  Created by harsh chauhan on 14/12/25.
//

import Foundation
import SwiftUI
import Combine
// MARK: - ViewModel
class CSATViewModel: ObservableObject {
    @Published var showPopup = false
    @Published var selectedRating = 0
    @Published var isExpanded = false
    @Published var showThankYou = false
    @Published var feedbackText1 = ""
    @Published var feedbackText2 = ""
    @Published var additionalComments = ""
    @Published var selectedFeedbackOptions: Set<String> = []
    
    func closePopup() {
        showPopup = false
        // Reset after animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.selectedRating = 0
            self.isExpanded = false
            self.showThankYou = false
            self.feedbackText1 = ""
            self.feedbackText2 = ""
            self.additionalComments = ""
            self.selectedFeedbackOptions = []
        }
    }
    
    func toggleFeedbackOption(_ option: String) {
        if selectedFeedbackOptions.contains(option) {
            selectedFeedbackOptions.remove(option)
        } else {
            selectedFeedbackOptions.insert(option)
        }
    }
}
