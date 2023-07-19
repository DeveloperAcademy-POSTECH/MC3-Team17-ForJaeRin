//
//  String+Extension.swift
//  ForJaeRin
//
//  Created by 이용준의 Macbook on 2023/07/19.
//

import Foundation
import SwiftUI

extension String {
    func widthOfString(fontStyle: NSFont) -> CGFloat {
       let fontAttributes = [NSAttributedString.Key.font: fontStyle]
       let size = self.size(withAttributes: fontAttributes)
       return size.width
    }
    
    func getTextWidth(_ text: String, font: Font) -> CGFloat {
        let attributedText = NSAttributedString(string: text, attributes: [.font: font])
        let textSize = attributedText.size()
        return textSize.width
    }

}
