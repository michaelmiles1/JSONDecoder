//
//  PokemonTableViewController.swift
//  JSONDecoder
//
//  Created by Michael Miles on 11/5/19.
//  Copyright © 2019 Michael Miles. All rights reserved.
//

import UIKit

//SET UP STRUCT (USE http://app.quicktype.io/ if needed)
struct Pokemon: Codable {
    let name: String
    let types: [TypeElement]
}
struct TypeElement: Codable {
    let type: Type
}
struct Type: Codable {
    let name: String
}

class PokemonTableViewController: UITableViewController {
    
    var pokemonArray = [Pokemon]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath)

        //CONFIGURE CELL WITH DECODED DATA
        getPokemon(withID: indexPath.row + 1)
        
        let poke = pokemonArray[indexPath.row]

        return cell
    }
    
    // MARK: Networking
    
    private func getPokemon(withID id: Int) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)") else {
            fatalError("URL guard stmt failed")
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //HANDLE DECODING HERE
            if let data = data {
                guard let pokemon = try? JSONDecoder().decode(Pokemon.self, from: data) else {
                    fatalError("Error decoding data")
                }
                self?.pokemonArray.append(pokemon)
            }
        }.resume()
    }

}
