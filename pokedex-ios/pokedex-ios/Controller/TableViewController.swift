//
//  TableViewController.swift
//  pokedex-ios
//
//  Created by Jean-Michel Beaulieu Bérubé on 2023-04-02.
//

import UIKit

class TableViewController: ViewController {

    private var pokemonList : [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getPokemons()
        // Do any additional setup after loading the view.
    }
    
    func getPokemons() {
        Network().getPokemonList() { [weak self] (pokemons) in
            for (index, item) in pokemons.results.enumerated() {
                Network().getPokemon(name: item.name, completionHandler: {(pokemon) in
                    self!.pokemonList.append(pokemon)
                    print("Item \(index) : \(pokemon)")
                })
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
