//
//  ChatViewController.swift
//  newtaxi
//
//  Created by Чингиз on 29.09.2018.
//  Copyright © 2018 Чингиз. All rights reserved.
//

import UIKit
import JSQMessagesViewController
class ChatViewController: JSQMessagesViewController {
    var messages = [JSQMessage]()
    var chatid : String!
    var name : String!
    var phone : String!
    var receiver : String!
    lazy var outgoingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.outgoingMessagesBubbleImage(with: maincolor)
    }()
    
    lazy var incomingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        let defaults = UserDefaults.standard
        
        if  let id = receiver,
            let name = name
        {
            senderId = id
            senderDisplayName = name
        }
        else
        {
            senderId = phone
            senderDisplayName = name
            
            defaults.set(senderId, forKey: "jsq_id")
            defaults.synchronize()
            
        }
        
        title = "Chat: \(senderDisplayName!)"
        print("senderid")
        print(senderId)

        
        inputToolbar.contentView.leftBarButtonItem = nil
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        // Do any additional setup after loading the view.
        
        let query = Constants.refs.databaseChats.child(chatid!)
        let mquery = query.child("chat")
        let message = ["id":chatid!,"sender":phone]
        query.observe(.value) { (snapshot) in
            if snapshot.childrenCount == 0 {
                query.setValue(message)
            }
        }
        _ = mquery.observe(.childAdded, with: { [weak self] snapshot in
            
            if  let data        = snapshot.value as? [String: String],
                let id          = data["time"],
                let name        = data["from"],
                let text        = data["message"],
                !text.isEmpty
            {
                if let message = JSQMessage(senderId: id, displayName: name, text: text)
                {
                    self?.messages.append(message)
                    
                    self?.finishReceivingMessage()
                }
            }
        })
    }
 
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource!
    {
        
        return messages[indexPath.item].senderDisplayName == senderId ? incomingBubble : outgoingBubble
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource!
    {
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString!
    {
        return messages[indexPath.item].senderId == senderId ? nil : NSAttributedString(string: messages[indexPath.item].senderDisplayName)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat
    {
        return messages[indexPath.item].senderId == senderId ? 0 : 15
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!)
    {
        let ref = Constants.refs.databaseChats.child(chatid!)
        let chat = ref.child("chat")
        let messages = chat.childByAutoId()
        let time = Date().millisecondsSince1970
        print(phone!)
        let message = ["time": String(time), "from": receiver!, "message": text]
        messages.setValue(message)
        finishSendingMessage()
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    
}

