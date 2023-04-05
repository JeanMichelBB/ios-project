//
//  DetailViewController.swift
//  pokedex-ios
//
//  Created by Jean-Michel Beaulieu Bérubé on 2023-04-02.
//

import UIKit

class DetailViewController: ViewController {
    
    //public var pokePokemon : API?
    //public var pokeName : API?
    //public var pokeNumber : API?
    //public var pokeType : API?
    //public var pokeDescription : API?

    @IBOutlet weak var imgPokemon: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
        
    @IBOutlet weak var lblNumber: UILabel!
    
    @IBOutlet weak var lblType: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //imgPokemon.image = pokePokemon!.image
        //lblName.text = " \(pokeName!.name)"
        //lblNumber.text = " \(pokeNumber!.name)"
        //lblType.text = " \(pokeType!.name)"
        //lblDescription.text = " \(pokeDescription!.name)"

    }
}
