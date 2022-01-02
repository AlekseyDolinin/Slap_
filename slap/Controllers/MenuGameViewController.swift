import UIKit

class MenuGameViewController: GeneralViewController {

    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var vibrationButton: UIButton!
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        setIconSoundButton()
        setIconVibrationButton()
    }
    
    //
    func setIconSoundButton() {
        let nameIconSound = UserDefaults.standard.bool(forKey: "SoundOn") == true ? "buttonSoundOn" : "buttonSoundOff"
        soundButton.setImage(UIImage(named: nameIconSound), for: .normal)
    }
    
    //
    func setIconVibrationButton() {
        let nameIconVibration = UserDefaults.standard.bool(forKey: "VibrationOn") == true ? "buttonVibrationOn" : "buttonVibrationOff"
        vibrationButton.setImage(UIImage(named: nameIconVibration), for: .normal)
    }
    
    //
    @IBAction func sound(_ sender: Any) {
        let soundOn = !(UserDefaults.standard.bool(forKey: "SoundOn"))
        UserDefaults.standard.set(soundOn, forKey: "SoundOn")
        print("soundOn: \(UserDefaults.standard.bool(forKey: "SoundOn"))")
        setIconSoundButton()
    }
    
    //
    @IBAction func vibration(_ sender: Any) {
        let vibrationOn = !(UserDefaults.standard.bool(forKey: "VibrationOn"))
        UserDefaults.standard.set(vibrationOn, forKey: "VibrationOn")
        print("VibrationOn: \(UserDefaults.standard.bool(forKey: "VibrationOn"))")
        setIconVibrationButton()
    }
    
    //
    @IBAction func restartRound(_ sender: Any) {
        self.dismiss(animated: true) {
            NotificationCenter.default.post(name: self.nReloadRound, object: nil)
        }
    }

    //
    @IBAction func home(_ sender: Any) {
        dismiss(animated: false) {
            NotificationCenter.default.post(name: self.nBackHome, object: self)
        }
    }
    
    //
    @IBAction func backToGame(_ sender: Any) {
        dismiss(animated: false)
    }
}
