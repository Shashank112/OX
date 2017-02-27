//
//  ViewController.swift
//  OX
//
//  Created by Mac Owner on 2/12/17.
//  Copyright © 2017 Shashank. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tictacImage1: UIImageView!
    @IBOutlet var tictacImage2: UIImageView!
    @IBOutlet var tictacImage3: UIImageView!
    @IBOutlet var tictacImage4: UIImageView!
    @IBOutlet var tictacImage5: UIImageView!
    @IBOutlet var tictacImage6: UIImageView!
    @IBOutlet var tictacImage7: UIImageView!
    @IBOutlet var tictacImage8: UIImageView!
    @IBOutlet var tictacImage9: UIImageView!
    
    @IBOutlet var tictacB1: UIButton!
    @IBOutlet var tictacB2: UIButton!
    @IBOutlet var tictacB3: UIButton!
    @IBOutlet var tictacB4: UIButton!
    @IBOutlet var tictacB5: UIButton!
    @IBOutlet var tictacB6: UIButton!
    @IBOutlet var tictacB7: UIButton!
    @IBOutlet var tictacB8: UIButton!
    @IBOutlet var tictacB9: UIButton!
    
    
    @IBOutlet var resetButton: UIButton!
    
    @IBOutlet var userMessage: UILabel!
    
    var plays = Dictionary<Int,Int>()
    var done = false
    var aiDeciding = false
    
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func UIButtonClicked(sender:UIButton) {
        userMessage.isHidden = true
        if !(plays[sender.tag] != nil) && !aiDeciding && !done {
            setImageForSpot(spot: sender.tag, player:1)
        }
        checkForWin()
        aiTurn()
    }
    
    
    func setImageForSpot(spot:Int,player:Int) {
        
        var playerMark = player == 1 ? "x" : "0"
        plays[spot] = player
        switch spot {
        case 1:
            tictacImage1.image = UIImage(named: playerMark)
        case 2:
            tictacImage2.image = UIImage(named: playerMark)
        case 3:
            tictacImage3.image = UIImage(named: playerMark)
        case 4:
            tictacImage4.image = UIImage(named: playerMark)
        case 5:
            tictacImage5.image = UIImage(named: playerMark)
        case 6:
            tictacImage6.image = UIImage(named: playerMark)
        case 7:
            tictacImage7.image = UIImage(named:
                playerMark)
        case 8:
            tictacImage8.image = UIImage(named: playerMark)
        case 9:
            tictacImage9.image = UIImage(named: playerMark)
        default:
        tictacImage5.image = UIImage(named: playerMark)
        }
        
        
        
    }
    
    func checkForWin(){
        
    }
    
    func aiTurn(){
        
    }
    

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
}

