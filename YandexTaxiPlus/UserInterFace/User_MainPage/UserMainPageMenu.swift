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
    var starsAvatar : UIImageView = UIImageView()
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
        self.addSubview(starsAvatar)

        self.backgroundColor = maincolor
        avatarImageView.image = UIImage(named: "userjpg")
        starsAvatar.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 45
        avatarImageView.clipsToBounds = true
        starsAvatar.contentMode = .scaleAspectFit
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.backgroundColor = UIColor.gray
     
      
    }
    
    func setuplayout ()
    {
        
        let isLandscape : Bool = UIDevice.current.orientation.isLandscape
      
        //        avatarImageView.anchorInCorner(.bottomLeft, xPad: 120, yPad: 90, width: avatarSize, height: avatarSize)
        
        let centerX = nameLabel.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor)
        let centerXph = phone.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor)
        let centerXphoto = avatarImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let centerXphotor = starsAvatar.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let centeyphoto = starsAvatar.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
        nameLabel.setAnchor(top: avatarImageView.bottomAnchor ,left: nil, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 0, paddingBottom:0, paddingRight: 0)
        NSLayoutConstraint.activate([centerX,centerXph,centerXphoto,centerXphotor,centeyphoto])
        phone.setAnchor(top: nameLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        avatarImageView.setAnchor(top: self.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 90, height: 90)
         starsAvatar.setAnchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 115, height: 115)
    }
    
    
    
    
    
    
}

class MenuModule {
    var menu : String!
    var img: String!
    var id : String!
    var contains : Bool!
    init(menu:String,img:String,id:String,contains:Bool) {
        self.menu = menu
        self.img = img
        self.menu = menu
        self.contains = contains
    }
}
class MainPageMenuCell: UITableViewCell {
    let img = UIImageView()
    let countlabel = UILabel()
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
        view.addSubview(countlabel)
        label.initialize()
        view.addSubview(img)
        img.contentMode = .scaleAspectFit
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = maincolor
        label.text = "che tam"
        img.tintColor = maincolor
        img.image?.maskWithColor(color: maincolor)
     
        let centerY = img.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let centerYLabel = label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let centerround = countlabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        label.setAnchor(top: self.topAnchor, left: img.rightAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 0)
        img.setAnchor(top: nil, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 30, paddingBottom: 0, paddingRight: 0,width: 30,height: 30)
        countlabel.setAnchor(top: nil, left: nil, bottom: nil, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width: 30, height: 30)
        countlabel.layer.cornerRadius = 15
        countlabel.font = UIFont.systemFont(ofSize: 13)
        countlabel.textAlignment = .center
        countlabel.backgroundColor = UIColor.clear
        countlabel.layer.masksToBounds = true
        countlabel.textColor = UIColor.white
        NSLayoutConstraint.activate([centerY,centerYLabel,centerround])
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
    }
    
 
    
}
