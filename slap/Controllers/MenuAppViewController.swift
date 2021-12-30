import UIKit

class MenuAppViewController: GeneralViewController {

    @IBOutlet weak var getFullVersionButton: UIButton!
    @IBOutlet weak var restorePurshaseButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFullVersionButton.isHidden = StoreManager.isFullVersion()
        restorePurshaseButton.isHidden = StoreManager.isFullVersion()
        
    }
    
    //
    func showModalFullVersion() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FullVersionViewController") as! FullVersionViewController
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    //
    @IBAction func sound(_ sender: Any) {
        let soundOn = !(UserDefaults.standard.bool(forKey: "SoundOn"))
        UserDefaults.standard.set(soundOn, forKey: "SoundOn")
        print("soundOn: \(UserDefaults.standard.bool(forKey: "SoundOn"))")
    }
    
    //
    @IBAction func vibration(_ sender: Any) {
        let vibrationOn = !(UserDefaults.standard.bool(forKey: "VibrationOn"))
        UserDefaults.standard.set(vibrationOn, forKey: "VibrationOn")
        print("VibrationOn: \(UserDefaults.standard.bool(forKey: "VibrationOn"))")
    }
    
    //
    @IBAction func getFullVersion(_ sender: Any) {
        showModalFullVersion()
    }
    
    //
    @IBAction func restorePurshase(_ sender: Any) {

    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: false)
    }
}
