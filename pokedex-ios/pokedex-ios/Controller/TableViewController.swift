//
//  TableViewController.swift
//  pokedex-ios
//
//  Created by Jean-Michel Beaulieu Bérubé on 2023-04-02.
//

import UIKit

class TableViewController: ViewController {

    private var pokemons : Pokemon?

    override func viewDidLoad() {
        super.viewDidLoad()
        

        Network().getPokemon(name: "bulbasaur") { [weak self] (pokemons) in
            self?.pokemons = pokemons
            DispatchQueue.main.async {
                print(pokemons)
            }
        }
        // Do any additional setup after loading the view.
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
