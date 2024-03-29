//
//  AvatarVC.swift
//  movie_avatar_app
//
//  Created by David Kumar on 3/18/21.
//  Copyright © 2021 David Kumar. All rights reserved.
//

import UIKit

class AvatarVC: UIViewController{
    
    var network = NetworkCall()
    
    var avatars : [Avatar] = []
    
    let listVC = AvatarListVC()
    
    var rowNumber: Int = 0 // must init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatars = listVC.fetch()
    
        print(rowNumber)
        
        network.getData(id: avatars[rowNumber].id)
                
        NotificationCenter.default.addObserver(self, selector: #selector(notificationReceivedFromAPI(notification:)), name: NSNotification.Name(rawValue: "fromAPI"), object: nil)
        

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(popVC(sender:)))
        
        self.navigationItem.leftBarButtonItem?.tintColor = .black
                
        view.backgroundColor = UIColor(red: 193/255.0, green: 225/255.0, blue: 236/255.0, alpha: 1.0)
        
        view.addSubview(imageView)
        imageConstraints()
        
        view.addSubview(label)
        labelConstraints()

    }
    
    @objc func notificationReceivedFromAPI(notification: Notification) {
        let data = notification.object as! String

        DispatchQueue.main.async {
            self.setLabelText(text: data)// UI changes only on main thread
        }
       
    }

    @objc func popVC(sender: UIBarButtonItem){
        
        navigationController?.popViewController(animated: true)
    }
    
    let imageView: UIImageView = {
        
        let image = UIImageView()
        return image
        
    }() // the result of closure goes into the imageView
    
    let label : UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0 // word-wrap
        label.textAlignment = .center
        label.sizeToFit()
        
        return label
        
    }()
    
    func setLabelText(text: String){
        
        label.text = text
    }
    
    func imageConstraints(){
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 180).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -115).isActive = true 
        
        imageView.layer.masksToBounds = true // sublayer clipped to layer's bounds
        imageView.layer.cornerRadius = 15
        
    }
    
    func labelConstraints(){
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let marginsGuide = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
        label.topAnchor.constraint(equalTo: marginsGuide.topAnchor, constant: 375),
        label.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor),
        label.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor)
        ])
 

    }
    
}
