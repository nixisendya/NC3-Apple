//
//  AddPlayerVC.swift
//  NC3Game
//
//  Created by Nixi Sendya Putri on 09/06/20.
//  Copyright © 2020 Nixi Sendya Putri. All rights reserved.
//

import UIKit

class AddPlayerVC: UIViewController {

    @IBOutlet weak var playerCollectionView: UICollectionView!
    @IBOutlet var viewIDCard: UIView!
    @IBOutlet var overlayView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var playerJoinButton: UIButton!
    
    var players: [Player] = []
    
    var gesture : UITapGestureRecognizer?
    var viewTranslation = CGPoint(x: 0, y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        playerCollectionView.delegate = self
        playerCollectionView.dataSource = self
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handleDismiss))
        view.addGestureRecognizer(pan)
        
        // Tap anywhere to close keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        nameTextField.autocorrectionType = .no
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPickCard" {
            if let destinationVC = segue.destination as? PickCardVC {
                destinationVC.arrayOfPlayers = players
            }
        }
    }
    
    @IBAction func startGamePressed(_ sender: Any) {
        if (players.count < 3) {
            let alertController = UIAlertController(title: "Players Required", message:
                "You need at least 3 players to start the game!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))

            self.present(alertController, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: "goToPickCard", sender: self)
        }
    }
    
}

extension AddPlayerVC: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return players.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellID = indexPath.row < players.count ? "normalCell" : "specialCell"
        let cell = playerCollectionView.dequeueReusableCell( withReuseIdentifier: "playerCell", for: indexPath)
    
        setupCell(cell: cell, indexPath: indexPath, type: cellID)
        
        return cell
    }
    
    func setupCell(cell: UICollectionViewCell, indexPath: IndexPath, type: String) {
        switch(type) {
        case "normalCell":
            setupPlayerCell(cell: cell as! PlayerCollectionViewCell, indexPath: indexPath)
        case "specialCell":
            setupAddCell(cell: cell as! PlayerCollectionViewCell, indexPath: indexPath)
        default:
            break
        }
    }

    func setupPlayerCell(cell: PlayerCollectionViewCell, indexPath: IndexPath) {
        cell.playerAvatarImageView.image = players[indexPath.row].avatar
        cell.playerName.text = players[indexPath.row].name
    }

    func setupAddCell(cell: PlayerCollectionViewCell, indexPath: IndexPath) {
        cell.playerAvatarImageView.image = UIImage(named: "plus")
        cell.playerName.text = ""
        cell.playerAvatarImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.addButtonTapped))
        cell.playerAvatarImageView.addGestureRecognizer(tap)
    }

    @objc func addButtonTapped() {
        print("Show UI to add new player")
        nameTextField.text = ""
    
        overlayView.backgroundColor = .black
        overlayView.alpha = 0.8
        view.addSubview(overlayView)
        
        viewIDCard.center.x = self.view.center.x
        viewIDCard.frame.origin.y = 0
        view.addSubview(viewIDCard)
    }
    
    func transitionIDout() {
        
        // These values depends on the positioning of your element
        let top = CGAffineTransform(translationX: 0, y: -750)

        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
              // Add the transformation in this block
              // self.container is your view that you want to animate
              self.viewIDCard.transform = top
        }, completion: nil)
        
        
        let secondsToDelay = 0.5
        perform(#selector(delayedFunction), with: nil, afterDelay: secondsToDelay)
        
        UIViewPropertyAnimator(duration: 0.5, curve: .easeOut, animations: {
            self.overlayView.alpha = 0
        }).startAnimation()
    }
    
    @IBAction func joinTeamButtonPressed(_ sender: Any) {
        let name: String = nameTextField.text ?? "Name"
        let newPlayer = Player(name: name, avatar: UIImage(named: "Avatar")!)
        players.append(newPlayer)
        
        transitionIDout()
        
        print(players)
        playerCollectionView.reloadData()
    }
    
    @objc func delayedFunction() {
        viewIDCard.removeFromSuperview()
        overlayView.removeFromSuperview()
        self.viewIDCard.transform = .identity
    }
    
    @objc func handleDismiss(sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .changed:
            viewTranslation = sender.translation(in: viewIDCard)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.viewIDCard.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
            })
        case .ended:
            if viewTranslation.y > -200 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.viewIDCard.transform = .identity
                })
                transitionIDout()
                
            } else {
                self.viewIDCard.transform = .identity
                self.viewIDCard.removeFromSuperview()
                self.overlayView.removeFromSuperview()
            }
        default:
            break
        }
        
    }
    

}

