import SwiftUI

extension Bundle {
    var releaseVersionNumber: String {
        return (infoDictionary?["CFBundleShortVersionString"] ?? "") as! String
    }

    var buildVersionNumber: String {
        return (infoDictionary?["CFBundleVersion"] ?? "") as! String
    }
}

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

