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
    
    @IBOutlet weak var lblGeneration: UILabel!

    @IBOutlet weak var lblHabitat: UILabel!
    
    @IBOutlet weak var lblShape: UILabel!
    
    @IBOutlet weak var lblType2: UILabel!
    
    @IBOutlet weak var imgPokemonBackground: UIImageView!
    
    @IBOutlet weak var imgTextBackground: UIImageView!
    
    let exView : UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .red
        return v
    }()

    let exView1 : UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .blue
        return v
    }()
    
    let exView2 : UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .green
        return v
    }()

    
    
    
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
        
        
        // Adding the subview
        self.view.addSubview(exView)
        self.view.addSubview(exView1)
        self.view.addSubview(exView2)
        applyConstraints()
        

    }
    
    func applyConstraints() {
        
//        exView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        exView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        exView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
//        exView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        exView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        exView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        exView1.topAnchor.constraint(equalTo: exView.bottomAnchor, constant: 20).isActive = true
        exView1.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        exView1.trailingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -10).isActive = true
        exView1.heightAnchor.constraint(equalToConstant: 50).isActive = true

        exView2.topAnchor.constraint(equalTo: exView1.topAnchor).isActive = true
        exView2.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 10).isActive = true
        exView2.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        exView2.heightAnchor.constraint(equalToConstant: 50).isActive = true

        
        
        
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
        lblType.text = type1.uppercased()
        lblType.backgroundColor = Helpers.getLabelColor(label: type1)
        lblType.layer.masksToBounds = true
        lblType.layer.cornerRadius = 5

        if selectedPokemon!.types.count > 1 {
            lblType2.isHidden = false
            
            let type2 = selectedPokemon!.types[1].type.name
            lblType2.backgroundColor = Helpers.getLabelColor(label: type2)
            lblType2.text = type2.uppercased()
            lblType2.layer.masksToBounds = true
            lblType2.layer.cornerRadius = 5
            
        } else {
            lblType2.isHidden = true
            lblType.center = self.view.center
            lblType.center.x = self.view.center.x
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
