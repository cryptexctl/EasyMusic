//
//  RadioPlayer.swift
//  EasyMusic
//
//  Created by Platon on 08.12.2024.
//


import SwiftUI
import AVKit

struct RadioPlayer: View {
    let station: Station
    @State private var player = AVPlayer()

    var body: some View {
        VStack {
            Text(station.name)
                .font(.largeTitle)
                .padding()

            Text(station.description)
                .padding()

            Spacer()

            Button(action: togglePlay) {
                Image(systemName: player.timeControlStatus == .playing ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
            }

            Spacer()
        }
        .onAppear {
            setupPlayer()
        }
    }

    private func setupPlayer() {
        guard let url = URL(string: station.streamURL) else { return }
        let item = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: item)
    }

    private func togglePlay() {
        if player.timeControlStatus == .playing {
            player.pause()
        } else {
            player.play()
        }
    }
}
