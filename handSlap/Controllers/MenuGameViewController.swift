import UIKit

class MenuGameViewController: GeneralViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sound(_ sender: Any) {
        let soundOn = !(UserDefaults.standard.bool(forKey: "SoundOn"))
        UserDefaults.standard.set(soundOn, forKey: "SoundOn")
        print("soundOn: \(UserDefaults.standard.bool(forKey: "SoundOn"))")
    }
    
    @IBAction func vibration(_ sender: Any) {
        let vibrationOn = !(UserDefaults.standard.bool(forKey: "VibrationOn"))
        UserDefaults.standard.set(vibrationOn, forKey: "VibrationOn")
        print("VibrationOn: \(UserDefaults.standard.bool(forKey: "VibrationOn"))")
    }
    
    @IBAction func restartRound(_ sender: Any) {
        self.dismiss(animated: true) {
            NotificationCenter.default.post(name: self.nReloadRound, object: nil)
        }
    }

    @IBAction func home(_ sender: Any) {
        dismiss(animated: false) {
            NotificationCenter.default.post(name: self.nBackHome, object: self)
        }
    }
    
    @IBAction func backToGame(_ sender: Any) {
        dismiss(animated: false)
    }
}
