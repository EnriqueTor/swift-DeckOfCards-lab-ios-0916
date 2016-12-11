//
//  Deck.swift
//  DeckOfCards
//
//  Created by Enrique Torrendell on 11/8/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import Foundation

class Deck {
    
    var success: Bool!
    var deckID: String!
    var shuffled: Bool!
    var remaining: Int!
    var cards: [Card] = []
    
    
    let apiClient = CardAPIClient.shared
    
    func newDeck(_ completion: @escaping (Bool) -> Void) {
        
        apiClient.newDeckShuffled(numDecks: 1) { (dict) in
            
            self.success = dict["success"] as? Bool
            self.deckID = dict["deck_id"] as? String
            self.shuffled = dict["shuffled"] as? Bool
            self.remaining = dict["remaining"] as? Int
            
            completion(true)
        }
    }
    
    func drawCards(numberOfCards: Int, completion: @escaping (Bool, [Card]?) -> Void) {
        
        guard let unwrappedRemaining = remaining else { fatalError("Remaining cards is nil") }
        
        if numberOfCards <= unwrappedRemaining {
            
            guard let unwrappedDeckId = deckID else { fatalError("Deck ID is nil") }
            
            apiClient.drawCards(deckId: unwrappedDeckId, numCards: numberOfCards, completion: { (dict) in
                
                for item in dict["cards"] as! [[String: Any]] {
                    
                    self.cards.append(Card(dictionary: item))
                    
                }
                
                self.remaining = dict["remaining"] as? Int
                
                completion(true, self.cards)
            })
        }
    }
    
}













