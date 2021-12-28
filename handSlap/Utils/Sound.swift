import Foundation
import AVFoundation

class Sound {
    
    static var playerSlapEffect: AVAudioPlayer?
    
    ///
    class func setSlapEffect() {
        print("playSlapEffect")
        guard let url = Bundle.main.url(forResource: "wet_towel_on_body-18", withExtension: "flac") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            playerSlapEffect = try AVAudioPlayer(contentsOf: url, fileTypeHint: "flac")
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    ///
    class func removePlayers() {
        playerSlapEffect?.stop()
        playerSlapEffect = nil
    }
}
