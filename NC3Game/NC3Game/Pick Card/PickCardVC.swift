//
//  PickCardVC.swift
//  NC3Game
//
//  Created by Nixi Sendya Putri on 09/06/20.
//  Copyright © 2020 Nixi Sendya Putri. All rights reserved.
//

import UIKit

class PickCardVC: UIViewController {
    
    
    @IBOutlet weak var walkieTalkieImage: UIImageView!
    
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
    
    let arrayOfLocation: [Location] = [Location(name: "Club", image: "Club.pdf"), Location(name: "Cinema", image: "Cinema.pdf"), Location(name: "School", image: "School.pdf"), Location(name: "Hotel", image: "Hotel.pdf"), Location(name: "Hospital", image: "Hospital.pdf"), Location(name: "Airport", image: "Airport.pdf"), Location(name: "Car", image: "Car.pdf"), Location(name: "Zoo", image: "Zoo.pdf"), Location(name: "House", image: "House.pdf"), Location(name: "Restaurant", image: "Restaurant.pdf"), Location(name: "Concert", image: "Concert.pdf")]
    
    var randomPerson = ""
    var randomPersonIndex = 0
    var randomLocation: Location!
    
    var firstToAsk = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cardCollectionView.delegate = self
        cardCollectionView.dataSource = self
        
        for item in arrayOfPlayers {
            arrayOfPlayersName.append(item.name)
        }
        
        firstToAsk = arrayOfPlayersName.randomElement()!
        
        generateCards()
        orderNameToPickCard()
        
        shake()
        playSound(sound: "WalkieTalkie2", type: "mp3")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGameplay" {
            if let destinationVC = segue.destination as? GameplayVC {
                destinationVC.firstPlayer = firstToAsk
                destinationVC.arrayOfPlayers = arrayOfPlayers
                destinationVC.indexSpy = randomPersonIndex
                destinationVC.randomLocation = randomLocation.name
            }
        }
    }
    
    func generateCards() {
        
        randomLocation = arrayOfLocation.randomElement()!
        print(randomLocation)
        let indexSpy = Int.random(in: 0..<arrayOfPlayers.count)
        
        print("The spy is index \(indexSpy)")
        
        for n in 0..<arrayOfPlayers.count {
            if n == indexSpy {
                let card = Card(isOpened: false, openedBy: "", location: randomLocation.name, isSpy: true)
                arrayOfCards.append(card)
            } else {
                let card = Card(isOpened: false, openedBy: "", location: randomLocation.name, isSpy: false)
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
        shake()
        playSound(sound: "WalkieTalkie2", type: "mp3")
        
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
    
    @IBAction func homeButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "unwindToHome", sender: self)
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
        
        if arrayOfCards[indexPath.row].isOpened {
            let alertController = UIAlertController(title: "Enveloppe Opened!", message:
                "Please select another enveloppe!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))

            self.present(alertController, animated: true, completion: nil)
        } else {
            arrayOfCards[indexPath.row].isOpened = true
            arrayOfCards[indexPath.row].openedBy = randomPerson
            
            showCard(index: indexPath.row, chosenBy: randomPerson)

            arrayOfPlayersName.removeAll { $0 == randomPerson }
            orderNameToPickCard()
            
            
            cardCollectionView.reloadData()
        }
    }
    
    func showCard(index: Int, chosenBy: String) {
        
        let cardChosen = arrayOfCards[index]
        
        if cardChosen.isSpy {
            print("Show Spy Card Chosen View")
            
            var currentIndex = 0
            
            for player in arrayOfPlayers
            {
                if player.name == randomPerson {
                    print("Found \(player.name) for index \(currentIndex)")
                    arrayOfPlayers[currentIndex].isSpy = true
                    randomPersonIndex = currentIndex
                    break
                }

                currentIndex += 1
            }
            
            overlayView.backgroundColor = .black
            overlayView.alpha = 0.8
            view.addSubview(overlayView)
                
            cardSpyView.center = self.view.center
            
            view.addSubview(cardSpyView)
        } else {
            print("Show Location Card Chosen View")
            
            overlayView.backgroundColor = .black
            overlayView.alpha = 0.8
            view.addSubview(overlayView)
                
            cardLocationView.center = self.view.center
            locationLabel.text = randomLocation.name
            locationImage.image = UIImage(named: randomLocation.image)
            
            
            view.addSubview(cardLocationView)
        }
    
    }
    
    func shake() {
        let translation = CAKeyframeAnimation(keyPath: "transform.translation.x");
        translation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        translation.values = [-5, 5, -5, 5, -3, 3, -2, 2, 0]
        
        let rotation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotation.values = [-5, 5, -5, 5, -3, 3, -2, 2, 0].map {
            (degrees: Double) -> Double in
            let radians: Double = (.pi * degrees) / 180.0
            return radians
        }
        
        let shakeGroup: CAAnimationGroup = CAAnimationGroup()
        shakeGroup.animations = [translation, rotation]
        shakeGroup.duration = 2
        walkieTalkieImage.layer.add(shakeGroup, forKey: "shakeIt")
    }
    
}
