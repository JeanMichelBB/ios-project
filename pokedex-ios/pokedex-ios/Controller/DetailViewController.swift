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
    
    @IBOutlet weak var lblColor: UILabel!
    
    @IBOutlet weak var lblGeneration: UILabel!
    
    @IBOutlet weak var lblHabitat: UILabel!
    
    @IBOutlet weak var lblShape: UILabel!
    
    @IBOutlet weak var lblType2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Network().getPokemonDetail(name: selectedPokemon!.name, completionHandler: { [weak self] (detail) in
            self!.lblColor.text = detail.color.name.capitalized
            if let flavorText = detail.flavorTextEntries.first(where: {$0.language.name == "en"})?.flavorText {
                self!.lblDescription.text = flavorText
            }
            self!.lblGeneration.text = detail.generation.name.capitalized
            self!.lblHabitat.text = detail.habitat.name.capitalized
            self!.lblShape.text = detail.shape.name.capitalized
            let detailImageUrl = self!.selectedPokemon!.sprites.other.officialArtwork.frontDefault
            let url = URL(string: detailImageUrl)!
            self!.lblName.text = self!.selectedPokemon!.name.capitalized
            self!.lblNumber.text = "#\(self!.selectedPokemon!.id)"
            
            self!.lblType.text = self!.selectedPokemon!.types[0].type.name.capitalized
            
            if self!.selectedPokemon!.types.count > 1 {
                self!.lblType2.text = self!.selectedPokemon!.types[1].type.name.capitalized
            } else {
                self!.lblType2.isHidden = true
            }
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    self!.imgPokemon.image = UIImage(data: data)
                }
            }.resume()
        })       
    }
    
    
    
    
}
