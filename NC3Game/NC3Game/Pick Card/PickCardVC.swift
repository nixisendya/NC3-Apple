//
//  PickCardVC.swift
//  NC3Game
//
//  Created by Nixi Sendya Putri on 09/06/20.
//  Copyright © 2020 Nixi Sendya Putri. All rights reserved.
//

import UIKit

class PickCardVC: UIViewController {
    
    @IBOutlet weak var cardCollectionView: UICollectionView!
    @IBOutlet weak var namePickCardLabel: UILabel!
    
    @IBOutlet var cardLocationView: UIView!
    @IBOutlet var cardSpyView: UIView!
    @IBOutlet var overlayView: UIView!
    @IBOutlet var alertGameplayView: UIView!
    
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    
    var arrayOfPlayers: [Player]!
    var arrayOfPlayersName: [String] = []
    var arrayOfCards: [Card] = []
    
    var arrayOfLocations: [String] = ["Club", "Cinema", "School", "Hotel", "Hospital", "Airport", "Car"]
    
    var randomPerson = ""
    var randomLocation = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cardCollectionView.delegate = self
        cardCollectionView.dataSource = self
        
        for item in arrayOfPlayers {
            arrayOfPlayersName.append(item.name)
        }
        
        generateCards()
        orderNameToPickCard()
        
    }
    
    func generateCards() {
        
        randomLocation = arrayOfLocations.randomElement()!
        let indexSpy = Int.random(in: 0..<arrayOfPlayers.count)
        
        print("The spy is index \(indexSpy)")
        
        for n in 1...arrayOfPlayers.count {
            if n == indexSpy {
                let card = Card(isOpened: false, openedBy: "", location: randomLocation, isSpy: true)
                arrayOfCards.append(card)
            } else {
                let card = Card(isOpened: false, openedBy: "", location: randomLocation, isSpy: false)
                arrayOfCards.append(card)
            }
        }
        
        print(arrayOfCards)
    }
    
    func orderNameToPickCard() {
        
        if !arrayOfPlayersName.isEmpty {
            randomPerson = arrayOfPlayersName.randomElement()!
            
            namePickCardLabel.text = "\(randomPerson), pick a card!"
        } else {
            namePickCardLabel.text = "All Good!"
            print("Semua udah milih kartu")
        }
    }

    @IBAction func okButtonPressed(_ sender: Any) {
        
        if cardLocationView.isHidden == false {
            cardLocationView.removeFromSuperview()
        }
        
        if cardSpyView.isHidden == false {
            cardSpyView.removeFromSuperview()
        }
        
        overlayView.removeFromSuperview()
        
        if arrayOfPlayersName.isEmpty {
            overlayView.backgroundColor = .black
            overlayView.alpha = 0.8
            view.addSubview(overlayView)
                
            alertGameplayView.center = self.view.center
            view.addSubview(alertGameplayView)
        }
    }
    
    @IBAction func startGame(_ sender: Any) {
        performSegue(withIdentifier: "goToGameplay", sender: self)
    }
}

extension PickCardVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrayOfCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cardCollectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardCollectionViewCell
        
        if arrayOfCards[indexPath.row].isOpened {
            cell.enveloppeImage.image = UIImage(named: "EnveloppeOpen2")
            cell.nameLabel.text = arrayOfCards[indexPath.row].openedBy
        } else {
            cell.enveloppeImage.image = UIImage(named: "EnveloppeClosed")
            cell.nameLabel.text = ""
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt: \(indexPath)")
        
        arrayOfCards[indexPath.row].isOpened = true
        arrayOfCards[indexPath.row].openedBy = randomPerson
        
        showCard(index: indexPath.row)
        orderNameToPickCard()
        arrayOfPlayersName.removeAll { $0 == randomPerson }
        
        cardCollectionView.reloadData()
    }
    
    func showCard(index: Int) {
        
        let cardChosen = arrayOfCards[index]
        
        if cardChosen.isSpy {
            print("Show Spy Card Chosen View")
            
            overlayView.backgroundColor = .black
            overlayView.alpha = 0.8
            view.addSubview(overlayView)
                
            cardSpyView.center = self.view.center
            locationLabel.text = cardChosen.location
            
            view.addSubview(cardSpyView)
        } else {
            print("Show Spy Card Chosen View")
            
            overlayView.backgroundColor = .black
            overlayView.alpha = 0.8
            view.addSubview(overlayView)
                
            cardLocationView.center = self.view.center
            view.addSubview(cardLocationView)
        }
    
    }
    
}
