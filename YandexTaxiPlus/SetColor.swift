//
//  SetColor.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12/3/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
import UIKit
class UIColourScheme {
    func set(for viewController: UIViewController) {
        
        if APItoken.getColorType() == 0 {
            maincolor = #colorLiteral(red: 0, green: 0.7490196078, blue: 0.7568627451, alpha: 1)
            viewController.view.backgroundColor = background_wh
        }
        else {
            maincolor = background_bl
            viewController.view.backgroundColor = background_bl2
        }
    }
    static let instance = UIColourScheme()

}
