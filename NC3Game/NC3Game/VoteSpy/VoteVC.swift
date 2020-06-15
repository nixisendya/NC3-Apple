//
//  VoteVC.swift
//  NC3Game
//
//  Created by Nixi Sendya Putri on 09/06/20.
//  Copyright © 2020 Nixi Sendya Putri. All rights reserved.
//

import UIKit

class VoteVC: UIViewController {

    @IBOutlet weak var playerCollectionView: UICollectionView!
    var arrayOfPlayers: [Player]!
    
    @IBOutlet var viewConfirmVote: UIView!
    @IBOutlet var overlayView: UIView!
    
    @IBOutlet weak var confirmNameLabel: UILabel!
    @IBOutlet weak var confirmPlayerImage: UIImageView!
    
    var indexSpy: Int!
    var playerSpy: Player!
    
    var votedPlayer: Player!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Spynya ada di index \(indexSpy!)")
        
        playerSpy = arrayOfPlayers[indexSpy]
        // Do any additional setup after loading the view.
        playerCollectionView.delegate = self
        playerCollectionView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEndgame" {
            if let destinationVC = segue.destination as? EndGameVC {
                destinationVC.votedPlayer = votedPlayer
                destinationVC.realSpy = playerSpy
                destinationVC.firstLabel = "The group voted for"
                destinationVC.secondLabel = votedPlayer.name
                destinationVC.thirdImage = "Avatar"
            }
        }
    }
    
    
    @IBAction func buttonClicked(_ sender: Any) {
        playButtonClick()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        overlayView.removeFromSuperview()
        viewConfirmVote.removeFromSuperview()
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToEndgame", sender: self)
    }
}

extension VoteVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrayOfPlayers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = playerCollectionView.dequeueReusableCell(withReuseIdentifier: "playerCell", for: indexPath) as! VoteCollectionViewCell
        
        cell.imagePlayer.image = arrayOfPlayers[indexPath.row].avatar
        cell.nameLabel.text = arrayOfPlayers[indexPath.row].name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        playButtonClick()
        confirmNameLabel.text = arrayOfPlayers[indexPath.row].name
        confirmPlayerImage.image = arrayOfPlayers[indexPath.row].avatar
        
        votedPlayer = arrayOfPlayers[indexPath.row]
        
        print(arrayOfPlayers[indexPath.row].isSpy)
        overlayView.backgroundColor = .black
        overlayView.alpha = 0.8
        view.addSubview(overlayView)
            
        viewConfirmVote.center = self.view.center
        view.addSubview(viewConfirmVote)
        
    }
    
    
}
