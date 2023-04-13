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
    
    @IBOutlet weak var imgPokemonBackground: UIImageView!
    
    @IBOutlet weak var imgTextBackground: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgTextBackground.layer.cornerRadius = 50
        
        Network().getPokemonDetail(name: selectedPokemon!.name) { [weak self] detail in
            DispatchQueue.main.async {
                self?.configureDetailView(with: detail)
            }
            self?.loadPokemonImage(from: self!.selectedPokemon!.sprites.other.officialArtwork.frontDefault)
        }
    }

    func configureDetailView(with detail: PokemonDetail) {
        let color = detail.color.name
        imgPokemonBackground.backgroundColor = Helpers.getBackgroundColor(label: color)
        lblColor.text = color.capitalized
        if let flavorText = detail.flavorTextEntries.first(where: { $0.language.name == "en" })?.flavorText {
            lblDescription.text = removeNewlines(from: flavorText)
            print("item: \(removeNewlines(from: flavorText))")
        }
        lblGeneration.text = detail.generation.name.capitalized
        lblHabitat.text = detail.habitat.name.capitalized
        lblShape.text = detail.shape.name.capitalized
        lblName.text = selectedPokemon!.name.capitalized
        lblNumber.text = "#\(selectedPokemon!.id)"
        let type1 = selectedPokemon!.types[0].type.name
        lblType.text = type1.capitalized
        lblType.backgroundColor = Helpers.getLabelColor(label: type1)
        lblType.layer.masksToBounds = true
        lblType.layer.cornerRadius = 5
        lblType.text = type1.uppercased()
        if selectedPokemon!.types.count > 1 {
            let type2 = selectedPokemon!.types[1].type.name
            lblType2.isHidden = false
            lblType2.text = type2.uppercased()
            lblType2.layer.masksToBounds = true
            lblType2.layer.cornerRadius = 5
            lblType2.text = type2.uppercased()
            lblType2.backgroundColor = Helpers.getLabelColor(label: type2)
        } else {
            lblType2.isHidden = true
        }
    }

    func loadPokemonImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.imgPokemon.image = UIImage(data: data)
            }
        }.resume()
    }

    func removeNewlines(from inputString: String) -> String {
        let cleanedString = inputString.replacingOccurrences(of: "\n", with: " ")
        return cleanedString.replacingOccurrences(of: "\u{0C}", with: " ")
    }

    
}
