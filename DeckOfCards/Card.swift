//
//  Card.swift
//  DeckOfCards
//
//  Created by Enrique Torrendell on 11/13/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import Foundation
import UIKit

class Card {
    
    let imageURLString: String
    let url: URL?
    let code: String
    var image: UIImage?
    let value: String
    let suit: String
    let apiClient = CardAPIClient.shared
    var isDownloading = false
    
    init(dictionary: [String:Any]) {
        
        self.imageURLString = dictionary["image"] as! String
        self.value = dictionary["value"] as! String
        self.suit = dictionary["suit"] as! String
        self.code = dictionary["code"] as! String
        self.url = URL(string: imageURLString)
        
    }
    
    func downloadImage(handler: @escaping (Bool) -> Void) {
        
        if let url = url {
            
            apiClient.downloadImage(at: url) { (success, image) in
                
                DispatchQueue.main.async {
                    
                    self.image = image
                    
                    handler(true)
                }
                
            }
        }
    }
}

