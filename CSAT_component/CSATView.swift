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
        VStack {
            
            // STATE 3 — THANK YOU
            if viewModel.showThankYou {
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
            
            // STATE 1 & 2
            if !viewModel.showThankYou {
                
                Text("How would you rate your experience?")
                    .font(.headline)
                    .padding(.top)
                
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
                
                if viewModel.isExpanded {
                    VStack(spacing: 12) {
                        
                        Text("Additional Comments")
                            .font(.subheadline)
                        
                        TextField("Write your feedback...", text: .constant(""))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button("Submit") {
                            viewModel.showThankYou = true
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
        }
        .frame(height: viewModel.showThankYou ? 260 : (viewModel.isExpanded ? 380 : 200))
        .animation(.easeInOut(duration: 0.3), value: viewModel.isExpanded)
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .padding()
        .offset(y: viewModel.showPopup ? 0 : 300)
        .animation(.easeOut(duration: 0.3), value: viewModel.showPopup)
    }
}
