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
    var token : String!
    let incomingBubble = JSQMessagesBubbleImageFactory()?.incomingMessagesBubbleImage(with: UIColor.lightGray)
    let outgoingBubble = JSQMessagesBubbleImageFactory()?.outgoingMessagesBubbleImage(with: maincolor)
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = maincolor
        let defaults = UserDefaults.standard
        print(name)
        print(phone)
        print(receiver)
        print(chatid)
        if  let id = receiver,
            let name = name
        {
            senderId = id
            senderDisplayName = name
        }
        else
        {
            senderId = receiver
            senderDisplayName = name
            
            defaults.set(senderId, forKey: "jsq_id")
            defaults.synchronize()
            
        }
        
        title = "Chat: \(senderDisplayName!)"
        

        
        let query = Constants.refs.databaseChats.child(chatid!)
        let mquery = query.child("chat")
        let message = ["id":senderId!,"sender":phone]
        
        query.observe(.value) { (snapshot) in
            if snapshot.childrenCount == 0 {
                query.setValue(message)
            }
        }
        _ = mquery.observe(.childAdded, with: { [weak self] snapshot in
            
            if  let data        = snapshot.value as? [String: String],
                let id          = data["from"],
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
        self.collectionView.collectionViewLayout.messageBubbleLeftRightMargin = 5
        
        self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        
    }
    override func didPressAccessoryButton(_ sender: UIButton!) {
        sender.isHidden = true
        sender.isEnabled = false
    }
 
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource!
    {
        
        let message = messages[indexPath.row]
        if receiver == message.senderId {
            return outgoingBubble
        }
        else {
            return incomingBubble
        }
        
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
        return 15
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!)
    {
        
        let ref = Constants.refs.databaseChats.child(chatid!)
        let chat = ref.child("chat")
        let messages = chat.childByAutoId()
        let time = Date().millisecondsSince1970
        let message = ["time": String(time), "from": receiver!, "message": text]
        messages.setValue(message)
        SendChat.send(token: phone, message: text)
        finishSendingMessage()
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    
}

