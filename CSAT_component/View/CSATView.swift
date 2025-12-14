//
//  CSATView.swift
//  CSAT_component
//
//  Created by harsh chauhan on 14/12/25.
//

import SwiftUI

// MARK: - View
struct CSATPopupView: View {
    @ObservedObject var viewModel: CSATViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Close Button (X)
            HStack {
                Spacer()
                Button(action: {
                    viewModel.closePopup()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                        .font(.system(size: 18))
                        .padding()
                }
            }
            
            // STATE 3 — THANK YOU
            if viewModel.showThankYou {
                VStack(spacing: 16) {
                    
                    Image(systemName: "swift")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.orange)
                    
                    Text("Thank You for your feedback!")
                        .font(.title2)
                        .bold()
                        .multilineTextAlignment(.center)
                    
                    Text("Your insight will help us improve")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.closePopup()
                    }) {
                        Text("bad experience")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.black)
                            .cornerRadius(25)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom)
                }
                .padding()
                .frame(height: 300)
            }
            
            // STATE 1 & 2
            if !viewModel.showThankYou {
                
                VStack(spacing: 4) {
                    Text("How would you rate your experience?")
                        .font(.system(size: 20, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Text("We value your feedback!")
                        .font(.system(size: 15))
                        .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                        .multilineTextAlignment(.center)
                }
                .padding(.bottom, 12)
                
                HStack(spacing: 8) {
                    ForEach(1...5, id: \.self) { star in
                        Image(systemName: star <= viewModel.selectedRating ? "star.fill" : "star.fill")
                            .font(.system(size: 36))
                            .foregroundColor(star <= viewModel.selectedRating ? Color(red: 1.0, green: 0.35, blue: 0.35) : Color(red: 0.88, green: 0.88, blue: 0.88))
                            .onTapGesture {
                                viewModel.selectedRating = star
                                
                                if star > 3 {
                                    viewModel.showThankYou = true
                                } else {
                                    viewModel.isExpanded = true
                                }
                            }
                    }
                }
                .padding(.vertical, 16)
                .padding(.bottom, 8)
                
                // STATE 2 — Expanded with text fields
                if viewModel.isExpanded {
                    ScrollView {
                        VStack(spacing: 16) {
                            
                            VStack(alignment: .leading, spacing: 12) {
                                Text("WHAT WENT WRONG?")
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(Color(red: 0.65, green: 0.65, blue: 0.65))
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(.bottom, 4)
                                
                                VStack(spacing: 10) {
                                    HStack(spacing: 10) {
                                        FeedbackButton(
                                            text: "Too slow",
                                            isSelected: viewModel.selectedFeedbackOptions.contains("Too slow")
                                        ) {
                                            viewModel.toggleFeedbackOption("Too slow")
                                        }
                                        
                                        FeedbackButton(
                                            text: "Poor experience",
                                            isSelected: viewModel.selectedFeedbackOptions.contains("Poor experience")
                                        ) {
                                            viewModel.toggleFeedbackOption("Poor experience")
                                        }
                                    }
                                    
                                    HStack(spacing: 10) {
                                        FeedbackButton(
                                            text: "Confusing",
                                            isSelected: viewModel.selectedFeedbackOptions.contains("Confusing")
                                        ) {
                                            viewModel.toggleFeedbackOption("Confusing")
                                        }
                                        
                                        FeedbackButton(
                                            text: "Not helpful",
                                            isSelected: viewModel.selectedFeedbackOptions.contains("Not helpful")
                                        ) {
                                            viewModel.toggleFeedbackOption("Not helpful")
                                        }
                                    }
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Additional Comments")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.black)
                                
                                ZStack(alignment: .topLeading) {
                                    TextEditor(text: $viewModel.additionalComments)
                                        .frame(height: 140)
                                        .padding(12)
                                        .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                                        .cornerRadius(12)
                                        .scrollContentBackground(.hidden)
                                    
                                    if viewModel.additionalComments.isEmpty {
                                        Text("Write your feedback...")
                                            .foregroundColor(Color(red: 0.75, green: 0.75, blue: 0.75))
                                            .padding(.leading, 18)
                                            .padding(.top, 20)
                                            .allowsHitTesting(false)
                                    }
                                }
                            }
                            
                            Button(action: {
                                viewModel.showThankYou = true
                            }) {
                                Text("Submit")
                                    .font(.system(size: 17, weight: .semibold))
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 16)
                                    .background(Color.black)
                                    .foregroundColor(.white)
                                    .cornerRadius(25)
                            }
                            .padding(.top, 4)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                    }
                }
            }
        }
        .frame(height: viewModel.showThankYou ? 400 : (viewModel.isExpanded ? 620 : 220))
        .animation(.easeInOut(duration: 0.3), value: viewModel.isExpanded)
        .animation(.easeInOut(duration: 0.3), value: viewModel.showThankYou)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 10)
        .padding(.horizontal, 16)
        .offset(y: viewModel.showPopup ? 0 : 500)
        .animation(.easeOut(duration: 0.3), value: viewModel.showPopup)
    }
}

// MARK: - Feedback Button Component
struct FeedbackButton: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: 15))
                .foregroundColor(isSelected ? .white : .black)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(isSelected ? Color.black : Color(red: 0.95, green: 0.95, blue: 0.95))
                .cornerRadius(22)
        }
    }
}
