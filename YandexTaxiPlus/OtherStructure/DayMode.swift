//
//  DayMode.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 12/3/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import Foundation
class DayMode:UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        changeColor()
        
    }
    
    
    
    func changeColor() {
        if APItoken.getColorType() == 0 {
            view.backgroundColor = UIColor.white
            self.navigationController?.navigationBar.barTintColor = maincolor
        }
        else {
            view.backgroundColor = UIColor.black
            self.navigationController?.navigationBar.barTintColor = background_bl
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
