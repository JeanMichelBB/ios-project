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
    
    @IBOutlet weak var lblFirstType: UILabel!
    
    @IBOutlet weak var lblSecondType: UILabel!
    
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
        lblFirstType.text = type1.uppercased()
        lblFirstType.backgroundColor = Helpers.getLabelColor(label: type1)
        lblFirstType.layer.masksToBounds = true
        lblFirstType.layer.cornerRadius = 5
        
        if pokemon.types.count > 1 {
            lblSecondType.isHidden = false
            
            let type2: String = pokemon.types[1].type.name
            lblSecondType.text = type2.uppercased()
            lblSecondType.backgroundColor = Helpers.getLabelColor(label: type2)
            lblSecondType.layer.masksToBounds = true
            lblSecondType.layer.cornerRadius = 5
            
        } else {
            lblSecondType.isHidden = true
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
}
