//
//  NewDesignView.swift
//  EasyMusic
//
//  Created by Platon on 10.12.2024.
//

import SwiftUI

struct NewDesignView: View {
    @State private var currentStation: Station = stations[0]
    @State private var isPlaying: Bool = false

    var body: some View {
        VStack {
            Spacer()

            Button(action: {
                isPlaying.toggle()
                // Add animation or music playback toggle here
            }) {
                ZStack {
                    Circle()
                        .fill(LinearGradient(
                            gradient: Gradient(colors: currentStation.colors),
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                        .frame(width: 100, height: 100)

                    Image(systemName: isPlaying ? "pause.circle" : "play.circle")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white)
                }
            }

            Spacer()

            Button("здесь пока ничего не работает, пожалуйста, переключись обратно в старый дизайн") {
                // Add settings navigation logic 
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .navigationTitle(currentStation.name)
    }
}
