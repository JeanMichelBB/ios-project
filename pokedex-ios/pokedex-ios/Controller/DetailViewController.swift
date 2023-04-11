//
//  DetailViewController.swift
//  pokedex-ios
//
//  Created by Jean-Michel Beaulieu Bérubé on 2023-04-02.
//

import UIKit

class DetailViewController: ViewController {

    public var selectedPokemon: Pokemon?
    
    @IBOutlet weak var imgPokemon: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
        
    @IBOutlet weak var lblNumber: UILabel!
    
    @IBOutlet weak var lblType: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        Network().getPokemonDetail(name: "bulbasaur", completionHandler: { [weak self] (detail) in
                
            print("Item: \(detail.
            print("Item: \(detail.flavorTextEntries[0].flavorText)")
            //print("Item: \(detail
            //print("Item: \(detail
            //print("Item: \(detail

        })
    }
    
    
    
    
}
