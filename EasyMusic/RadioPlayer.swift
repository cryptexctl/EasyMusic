//
//  RadioPlayer.swift
//  EasyMusic
//
//  Created by Platon on 08.12.2024.
//


import AVFoundation
import MediaPlayer

class RadioPlayer: NSObject, ObservableObject {
    static let shared = RadioPlayer()
    private var player: AVPlayer?

    @Published var trackTitle: String = "Unknown Track"

    override init() {
        super.init()
        setupRemoteTransportControls()
    }

    func playStream(url: String) {
        guard let streamURL = URL(string: url) else {
            print("Invalid stream URL")
            return
        }
        print("Playing stream: \(url)")
        let playerItem = AVPlayerItem(url: streamURL)
        player = AVPlayer(playerItem: playerItem)

        // Подписываемся на обновления метаданных
        playerItem.addObserver(self, forKeyPath: "timedMetadata", options: [.new, .initial], context: nil)
        player?.play()

        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to activate audio session: \(error)")
        }

        updateNowPlayingInfo(title: "Connecting...", artist: "EasyMusic")
    }

    func stop() {
        print("Stopping playback")
        player?.pause()
        player?.currentItem?.removeObserver(self, forKeyPath: "timedMetadata")
        player = nil
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nil
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "timedMetadata",
           let playerItem = object as? AVPlayerItem,
           let metadataList = playerItem.timedMetadata {
            for metadata in metadataList {
                if let value = metadata.value as? String {
                    let cleanedValue = cleanMetadata(value)
                    DispatchQueue.main.async {
                        self.trackTitle = cleanedValue
                        print("Now playing: \(self.trackTitle)")
                        self.updateNowPlayingInfo(title: self.trackTitle, artist: "EasyMusic")
                    }
                }
            }
        }
    }

    private func setupRemoteTransportControls() {
        let commandCenter = MPRemoteCommandCenter.shared()

        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget { [weak self] event in
            self?.resumePlayback()
            return .success
        }

        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget { [weak self] event in
            self?.pausePlayback()
            return .success
        }

        commandCenter.stopCommand.isEnabled = true
        commandCenter.stopCommand.addTarget { [weak self] event in
            self?.stop()
            return .success
        }
    }

    private func resumePlayback() {
        guard let player = player else { return }
        player.play()
        updateNowPlayingInfo(title: trackTitle, artist: "EasyMusic")
    }

    private func pausePlayback() {
        guard let player = player else { return }
        player.pause()
    }

    private func updateNowPlayingInfo(title: String, artist: String) {
        var nowPlayingInfo: [String: Any] = [
            MPMediaItemPropertyTitle: title,
            MPMediaItemPropertyArtist: artist
        ]

        if let artworkImage = UIImage(systemName: "music.note") {
            let artwork = MPMediaItemArtwork(boundsSize: artworkImage.size) { _ in artworkImage }
            nowPlayingInfo[MPMediaItemPropertyArtwork] = artwork
        }

        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = player?.rate ?? 0
        nowPlayingInfo[MPNowPlayingInfoPropertyIsLiveStream] = true

        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }

    private func cleanMetadata(_ rawValue: String) -> String {
        if let data = rawValue.data(using: .isoLatin1), let utf8String = String(data: data, encoding: .utf8) {
            return utf8String.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return rawValue.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

import Foundation

extension Notification.Name {
    static let nextStation = Notification.Name("nextStation")
    static let previousStation = Notification.Name("previousStation")
}
