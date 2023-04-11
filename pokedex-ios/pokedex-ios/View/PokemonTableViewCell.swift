//
//  PokemonTableViewCell.swift
//  pokedex-ios
//
//  Created by Jean-Michel Beaulieu Bérubé on 2023-04-04.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imgPokemon: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblType1: UILabel!
    
    @IBOutlet weak var lblType2: UILabel!
    
    @IBOutlet weak var lblNumber: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCellContent(pokemon : Pokemon) {
        lblName.text = pokemon.name.capitalized
        lblNumber.text = "#\(pokemon.id)"
        
        let type1 : String = pokemon.types[0].type.name
        lblType1.text = type1.uppercased()
        lblType1.backgroundColor = getLabelColor(label: type1)
        lblType1.layer.masksToBounds = true
        lblType1.layer.cornerRadius = 5
        
        if pokemon.types.count > 1 {
            let type2 : String = pokemon.types[1].type.name
            lblType2.isHidden = false
            lblType2.text = type2.uppercased()
            lblType2.layer.masksToBounds = true
            lblType2.layer.cornerRadius = 5
            lblType2.backgroundColor = getLabelColor(label: type2)
        } else {
            lblType2.isHidden = true
        }
        
        // TODO: Put this into a function (how not to show images in the wrong pokemons?)
        let frontDefaultImageUrl = pokemon.sprites.frontDefaultMini
        let url = URL(string: frontDefaultImageUrl)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.imgPokemon.image = UIImage(data: data)
            }
        }.resume()
    }
    
    func getLabelColor(label : String) -> UIColor {
        switch label {
            case "normal":
                return UIColor(red: 0.78, green: 0.78, blue: 0.60, alpha: 1.00)
            case "fighting":
                return UIColor(red: 0.78, green: 0.44, blue: 0.44, alpha: 1.00)
            case "flying":
                return UIColor(red: 0.60, green: 0.60, blue: 0.92, alpha: 1.00)
            case "poison":
                return UIColor(red: 0.60, green: 0.44, blue: 0.60, alpha: 1.00)
            case "ground":
                return UIColor(red: 0.92, green: 0.76, blue: 0.44, alpha: 1.00)
            case "rock":
                return UIColor(red: 0.60, green: 0.44, blue: 0.44, alpha: 1.00)
            case "bug":
                return UIColor(red: 0.60, green: 0.76, blue: 0.44, alpha: 1.00)
            case "ghost":
                return UIColor(red: 0.44, green: 0.44, blue: 0.60, alpha: 1.00)
            case "steel":
                return UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.00)
            case "fire":
                return UIColor(red: 0.92, green: 0.44, blue: 0.44, alpha: 1.00)
            case "water":
                return UIColor(red: 0.44, green: 0.60, blue: 0.92, alpha: 1.00)
            case "grass":
                return UIColor(red: 0.44, green: 0.92, blue: 0.44, alpha: 1.00)
            case "electric":
                return UIColor(red: 0.92, green: 0.92, blue: 0.44, alpha: 1.00)
            case "psychic":
                return UIColor(red: 0.92, green: 0.44, blue: 0.92, alpha: 1.00)
            case "ice":
                return UIColor(red: 0.44, green: 0.92, blue: 0.92, alpha: 1.00)
            case "dragon":
                return UIColor(red: 0.44, green: 0.44, blue: 0.92, alpha: 1.00)
            case "dark":
                return UIColor(red: 0.44, green: 0.44, blue: 0.44, alpha: 1.00)
            case "fairy":
                return UIColor(red: 0.92, green: 0.44, blue: 0.60, alpha: 1.00)
            default:
                return UIColor(red: 0.78, green: 0.78, blue: 0.60, alpha: 1.00)
        }
    }
    
    
}
