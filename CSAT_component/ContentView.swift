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

            VStack {
                Button("Show CSAT Popup") {
                    viewModel.showPopup = true
                }
                .padding()

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
