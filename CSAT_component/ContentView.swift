//
//  ContentView.swift
//  CSAT_component
//
//  Created by harsh chauhan on 14/12/25.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = CSATViewModel()

    var body: some View {
        ZStack {

            Color.white
                .ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()
                
                // CSAT Survey branding in the center
                VStack(spacing: 24) {
                    // Chat bubble with star icon and decorative dots
                    ZStack {
                        // Main chat bubble
                        RoundedRectangle(cornerRadius: 35)
                            .fill(Color(red: 0.85, green: 0.88, blue: 0.95))
                            .frame(width: 160, height: 160)
                        
                        // Blue star icon
                        Image(systemName: "star.fill")
                            .font(.system(size: 60))
                            .foregroundColor(Color(red: 0.29, green: 0.53, blue: 0.97))
                        
                        // Small decorative yellow dot (top right)
                        Circle()
                            .fill(Color(red: 0.95, green: 0.77, blue: 0.35))
                            .frame(width: 12, height: 12)
                            .offset(x: 90, y: -70)
                        
                        // Small decorative blue dot (bottom right)
                        Circle()
                            .fill(Color(red: 0.85, green: 0.88, blue: 0.95))
                            .frame(width: 10, height: 10)
                            .offset(x: 105, y: 30)
                    }
                    .padding(.bottom, 8)
                    
                    VStack(spacing: 12) {
                        Text("CSAT Survey")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.black)
                        
                        Text("Help us improve your\nexperience")
                            .font(.system(size: 17))
                            .foregroundColor(Color(red: 0.55, green: 0.55, blue: 0.57))
                            .multilineTextAlignment(.center)
                            .lineSpacing(2)
                    }
                }
                
                Spacer()
                
                // Share Feedback Button at the bottom
                VStack(spacing: 12) {
                    Button(action: {
                        viewModel.showPopup = true
                    }) {
                        HStack(spacing: 12) {
                            Image(systemName: "hand.thumbsup.fill")
                                .font(.system(size: 20))
                            Text("Share Feedback")
                                .font(.system(size: 17, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(Color.black)
                        .cornerRadius(16)
                    }
                    .padding(.horizontal, 24)
                    
                    Text("Takes less than 2 minutes")
                        .font(.system(size: 15))
                        .foregroundColor(Color(red: 0.55, green: 0.55, blue: 0.57))
                        .padding(.bottom, 40)
                }
            }

            VStack {
                Spacer()

                CSATPopupView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}
