//
//  ViewController.swift
//  DeckOfCards
//
//  Created by Jim Campagno on 11/3/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var deck = Deck()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        deck.newDeck { (success) in
            
            if success {
                
                print("Deck shuffled")
                
            } else {
                
                print("error")
            }
        }
    }
    
    func display(card: Card) {
        
        
        let viewHeight = self.view.frame.size.height
        let cardViewHeight = viewHeight * 0.2
        let percentage: CGFloat = 226 / 314
        let cardViewWidth = cardViewHeight * percentage
        
        let minX = 0 + (cardViewWidth / 2)
        let maxX = self.view.frame.size.width - (cardViewWidth)
        let minY = 0 + (cardViewHeight / 2)
        let maxY = self.view.frame.size.height - (cardViewHeight)
        
        let randomX = CGFloat(arc4random_uniform(UInt32(maxX - minX))) + minX
        let randomY = CGFloat(arc4random_uniform(UInt32(maxY - minY))) + minY
        
        let cardView = CardView(frame: CGRect(x: randomX, y: randomY, width: cardViewWidth, height: cardViewHeight))
        self.view.addSubview(cardView)
        
        cardView.card = card
    }
    
    @IBAction func drawCard(_ sender: Any) {
        
        deck.drawCards(numberOfCards: 1) { (success, cardArray) in
            
            if success {
            
                if let unwrappedCards = cardArray {
                
                    DispatchQueue.main.async {
                    
                        self.display(card: unwrappedCards[unwrappedCards.count - 1])
                    }
                }
            }
        }
    }
}
