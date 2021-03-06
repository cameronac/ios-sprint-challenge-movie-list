//
//  MovieListViewController.swift
//  Movie List
//
//  Created by Cameron Collins on 3/20/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    
    //Variables
    var movieList: [Movie] = []
    
    //Object| Outlets
    @IBOutlet weak var objectTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        objectTableView.dataSource = self
    }
    
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let myIdentifier = segue.identifier {
            switch(myIdentifier) {
            case "AddMovieSegue":
                guard let myDestination = segue.destination as? AddMovieViewController else {
                    break
                }
                myDestination.previousController = self
                
            case "EditMovieSegue":
                guard let myDestination = segue.destination as? EditMovieViewController else {
                    break
                }
                myDestination.previousController = self
                myDestination.selectedRow = objectTableView.indexPathForSelectedRow?.row
            default:
                break
                
            }
        }
    }
}



//Table View
extension MovieListViewController: UITableViewDataSource {
    
    //Amount of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    //Cell properties
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = objectTableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        
        guard let myCell = cell as? MovieTableViewCell else {
            return cell
        }
        myCell.movie = movieList[indexPath.row]
        return myCell
    }
    
    //Allow editing of rows
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //Row Deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            movieList.remove(at: indexPath.row)
            objectTableView.reloadData()
        }
    }
}
