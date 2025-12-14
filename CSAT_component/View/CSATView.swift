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
                    
                    Button("bad experience") {
                        viewModel.closePopup()
                    }
                    .foregroundColor(.blue)
                    .padding(.bottom)
                }
                .padding()
                .frame(height: 300)
            }
            
            // STATE 1 & 2
            if !viewModel.showThankYou {
                
                Text("How would you rate your experience?")
                    .font(.headline)
                    .padding(.top, 8)
                
                HStack(spacing: 10) {
                    ForEach(1...5, id: \.self) { star in
                        Image(systemName: star <= viewModel.selectedRating ? "star.fill" : "star")
                            .font(.title)
                            .foregroundColor(.yellow)
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
                .padding(.vertical)
                
                // STATE 2 — Expanded with text fields
                if viewModel.isExpanded {
                    VStack(spacing: 12) {
                        
                        TextField("What did you like most?", text: $viewModel.feedbackText1)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("What could be improved?", text: $viewModel.feedbackText2)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Additional Comments")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                            
                            TextEditor(text: $viewModel.additionalComments)
                                .frame(height: 100)
                                .padding(4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                )
                                .overlay(
                                    Group {
                                        if viewModel.additionalComments.isEmpty {
                                            Text("Write your feedback...")
                                                .foregroundColor(.gray.opacity(0.5))
                                                .padding(.leading, 8)
                                                .padding(.top, 12)
                                                .allowsHitTesting(false)
                                        }
                                    },
                                    alignment: .topLeading
                                )
                        }
                        
                        Button(action: {
                            viewModel.showThankYou = true
                        }) {
                            Text("Submit")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        .contentShape(Rectangle())
                        .padding(.top, 8)
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
        }
        .frame(height: viewModel.showThankYou ? 400 : (viewModel.isExpanded ? 520 : 200))
        .animation(.easeInOut(duration: 0.3), value: viewModel.isExpanded)
        .animation(.easeInOut(duration: 0.3), value: viewModel.showThankYou)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding()
        .offset(y: viewModel.showPopup ? 0 : 500)
        .animation(.easeOut(duration: 0.3), value: viewModel.showPopup)
    }
}
