import UIKit
import Neon
import Alamofire
import SwiftyJSON
class MainPageHeader:UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        subview()
        setup()
        setuplayout()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    let searchBar : UIImageView = UIImageView()
    let bannerImageView : UIImageView = UIImageView()
    let bannerMaskView : UIView = UIView()
    let nameLabel : UILabel = UILabel()
    let phone : UILabel = UILabel()
    var avatarImageView : UIImageView = UIImageView()
    
    let buttonContainerView2 : UIView = UIView()
    
  
    func setup()
    {
        nameLabel.textColor = UIColor.white
        nameLabel.numberOfLines = 1
        nameLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        phone.textColor = UIColor.white
        phone.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        phone.textAlignment = .left
        
    }
    
    
    func subview()
    {
        
        
        self.addSubview(nameLabel)
        self.addSubview(phone)
        self.addSubview(avatarImageView)
        self.backgroundColor = maincolor
        avatarImageView.image = UIImage(named: "zhan")
        avatarImageView.layer.cornerRadius = 35.0
        avatarImageView.clipsToBounds = true
        avatarImageView.contentMode = .scaleAspectFill
        
     
      
    }
    
    func setuplayout ()
    {
        
        let isLandscape : Bool = UIDevice.current.orientation.isLandscape
        let avatarHeightMultipler : CGFloat = isLandscape ? 0.75 : 0.43
      
        let avatarSize = self.height * avatarHeightMultipler * 0.94
        //        avatarImageView.anchorInCorner(.bottomLeft, xPad: 120, yPad: 90, width: avatarSize, height: avatarSize)
        
        let centerX = nameLabel.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor)
        let centerXph = phone.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor)
        let centerXphoto = avatarImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        nameLabel.setAnchor(top: avatarImageView.bottomAnchor ,left: nil, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 0, paddingBottom:0, paddingRight: 0)
        NSLayoutConstraint.activate([centerX,centerXph,centerXphoto])
        phone.setAnchor(top: nameLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        avatarImageView.setAnchor(top: self.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: avatarSize, height: avatarSize)
    }
    
}

class MenuModule {
    var menu : String!
    var img: String!
    init(menu:String,img:String) {
        self.menu = menu
        self.img = img
    }
}
class MainPageMenuCell: UITableViewCell {
    let img = UIImageView()
    let label = MainLabel()
    let view = UIView()
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
        self.addSubview(view)
        view.addSubview(label)
        label.initialize()
        view.addSubview(img)
        img.contentMode = .scaleAspectFit
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = maincolor
        label.text = "che tam"
        img.tintColor = maincolor
        img.image?.maskWithColor(color: maincolor)
        GetAvatar.get { (url) in
            Alamofire.request(url).responseJSON(completionHandler: { (response) in
                self.img.image = UIImage.init(data: response.data!)
            })
        }
        let centerY = img.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let centerYLabel = label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        label.setAnchor(top: self.topAnchor, left: img.rightAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 0)
        img.setAnchor(top: nil, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 30, paddingBottom: 0, paddingRight: 0,width: 30,height: 30)
        NSLayoutConstraint.activate([centerY,centerYLabel])
        self.backgroundColor = UIColor.clear
    }
    
}
