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
        
        // Set click anywhere to dismiss IDCard
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(closeView), name: NSNotification.Name("CloseView"), object: nil)


        let gesture = UITapGestureRecognizer(target: self, action: #selector(closeView(_:)))
        view.addGestureRecognizer(gesture)
        self.gesture = gesture
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handleDismiss))
        view.addGestureRecognizer(pan)
        
    }
    
    @IBAction func joinTeamButtonPressed(_ sender: Any) {
        let name: String = nameTextField.text ?? "Name"
        let newPlayer = Player(name: name, avatar: UIImage(named: "Avatar")!)
        players.append(newPlayer)
        
        // These values depends on the positioning of your element
        let top = CGAffineTransform(translationX: 0, y: -750)

        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
              // Add the transformation in this block
              // self.container is your view that you want to animate
              self.viewIDCard.transform = top
        }, completion: nil)
        
        
        let secondsToDelay = 0.5
        perform(#selector(delayedFunction), with: nil, afterDelay: secondsToDelay)
//        sleep(1)
//        viewIDCard.removeFromSuperview()
//        overlayView.removeFromSuperview()
        
        print(players)
        playerCollectionView.reloadData()
    }
    
    @objc func delayedFunction() {
        viewIDCard.removeFromSuperview()
        overlayView.removeFromSuperview()
        self.viewIDCard.transform = .identity
    }
    
    // Set click anywhere to dismiss IDCard
    @objc private func closeView(_ tapGestureRecognizer: UITapGestureRecognizer) {
        let location = tapGestureRecognizer.location(in: viewIDCard)
        guard viewIDCard.isHidden == false,
              !viewIDCard.bounds.contains(location) else {  //We need to have tapped outside of view 2
            return
        }
        overlayView.removeFromSuperview()
        viewIDCard.removeFromSuperview()
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
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        view.addSubview(overlayView)
        
        viewIDCard.center.x = self.view.center.x
        viewIDCard.frame.origin.y = 0
        view.addSubview(viewIDCard)
    }
}

