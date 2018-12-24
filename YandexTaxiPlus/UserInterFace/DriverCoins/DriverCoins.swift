//
//  DriverCoinsViewController.swift
//  newtaxi
//
//  Created by Чингиз on 02.09.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import Presentr

class DriverCoins: UIViewController{
    let blackline : UIView = UIView()
    let blackline1 : UIView = UIView()
    let blackline2 : UIView = UIView()
    let blackline3 : UIView = UIView()

    let drivedlabel : MainLabel = MainLabel()
    let coinslabel : MainLabel = MainLabel()
    let ordererlabel : MainLabel = MainLabel()
    let drivedint : MainLabel = MainLabel()
    let coinsint : MainLabel = MainLabel()
    let orderedint : MainLabel = MainLabel()
    let getButton : MainButton = MainButton()
    let presentr : Presentr = {
        let width = ModalSize.fluid(percentage: 0.9)
        let heigh = ModalSize.fluid(percentage: 0.3)
        let center = ModalCenterPosition.center
        let customtype = PresentationType.custom(width: width, height: heigh, center: center)
        let customPresenter = Presentr(presentationType: customtype)
        customPresenter.backgroundOpacity  = 0.5
        
        return customPresenter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        create()
        addlabels()
        UIColourScheme.instance.set(for:self)
        GetCoinsDriver.get { (coins) in
            self.drivedint.text = String(coins.orders_monets ?? 0)
            self.coinsint.text = String(coins.added_monets ?? 0)
            self.orderedint.text = String(coins.balance ?? 0)
        }
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = maincolor
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func create() {
        
        view.addSubview(blackline)
        
        blackline.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,width: 0,height: 2)
        drivedlabel.text = "Заработанные монеты :"
        coinslabel.text = "Пополнение :"
        ordererlabel.text = "Текущий баланс :"
        drivedlabel.textAlignment = .left
        coinslabel.textAlignment = .left
        drivedlabel.font = UIFont.systemFont(ofSize: 15)
        coinslabel.font = UIFont.systemFont(ofSize: 15)
        blackline1.backgroundColor = UIColor.black
        blackline2.backgroundColor = UIColor.black
        blackline3.backgroundColor = UIColor.black
    }
    
    func addlabels() {
        view.backgroundColor = UIColor.white
        view.addSubview(drivedlabel)
        drivedlabel.setAnchor(top: blackline.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 0)
        view.addSubview(blackline1)
        blackline1.setAnchor(top: drivedlabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0,width: 0,height: 2)
        view.addSubview(coinslabel)
        coinslabel.setAnchor(top: blackline1.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 0)
        view.addSubview(blackline2)
        blackline2.setAnchor(top: coinslabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2)
        view.addSubview(drivedint)
        drivedint.setAnchor(top: blackline.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 20)
        view.addSubview(coinsint)
        coinsint.setAnchor(top: blackline1.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 20)
        
        view.addSubview(orderedint)
        view.addSubview(ordererlabel)
        view.addSubview(blackline3)
        orderedint.setAnchor(top: blackline2.bottomAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 20)
              ordererlabel.setAnchor(top: blackline2.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 0)
         blackline3.setAnchor(top: ordererlabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2)
        
        drivedint.initialize()
        drivedlabel.initialize()
        coinsint.initialize()
        coinslabel.initialize()
        orderedint.initialize()
        ordererlabel.initialize()
        getButton.initialize()
        view.addSubview(getButton)
        getButton.setAnchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 30, paddingRight: 20, width: 20, height: 50)
        getButton.Title(title: "Вывод средств")
        getButton.addTarget(self, action: #selector(getCoins), for: .touchUpInside)
    }
    @objc func getCoins() {
       let alert = CoinAlertViewController()
        
        customPresentViewController(presentr, viewController: alert, animated: true)
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
