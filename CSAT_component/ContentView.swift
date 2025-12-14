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
                // Share Feedback Button at the top
                Button(action: {
                    viewModel.showPopup = true
                }) {
                    HStack(spacing: 12) {
                        Image(systemName: "hand.thumbsup.fill")
                            .font(.title3)
                        Text("Share Feedback")
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.8)]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(12)
                    .shadow(color: Color.blue.opacity(0.3), radius: 8, x: 0, y: 4)
                }
                .padding(.horizontal, 24)
                .padding(.top, 60)
                
                Spacer()
                    .frame(maxHeight: 150)
                
                // CSAT Survey branding in the middle
                VStack(spacing: 24) {
                    // Chat bubble with star icon
                    ZStack {
                        Image(systemName: "message.fill")
                            .font(.system(size: 100))
                            .foregroundColor(Color.blue.opacity(0.2))
                        
                        Image(systemName: "star.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.blue)
                            .offset(y: -5)
                    }
                    .frame(height: 120)
                    
                    VStack(spacing: 12) {
                        Text("CSAT Survey")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.black)
                        
                        Text("Help us improve your experience")
                            .font(.system(size: 18))
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
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
