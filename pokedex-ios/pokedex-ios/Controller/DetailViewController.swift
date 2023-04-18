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
        
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var lblGeneration: UILabel!

    @IBOutlet weak var lblHabitat: UILabel!
    
    @IBOutlet weak var lblShape: UILabel!
    
    @IBOutlet weak var lblFirstTypes: UILabel!
    
    @IBOutlet weak var lblSecondTypes: UILabel!
    
    @IBOutlet weak var imgPokemonBackground: UIImageView!
    
    @IBOutlet weak var imgTextBackground: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        imgTextBackground.layer.cornerRadius = 50
        imgTextBackground.backgroundColor = .secondarySystemBackground
        Network().getPokemonDetail(name: selectedPokemon!.name) { [weak self] detail in
            DispatchQueue.main.async {
                self?.configureDetailView(with: detail)
            }
            self?.loadPokemonImage(from: self!.selectedPokemon!.sprites.other.officialArtwork.frontDefault)
        }
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.standardAppearance = appearance
        
        lblFirstTypes.translatesAutoresizingMaskIntoConstraints = false
        lblSecondTypes.translatesAutoresizingMaskIntoConstraints = false
    }

    func configureDetailView(with detail: PokemonDetail) {
        self.title = "\(selectedPokemon!.name.capitalized) Details"
        lblName.text = selectedPokemon!.name.capitalized
        lblNumber.text = "#\(selectedPokemon!.id)"
        lblGeneration.text = "\(detail.generation.name.capitalized)"
        lblHabitat.text = "\(detail.habitat.name.capitalized)"
        lblShape.text = "\(detail.shape.name.capitalized)"
        
        let color = detail.color.name
        imgPokemonBackground.backgroundColor = Helpers.getBackgroundColor(label: color)
        
        if let flavorText = detail.flavorTextEntries.first(where: { $0.language.name == "en" })?.flavorText {
            lblDescription.text = removeNewlines(from: flavorText)
        }
        
        let type1 = selectedPokemon!.types[0].type.name
        lblFirstTypes.text = type1.uppercased()
        lblFirstTypes.backgroundColor = Helpers.getLabelColor(label: type1)
        lblFirstTypes.layer.masksToBounds = true
        lblFirstTypes.layer.cornerRadius = 5
        setConstraintTwoType()
        
        if selectedPokemon!.types.count > 1 {
            lblSecondTypes.isHidden = false
            
            let type2 = selectedPokemon!.types[1].type.name
            lblSecondTypes.backgroundColor = Helpers.getLabelColor(label: type2)
            lblSecondTypes.text = type2.uppercased()
            lblSecondTypes.layer.masksToBounds = true
            lblSecondTypes.layer.cornerRadius = 5
        } else {
            lblSecondTypes.isHidden = true
        }
    }
    
    func setConstraintTwoType(){
        if selectedPokemon!.types.count > 1 {
            lblFirstTypes.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 20).isActive = true
            lblFirstTypes.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
            lblFirstTypes.trailingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -10).isActive = true
            lblFirstTypes.heightAnchor.constraint(equalToConstant: 28).isActive = true
            lblFirstTypes.bottomAnchor.constraint(equalTo: lblDescription.topAnchor, constant: -20).isActive = true

            lblSecondTypes.topAnchor.constraint(equalTo: lblFirstTypes.topAnchor).isActive = true
            lblSecondTypes.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 10).isActive = true
            lblSecondTypes.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
            lblSecondTypes.heightAnchor.constraint(equalToConstant: 28).isActive = true
            lblFirstTypes.bottomAnchor.constraint(equalTo: lblDescription.topAnchor, constant: -20).isActive = true
        } else {
            lblFirstTypes.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 20).isActive = true
            lblFirstTypes.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
            lblFirstTypes.heightAnchor.constraint(equalToConstant: 28).isActive = true
            lblFirstTypes.widthAnchor.constraint(equalToConstant: 170).isActive = true
            lblFirstTypes.bottomAnchor.constraint(equalTo: lblDescription.topAnchor, constant: -20).isActive = true
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
