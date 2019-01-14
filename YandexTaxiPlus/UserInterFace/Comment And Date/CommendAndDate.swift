 //
 //  SettingTableViewController.swift
 //  Taxi+
 //
 //  Created by Чингиз on 16.08.2018.
 //  Copyright © 2018 Чингиз. All rights reserved.
 //
 
 import UIKit
 class SettingTableViewController: UITableViewController,UITextFieldDelegate{
    var datePicker : UIDatePicker = UIDatePicker()
    let addbutton : MainButton = MainButton()
    var typer: String!
    var comment : String?
    var delegate : commentAndDate?
    var menu = [SettingModule(img:"warning", placeholder: "Коментарии или Пожелание")
        ,SettingModule(img: "warning", placeholder: "Дата")]
    var allCellsText = [String]()
    var datestring : CLong?
    var cellid = "cellid"
    
    override func viewDidLoad(){
        super.viewDidLoad()
        UIColourScheme.instance.set(for:self)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = maincolor
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: cellid)
        addbutton.addTarget(self, action: #selector(go), for: .touchUpInside)
        showbutton()
    }
    
    @objc func go() {
            delegate?.getdata(coment: comment ?? "", data: String(datestring ?? 0))
        
            self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menu.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 1:
            textField.inputView = datePicker
        default:
            break
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        switch textField.tag {
        case 0:
            comment = textField.text
        case 1:
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
            datePicker.datePickerMode = .dateAndTime
            self.datestring = datePicker.date.millisecondsSince1970
            textField.text = dateFormatter.string(from: datePicker.date)

        default:
            break
            
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! SettingTableViewCell
            cell.label.tag = indexPath.row
            cell.selectionStyle = .none
            cell.img.image = UIImage(named: menu[indexPath.row].img)
            cell.label.placeholder = menu[indexPath.row].placeholder
            cell.label.delegate = self
        
        return cell
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        allCellsText.append(textField.text!)
        
    }
    func showbutton() {
        view.addSubview(addbutton)
        addbutton.initialize()
        addbutton.translatesAutoresizingMaskIntoConstraints = false
        addbutton.setTitle("Заказать", for: .normal)
        addbutton.setTitleColor(UIColor.white, for: .normal)
        addbutton.setAnchor(top: nil, left: tableView.layoutMarginsGuide.leftAnchor, bottom: tableView.layoutMarginsGuide.bottomAnchor, right: tableView.layoutMarginsGuide.rightAnchor, paddingTop: 100, paddingLeft: 25, paddingBottom: 30, paddingRight: 25, width: 300, height: 50)
        addbutton.translatesAutoresizingMaskIntoConstraints = false
    }
 }
 
 
 
 
 class SettingModule {
    var placeholder:String = ""
    var img:String = ""
    init(img:String,placeholder:String) {
        self.img = img
        self.placeholder = placeholder
    }
 }
 class SettingTableViewCell: UITableViewCell {
    let img = UIImageView()
    let label = UITextField()
    let UiView = UITableViewCell()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    func setView() {
        self.addSubview(UiView)
        UiView.addSubview(label)
        UiView.addSubview(img)
        
        let centerY = img.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let centerYLabel = label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        UiView.setAnchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        label.setAnchor(top: self.topAnchor, left: img.rightAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 0,width: self.frame.width,height: self.frame.height)
        img.setAnchor(top: nil, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0,width: 24,height: 24)
        NSLayoutConstraint.activate([centerY,centerYLabel])
    }
    
 }
 
 extension Date {
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
 }
