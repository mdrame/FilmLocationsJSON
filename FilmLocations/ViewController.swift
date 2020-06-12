//
//  ViewController.swift
//  FilmLocations
//
//  Created by MO on 6/11/20.
//  Copyright © 2020 MO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // ----- Instance ------------------//
    
    var films: [FilmEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromfile("locations")
    }
    
    // ------- Get data from file ---- //
    func getDataFromfile(_ fileName: String) {
        let path = Bundle.main.path(forResource: fileName, ofType: ".json")
        guard let filePath = path else {
            print("File not found")
            return }
        let url = URL(fileURLWithPath: filePath)
        print(url)
        
        let conetent = try? Data(contentsOf: url)
        do {
            if let data = conetent, let jsonResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String:Any]] {
            print(jsonResult)
                for film in jsonResult {
                    let firstActor = film["actor_1"] as? String ?? ""
                    let locations = film["locations"] as? String ?? ""
                    let releaseYear = film["release_year"] as? String ?? ""
                    let title = film["title"] as? String ?? ""
                    let movie = FilmEntry(firstActor: firstActor, locations: locations, releaseYear: releaseYear, title: title)
                }
            }
        } catch {
            print("Error descerializing JSON: \(error)")
        }
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
}

