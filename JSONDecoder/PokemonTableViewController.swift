//
//  PokemonTableViewController.swift
//  JSONDecoder
//
//  Created by Michael Miles on 11/5/19.
//  Copyright © 2019 Michael Miles. All rights reserved.
//

import UIKit

//SET UP STRUCT (USE http://app.quicktype.io/ if needed)

class PokemonTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath)

        //CONFIGURE CELL WITH DECODED DATA

        return cell
    }
    
    // MARK: Networking
    
    private func getPokemon(withID id: Int) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)") else {
            fatalError("URL guard stmt failed")
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //HANDLE DECODING HERE
        }.resume()
    }

}
