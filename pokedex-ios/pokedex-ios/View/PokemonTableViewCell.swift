//
//  PokemonTableViewCell.swift
//  pokedex-ios
//
//  Created by Jean-Michel Beaulieu Bérubé on 2023-04-04.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    private var imageCache = [String: UIImage]()
    
    @IBOutlet weak var imgPokemon: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblType1: UILabel!
    
    @IBOutlet weak var lblType2: UILabel!
    
    @IBOutlet weak var lblNumber: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCellContent(pokemon: Pokemon) {
        lblName.text = pokemon.name.capitalized
        lblNumber.text = "#\(pokemon.id)"
        
        let type1: String = pokemon.types[0].type.name
        lblType1.text = type1.uppercased()
        lblType1.backgroundColor = getLabelColor(label: type1)
        lblType1.layer.masksToBounds = true
        lblType1.layer.cornerRadius = 5
        
        if pokemon.types.count > 1 {
            let type2: String = pokemon.types[1].type.name
            lblType2.isHidden = false
            lblType2.text = type2.uppercased()
            lblType2.layer.masksToBounds = true
            lblType2.layer.cornerRadius = 5
            lblType2.backgroundColor = getLabelColor(label: type2)
        } else {
            lblType2.isHidden = true
        }
        
        let frontDefaultImageUrl = pokemon.sprites.frontDefaultMini
        let url = URL(string: frontDefaultImageUrl)!
        
        // Cancel the previous image download request for this cell (if any)
        URLSession.shared.getAllTasks { tasks in
            tasks
                .filter { $0.originalRequest?.url == url }
                .forEach { $0.cancel() }
        }
        
        if let cachedImage = imageCache[frontDefaultImageUrl] {
            self.imgPokemon.image = cachedImage
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                // Save the downloaded image to the cache
                let image = UIImage(data: data)!
                self.imageCache[frontDefaultImageUrl] = image
                
                DispatchQueue.main.async {
                    self.imgPokemon.image = image
                }
            }.resume()
        }
    }

    
    func getLabelColor(label : String) -> UIColor {
        switch label {
            case "normal":
                return UIColor(red: 0.66, green: 0.65, blue: 0.48, alpha: 1.00)
            case "fighting":
                return UIColor(red: 0.76, green: 0.18, blue: 0.16, alpha: 1.00)
            case "flying":
                return UIColor(red: 0.66, green: 0.56, blue: 0.95, alpha: 1.00)
            case "poison":
                return UIColor(red: 0.64, green: 0.24, blue: 0.63, alpha: 1.00)
            case "ground":
                return UIColor(red: 0.89, green: 0.75, blue: 0.40, alpha: 1.00)
            case "rock":
                return UIColor(red: 0.71, green: 0.63, blue: 0.21, alpha: 1.00)
            case "bug":
                return UIColor(red: 0.65, green: 0.73, blue: 0.10, alpha: 1.00)
            case "ghost":
                return UIColor(red: 0.45, green: 0.34, blue: 0.59, alpha: 1.00)
            case "steel":
                return UIColor(red: 0.72, green: 0.72, blue: 0.81, alpha: 1.00)
            case "fire":
                return UIColor(red: 0.93, green: 0.51, blue: 0.19, alpha: 1.00)
            case "water":
                return UIColor(red: 0.39, green: 0.56, blue: 0.94, alpha: 1.00)
            case "grass":
                return UIColor(red: 0.48, green: 0.78, blue: 0.30, alpha: 1.00)
            case "electric":
                return UIColor(red: 0.97, green: 0.82, blue: 0.17, alpha: 1.00)
            case "psychic":
                return UIColor(red: 0.98, green: 0.33, blue: 0.53, alpha: 1.00)
            case "ice":
                return UIColor(red: 0.59, green: 0.85, blue: 0.84, alpha: 1.00)
            case "dragon":
                return UIColor(red: 0.44, green: 0.21, blue: 0.99, alpha: 1.00)
            case "dark":
                return UIColor(red: 0.44, green: 0.34, blue: 0.27, alpha: 1.00)
            case "fairy":
                return UIColor(red: 0.84, green: 0.52, blue: 0.68, alpha: 1.00)
            default:
                return UIColor(red: 0.78, green: 0.78, blue: 0.60, alpha: 1.00)
        }
    }
    
    
}
