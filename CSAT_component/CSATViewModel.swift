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
}
