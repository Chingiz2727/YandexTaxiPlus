//
//  CustomSegmentedControl.swif
//
//
//  Created by Bruno Faganello on 05/07/18.
//  Copyright © 2018 Code With Coffe . All rights reserved.
//

import UIKit
protocol CustomSegmentedControlDelegate:class {
    func changeToIndex(index:Int)
}

class CustomSegmentedControl: UIView {
    private var buttonTitles:[String]!
    var buttons: [UIButton]!
    private var selectorView: UIView!
    var textColor:UIColor = .black
    var selectorViewColor: UIColor = .red
    var selectorTextColor: UIColor = .white
    let label1 = UILabel()
    let label2 = UILabel()
    
    weak var delegate:CustomSegmentedControlDelegate?
    
    public private(set) var selectedIndex : Int = 0
    
    convenience init(frame:CGRect,buttonTitle:[String]) {
        self.init(frame: frame)
        self.buttonTitles = buttonTitle
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor = UIColor.white
        updateView()
    }
    
    func setButtonTitles(buttonTitles:[String]) {
        self.buttonTitles = buttonTitles
        self.updateView()
    }
    
    func setIndex(index:Int) {
        buttons.forEach({ $0.setTitleColor(textColor, for: .normal) })
        let button = buttons[index]
        selectedIndex = index
        button.setTitleColor(selectorTextColor, for: .normal)
        let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(index)
        UIView.animate(withDuration: 0.2) {
            self.selectorView.frame.origin.x = selectorPosition
        }
    }
    func addlabel() {
        addSubview(label1)
        addSubview(label2)
        label1.setAnchor(top: nil, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 25, height: 25)
        label2.backgroundColor = UIColor.red
        label1.backgroundColor = UIColor.red
        label2.setAnchor(top: nil, left: nil, bottom: nil, right: self.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 25, height: 25)
        label1.layer.cornerRadius = label1.frame.width/2
        label2.layer.cornerRadius = label2.frame.width/2
        label2.textColor = UIColor.white
        label2.textAlignment = .center
        label1.font = UIFont.systemFont(ofSize: 10)
        label2.font = UIFont.systemFont(ofSize: 10)
        
        label1.textAlignment = .center
        label1.textColor = UIColor.white
        label2.layer.masksToBounds = true
        label1.layer.masksToBounds = true
        let l1y = label1.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let l2y = label2.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        NSLayoutConstraint.activate([l1y,l2y])
    }
    @objc func buttonAction(sender:UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            if btn == sender {
                let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(buttonIndex)
                selectedIndex = buttonIndex
                delegate?.changeToIndex(index: selectedIndex)
                UIView.animate(withDuration: 0.3) {
                    self.selectorView.frame.origin.x = selectorPosition
                }
                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
    }
}

//Configuration View
extension CustomSegmentedControl {
    private func updateView() {
        createButton()
        configSelectorView()
        configStackView()
        addlabel()

    }
    
    private func configStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
     
        
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        addSubview(stack)
        
        stack.setAnchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
       
    }
    
    private func configSelectorView() {
        let selectorWidth = frame.width / CGFloat(self.buttonTitles.count)
        selectorView = UIView(frame: CGRect(x: 0, y: self.frame.height, width: selectorWidth, height: 2))
        selectorView.backgroundColor = selectorViewColor
        addSubview(selectorView)
    }
    
    private func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
    
        
        subviews.forEach({$0.removeFromSuperview()})
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.titleLabel?.font = UIFont(name: "Arial", size: 12)
            button.setTitle(buttonTitle, for: .normal)
            button.addTarget(self, action:#selector(CustomSegmentedControl.buttonAction(sender:)), for: .touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            button.backgroundColor = maincolor
            
            buttons.append(button)
        }
   
        
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
    }
    
    
}
