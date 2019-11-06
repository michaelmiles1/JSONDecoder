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
    var loading = true
    var pokemonCount = 10

    override func viewDidLoad() {
        super.viewDidLoad()

        for i in stride(from: 1, to: pokemonCount + 1, by: 1) {
            getPokemon(withID: i)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if loading {
            return 1
        } else {
            return pokemonArray.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath)
        
        if loading {
            cell.textLabel?.text = "Loading..."
        } else {
            let poke = pokemonArray[indexPath.row]
            cell.textLabel?.text = poke.name
//            cell.detailTextLabel?.text = poke.types.map {($0 as? String) ?? "No type available"}.compactMap({$0}).joined(separator: ",")
        }

        return cell
    }
    
    // MARK: Networking
    
    private func getPokemon(withID id: Int) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)") else {
            fatalError("URL guard stmt failed")
        }
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            //HANDLE DECODING HERE
            if let data = data {
                guard let pokemon = try? JSONDecoder().decode(Pokemon.self, from: data) else {
                    fatalError("Error decoding data")
                }
                self?.pokemonArray.append(pokemon)
            }
            self?.loading = false
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }.resume()
    }

}
