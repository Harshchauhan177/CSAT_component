//
//  CSATViewModel.swift
//  CSAT_component
//
//  Created by harsh chauhan on 14/12/25.
//

import Foundation
import Combine

// MARK: - ViewModel
class CSATViewModel: ObservableObject {
    @Published var feedback = CSATFeedback()
    @Published var currentState: CSATState = .initial
    @Published var showPopup = false
    
    var isExpanded: Bool {
        currentState == .expanded
    }
    
    var showThankYou: Bool {
        currentState == .thankYou
    }
    
    var popupHeight: CGFloat {
        switch currentState {
        case .initial:
            return 200
        case .expanded:
            return 380
        case .thankYou:
            return 260
        }
    }
    
    func updateRating(_ rating: Int) {
        feedback.rating = rating
        
        if rating > 3 {
            currentState = .thankYou
            hidePopupAfterDelay()
        } else {
            currentState = .expanded
        }
    }
    
    func updateComment(_ comment: String) {
        feedback.comment = comment
    }
    
    func submitFeedback() {
        // Here you can add logic to send feedback to backend
        print("Feedback submitted: Rating \(feedback.rating), Comment: \(feedback.comment)")
        currentState = .thankYou
        hidePopupAfterDelay()
    }
    
    func showCSATPopup() {
        showPopup = true
    }
    
    func resetFeedback() {
        feedback = CSATFeedback()
        currentState = .initial
        showPopup = false
    }
    
    private func hidePopupAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.resetFeedback()
        }
    }
}
