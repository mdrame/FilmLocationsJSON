//
//  ViewController.swift
//  FilmLocations
//
//  Created by MO on 6/11/20.
//  Copyright © 2020 MO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromfile("locations")
        tableViewSetUp()
        
    }
    
    // MARK: View Setups
    
    /// This function sets tableview delegate, datasource and add tableview to view
    func tableViewSetUp() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        view.addSubview(mainTableView)
        mainTableViewConstrain()
    }
    
    // MARK: Instance
    
    var films: [FilmEntry] = []
    
    
    // MARK: Get data from file
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
                    //                    print(movie.title)
                    films.append(movie)
                }
            }
        } catch {
            print("Error descerializing JSON: \(error)")
        }
        
    }
    
    
    // MARK: TableView
    
    lazy var mainTableView: UITableView = {
        let mainTableView = UITableView(frame: .zero)
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return mainTableView
    }()
    
    func mainTableViewConstrain() {
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: view.topAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = films[indexPath.row].title
        return cell
    }
    
    
}

