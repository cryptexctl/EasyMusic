import AVFoundation

class RadioPlayer {
    static let shared = RadioPlayer()
    private var player: AVPlayer?

    func playStream(url: String) {
        guard let streamURL = URL(string: url) else { return }
        player = AVPlayer(url: streamURL)
        player?.play()
    }

    func stop() {
        player?.pause()
        player = nil
    }
}