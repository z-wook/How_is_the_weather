//
//  NSMutableAttributedString+.swift
//  How_is_the_weather
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit

extension NSMutableAttributedString {
    static func customTemperatureText(inputText: String) -> NSMutableAttributedString {
        let text = NSMutableAttributedString(
            string: inputText,
            attributes: [.font: UIFont.systemFont(ofSize: 100, weight: .bold)])
        let length = inputText.count
        text.addAttributes([.font: UIFont.systemFont(ofSize: 50, weight: .bold)], range: NSMakeRange(length - 2, 2))
        return text
    }
}
