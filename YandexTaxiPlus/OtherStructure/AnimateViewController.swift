//
//  AnimateViewController.swift
//  YandexTaxiPlus
//
//  Created by Чингиз on 11/30/18.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import Spring
class AnimateViewController: UIViewController {

    @IBOutlet weak var TaxiText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = maincolor
        // Do any additional setup after loading the view.
        TaxiText.text = "Che tam"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
