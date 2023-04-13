//
//  Helper.swift
//  pokedex-ios
//
//  Created by Jean-Michel Beaulieu Bérubé on 2023-04-11.
//

import Foundation
import UIKit


class Helper{
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
    func setBackgroundColor(from string: String, to view: UIView) {
        switch string {
        case "red":
            // light red for the background
            
            view.backgroundColor = UIColor(red: 1.0, green: 0.75, blue: 0.75, alpha: 1.0)
        case "blue":
            view.backgroundColor = UIColor(red: 0.10, green: 0.70, blue: 0.87, alpha: 1.00)
        case "yellow":
            view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 0.75, alpha: 1.0)
        case "green":
            view.backgroundColor = UIColor(red: 0.75, green: 1.0, blue: 0.75, alpha: 1.0)
        case "black":
            view.backgroundColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1.0)
        case "brown":
            view.backgroundColor = UIColor(red: 0.85, green: 0.7, blue: 0.5, alpha: 1.0)
        case "purple":
            view.backgroundColor = UIColor(red: 0.8, green: 0.7, blue: 1.0, alpha: 1.0)
        case "gray":
            view.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        case "white":
            view.backgroundColor = UIColor(red: 0.96, green: 0.97, blue: 0.96, alpha: 1.00)
        case "pink":
            view.backgroundColor = UIColor(red: 1.0, green: 0.75, blue: 0.85, alpha: 1.0)
        default:
            view.backgroundColor = UIColor.white 
        }
    }

}
