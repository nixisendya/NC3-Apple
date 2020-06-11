//
//  HowToPlayVC.swift
//  NC3Game
//
//  Created by Nixi Sendya Putri on 09/06/20.
//  Copyright © 2020 Nixi Sendya Putri. All rights reserved.
//

import UIKit

class HowToPlayVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let arrayGambarHTP = ["gambarHTP1.png", "gambarHTP2.png", "gambarHTP3.png", "gambarHTP4.png", "gambarHTP5.png"]
    @IBOutlet weak var collection: UICollectionView!
    let arrayTextHTP = ["Welcome to Spyfall! \n \n \nSPYFALL is a party game of bluffing, probing questions, clever answers, and suspicion. \nYou can play anywhere you want and you only need 1 smartphone.", "HOW TO PLAY \n \n \nAt the start of each round, players pick a secret card informing them of the group's location – except that one player receives the SPY card instead of the location. \n \nThe Spy doesn’t know where they are, but wins the round if they can figure it out before they blow their cover!", "Players then start asking each other questions during the intense 8-minute rounds. Non-Spy players want to ask questions and give answers that prove to the other players that they know where they are. But watch out! If your questions and answers are too specific, the Spy will easily guess the location and win. \n \nBut if your questions and answers are too generic, you might be accused of being the Spy.", "Once per round, each player may accuse another player of being the Spy. If all players agree, the game ends and that player’s secret card is revealed. \n \nIf the Spy is captured, each of the Non-Spy players win the round. If a Non-Spy is revealed, the Spy wins. \n \nFinally, if the Spy figures out where they are, they can guess the location ingame. If they're right, they win the round. If not, the Non-Spy players win.", "LET’S GO DETECTIVES \n \n \nSo what are you waiting for? Let’s jump right into the game my fellow detectives and spy!"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collection.dataSource = self
        collection.delegate = self
        collection.isPagingEnabled = true
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayGambarHTP.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! cellCollection
        cell.gambarHTP.image = UIImage (named: arrayGambarHTP[indexPath.item])
        cell.textHTP.text = arrayTextHTP[indexPath.item]
        cell.pageC.currentPage = indexPath.item
        
        return cell
    }
    
    @IBAction func homeButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToHome", sender: self)
    }
    
}

class cellCollection: UICollectionViewCell{
    
    @IBOutlet weak var gambarHTP: UIImageView!
    @IBOutlet weak var textHTP: UILabel!
    @IBOutlet weak var pageC: UIPageControl!
}
