//
//  CSATView.swift
//  CSAT_component
//
//  Created by harsh chauhan on 14/12/25.
//

import SwiftUI

// MARK: - CSAT Popup View
struct CSATPopupView: View {
    @ObservedObject var viewModel: CSATViewModel
    
    var body: some View {
        VStack {
            if viewModel.showThankYou {
                ThankYouView()
            } else {
                RatingView(viewModel: viewModel)
                
                if viewModel.isExpanded {
                    FeedbackFormView(viewModel: viewModel)
                }
            }
        }
        .frame(height: viewModel.popupHeight)
        .animation(.easeInOut(duration: 0.3), value: viewModel.currentState)
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .padding()
        .offset(y: viewModel.showPopup ? 0 : 300)
        .animation(.easeOut(duration: 0.3), value: viewModel.showPopup)
    }
}

// MARK: - Thank You View
struct ThankYouView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "hand.thumbsup.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.green)
            
            Text("Thank You!")
                .font(.title)
                .bold()
            
            Text("We appreciate your feedback.")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
    }
}

// MARK: - Rating View
struct RatingView: View {
    @ObservedObject var viewModel: CSATViewModel
    
    var body: some View {
        VStack {
            Text("How would you rate your experience?")
                .font(.headline)
                .padding(.top)
            
            HStack(spacing: 10) {
                ForEach(1...5, id: \.self) { star in
                    StarButton(
                        star: star,
                        selectedRating: viewModel.feedback.rating,
                        action: { viewModel.updateRating(star) }
                    )
                }
            }
            .padding(.vertical)
        }
    }
}

// MARK: - Star Button
struct StarButton: View {
    let star: Int
    let selectedRating: Int
    let action: () -> Void
    
    var body: some View {
        Image(systemName: star <= selectedRating ? "star.fill" : "star")
            .font(.title)
            .foregroundColor(.yellow)
            .onTapGesture {
                action()
            }
    }
}

// MARK: - Feedback Form View
struct FeedbackFormView: View {
    @ObservedObject var viewModel: CSATViewModel
    @State private var commentText = ""
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Additional Comments")
                .font(.subheadline)
            
            TextField("Write your feedback...", text: $commentText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onChange(of: commentText) { newValue in
                    viewModel.updateComment(newValue)
                }
            
            Button("Submit") {
                viewModel.submitFeedback()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(12)
            .padding(.top)
        }
        .padding(.horizontal)
    }
}
