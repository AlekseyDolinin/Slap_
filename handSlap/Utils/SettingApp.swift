import UIKit

class SettingApp: NSObject {
    
    //
    class func isSoundOn() -> Bool {
        return UserDefaults.standard.bool(forKey: "SoundOn")
    }
    
    //
    class func isVibrationOn() -> Bool {
        return UserDefaults.standard.bool(forKey: "VibrationOn")
    }
    
}
