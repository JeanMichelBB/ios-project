//
//  TableViewController.swift
//  pokedex-ios
//
//  Created by Jean-Michel Beaulieu Bérubé on 2023-04-02.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private var pokemons : [Pokemon] = []
    private var pokemonInitialResponse : [PokemonListItem] = []
    private var selectedPokemon : Pokemon?
    
    private var currentPage = 0
    private var totalPokemonCount = 150
    private let pageSize = 10
    private var isLoading = false
    
    public var loggedUser : User?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var txtLoggedUser: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtLoggedUser.text = "Welcome \(loggedUser?.username ?? "")!"
        
        tableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "PokemonTableViewCell")
                
        tableView.delegate = self
        tableView.dataSource = self
        
        self.loadData()
    }
    
    @IBAction func btnReloadTapped(_ sender: Any) {
        tableView.reloadData()
    }
    
    func loadData() {
        self.isLoading = true
        
        let offset = self.pokemonInitialResponse.count
        let page = (offset / self.pageSize) + 1
        
        if offset < self.totalPokemonCount {
            Network().getPokemonList(offset: offset, limit: self.pageSize) { [weak self] (result) in
                
                switch result {
                case .failure(let error):
                    
                    print("Error loading the pokemon list: \(error.localizedDescription)")
                    self?.isLoading = false
                    
                case .success(let pokemonList):
                    self?.currentPage = page
                    
                    self?.pokemonInitialResponse.append(contentsOf: pokemonList)
                    
                    self?.loadPokemonDetails(pokemonList: pokemonList)
                    
                    self?.isLoading = false
                }
            }
        } else {
            self.isLoading = false
        }
    }
    
    func loadPokemonDetails(pokemonList : [PokemonListItem]) -> Void {
        for element in pokemonList {
            
            Network().getPokemon(name: element.name, completionHandler: { [weak self] (result) in
                switch result {
                case .success(let pokemon):
                    self!.pokemons.append(pokemon)
                    self!.pokemons.sort { $0.id < $1.id }
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    print("Error loading pokemon information: \(error.localizedDescription) ")
                }
            })
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !self.isLoading {
                self.loadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = self.tableView.dequeueReusableCell(withIdentifier: "PokemonTableViewCell", for: indexPath) as! PokemonTableViewCell
        
        customCell.setCellContent(pokemon: pokemons[indexPath.row])
        return customCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedPokemon = self.pokemons[indexPath.row]
        
        self.performSegue(withIdentifier: Segue.toDetailViewController, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.toDetailViewController {
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.selectedPokemon = self.selectedPokemon
        }
    }
}
