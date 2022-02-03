import UIKit

class HexColorToUIColor {
    
    func convertHexColor(hexColor:String) -> UIColor {
       
        var str:String = hexColor.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (str.hasPrefix("#")) {
            str.remove(at: str.startIndex)
        }
        
        if ((str.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: str).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
