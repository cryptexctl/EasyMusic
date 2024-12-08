//
//  ContentView.swift
//  EasyMusic
//
//  Created by Platon on 08.12.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var currentStationIndex: Int = 0
    @State private var isPlaying: Bool = false
    @ObservedObject private var radioPlayer = RadioPlayer.shared

    private let stations: [Station] = [
        Station(
            name: "Tabris FM",
            description: "Радио, на котором крутятся отобранные, нормальные, приятные треки многих жанров. Плейлист пополняется ежедневно в районе от 18:00 до 22:00.",
            streamURL: "https://stream.zeno.fm/uzrnuzqmen6tv",
            color: LinearGradient(colors: [.red], startPoint: .top, endPoint: .bottom)
        ),
        Station(
            name: "Night FM",
            description: "Радио для концентрации, успокоения, наслаждения. На радио играет спокойная музыка различных исполнителей. Идеально подойдет для ночных прогулок и поездок.",
            streamURL: "https://stream.zeno.fm/lgxpsux5v9avv",
            color: LinearGradient(colors: [.blue, .cyan], startPoint: .top, endPoint: .bottom)
        ),
        Station(
            name: "Penis FM",
            description: "Радио для тех, кого обычные треки не устраивают и они слушают альтернативные жанры. На радио играют треки таких исполнителей как Dekma, Кишлак и т.д.",
            streamURL: "https://stream.zeno.fm/hfrwlmkuux4uv",
            color: LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom)
        ),
        Station(
            name: "Platon FM",
            description: "Музыка всех жанров, характеров и исполнителей. Идеально подойдет для меломанов.",
            streamURL: "http://45.95.234.91:8000/music",
            color: LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom)
        )
    ]

    private var currentStation: Station {
        stations[currentStationIndex]
    }

    var body: some View {
        ZStack {
            currentStation.color
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text(currentStation.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Text(currentStation.description)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding()

                Text("Now Playing: \(radioPlayer.trackTitle)")
                    .foregroundColor(.white)
                    .font(.headline)

                Spacer()

                VStack {
                    Button(action: togglePlay) {
                        Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.white)
                            .padding(.bottom, 20)
                    }

                    HStack {
                        Button(action: previousStation) {
                            Image(systemName: "chevron.left")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        Button(action: nextStation) {
                            Image(systemName: "chevron.right")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 40)
                }
            }
            .padding()
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: .nextStation, object: nil, queue: .main) { _ in
                self.nextStation()
            }
            NotificationCenter.default.addObserver(forName: .previousStation, object: nil, queue: .main) { _ in
                self.previousStation()
            }
        }
    }

    private func togglePlay() {
        if isPlaying {
            radioPlayer.stop()
        } else {
            radioPlayer.playStream(url: currentStation.streamURL)
        }
        isPlaying.toggle()
    }

    private func previousStation() {
        if currentStationIndex > 0 {
            currentStationIndex -= 1
            radioPlayer.playStream(url: currentStation.streamURL)
        }
    }

    private func nextStation() {
        if currentStationIndex < stations.count - 1 {
            currentStationIndex += 1
            radioPlayer.playStream(url: currentStation.streamURL)
        }
    }
}
