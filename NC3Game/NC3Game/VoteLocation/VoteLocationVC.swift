//
//  VoteLocationVC.swift
//  NC3Game
//
//  Created by Nixi Sendya Putri on 09/06/20.
//  Copyright © 2020 Nixi Sendya Putri. All rights reserved.
//

import UIKit

class VoteLocationVC: UIViewController {
    
    @IBOutlet weak var colView: UICollectionView!
    
    let arrayOfLocation: [Location] = [Location(name: "Club", image: "Club.pdf"), Location(name: "Cinema", image: "Cinema.pdf"), Location(name: "School", image: "School.pdf"), Location(name: "Hotel", image: "Hotel.pdf"), Location(name: "Hospital", image: "Hospital.pdf"), Location(name: "Airport", image: "Airport.pdf"), Location(name: "Car", image: "Car.pdf"), Location(name: "Zoo", image: "Zoo.pdf"), Location(name: "House", image: "House.pdf"), Location(name: "Restaurant", image: "Restaurant.pdf"), Location(name: "Concert", image: "Concert.pdf")]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        colView.delegate = self
        colView.dataSource = self

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension VoteLocationVC: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfLocation.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = colView.dequeueReusableCell(withReuseIdentifier: "guessLoc", for: indexPath) as! guessLocCollectionCell
        cell.locName.text = arrayOfLocation[indexPath.row].name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(arrayOfLocation[indexPath.item].name)
    }
    }

class guessLocCollectionCell: UICollectionViewCell{
    
    @IBOutlet weak var locName: UILabel!
}
