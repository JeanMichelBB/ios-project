//
//  TableViewController.swift
//  pokedex-ios
//
//  Created by Jean-Michel Beaulieu Bérubé on 2023-04-02.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private var pokemonList : [Pokemon] = []
    private var pokemonInitialResponse : [PokemonListItem] = []
    public var loggedUser : User?
    private var selectedPokemon : Pokemon?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtLoggedUser: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtLoggedUser.text = "Welcome \(loggedUser?.username ?? "")!"
        
        tableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "PokemonTableViewCell")
        
        Network().getPokemonList() { [weak self] (pokemons) in
            self?.pokemonInitialResponse = pokemons.results
            self?.loadPokemonDetails(pokemonList: pokemons.results)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func loadPokemonDetails(pokemonList : [PokemonListItem]) -> Void {
        for element in self.pokemonInitialResponse {
            Network().getPokemon(name: element.name, completionHandler: { [weak self] (pokemon) in
                self!.pokemonList.append(pokemon)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            })
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = self.tableView.dequeueReusableCell(withIdentifier: "PokemonTableViewCell", for: indexPath) as! PokemonTableViewCell
        
        customCell.setCellContent(pokemon: pokemonList[indexPath.row])
        return customCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected pokemon: \(pokemonList[indexPath.row].name)")
        self.selectedPokemon = pokemonList[indexPath.row]
        self.performSegue(withIdentifier: Segue.toDetailViewController, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.toDetailViewController {
            let detailViewController = segue.destination as! DetailViewController
            
            detailViewController.selectedPokemon = self.selectedPokemon
        }
    }
      
    // TODO: Add scrollViewDidScroll to load more data when the user scrolls
}
