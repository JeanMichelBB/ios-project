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
        lblType1.backgroundColor = Helpers.getLabelColor(label: type1)
        lblType1.layer.masksToBounds = true
        lblType1.layer.cornerRadius = 5
        
        if pokemon.types.count > 1 {
            let type2: String = pokemon.types[1].type.name
            lblType2.isHidden = false
            lblType2.text = type2.uppercased()
            lblType2.layer.masksToBounds = true
            lblType2.layer.cornerRadius = 5
            lblType2.backgroundColor = Helpers.getLabelColor(label: type2)
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
}
