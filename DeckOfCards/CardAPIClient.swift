//
//  CardAPIClient.swift
//  DeckOfCards
//
//  Created by Enrique Torrendell on 11/8/16.
//  Copyright © 2016 Gamesmith, LLC. All rights reserved.
//

import Foundation
import UIKit

struct CardAPIClient {
    
    var deckID = ""
    static let shared = CardAPIClient()
    
    func newDeckShuffled(numDecks: Int, completion: @escaping ([String: Any]) -> Void) {
        
        let urlString = "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=\(numDecks)"
        
        let url = URL(string: urlString)
        
        guard let unwrappedURL = url else { return }
        
        var request = URLRequest(url: unwrappedURL)
        
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
        
            guard let unwrappedData = data else { fatalError("Error trying to unwrap response data") }
            
            do {
            
                let JSON = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as! [String:Any]
                
                completion(JSON)
                
            }
            
            catch let error {
            
                print("Error during JSON serialization \(error.localizedDescription)")
                
            }
            
        }
        
        task.resume()
        
    }
    
    func drawCards(deckId: String, numCards: Int, completion: @escaping ([String: Any]) -> Void) {
        
        let urlString = "https://deckofcardsapi.com/api/deck/\(deckId)/draw/?count=\(numCards)"
        
        let url = URL(string: urlString)
        
        guard let unwrappedURL = url else { return }
        
        var request = URLRequest(url: unwrappedURL)
        
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
                let task = session.dataTask(with: request) { (data, response, error) in
        
                    guard let unwrappedData = data else { fatalError("Error trying to unwrap response data") }
                    
                    do {
                    
                        let JSON = try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as! [String: Any]
                        
                        completion(JSON)
                    
                    }
                    
                    catch let error {
                        print("Error during JSON serialization \(error.localizedDescription)")
                    
                    }
                }
                task.resume()
            }
    
    func downloadImage(at url: URL, handler completion: @escaping (Bool, UIImage?) -> Void ) {
        
        let configuration = URLSessionConfiguration.default
        
        let session = URLSession(configuration: configuration)
        
        let task = session.dataTask(with: url) { data, response, error in
            
            guard let imageData = try? Data(contentsOf: url) else { fatalError() }
        
            OperationQueue.main.addOperation {
            
                let image = UIImage(data: imageData)
                
                completion(true,image)
            }
        }
        task.resume()
    }

}






















