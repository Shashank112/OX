//
//  ViewController.swift
//  OX
//
//  Created by Mac Owner on 2/12/17.
//  Copyright © 2017 Shashank. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    enum Player: Int {
        case computerPLayer = 0, userPlayer = 1
    }
    
    
    
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
    var tictacImages = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        
        done = false
        resetButton.isHidden = true
        userMessage.isHidden = true
        reset()
        
    }
    
    func reset() {
        plays = [:]
        tictacImage1.image = nil
        tictacImage2.image = nil
        tictacImage3.image = nil
        tictacImage4.image = nil
        tictacImage5.image = nil
        tictacImage6.image = nil
        tictacImage7.image = nil
        tictacImage8.image = nil
        tictacImage9.image = nil
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
        
        var whoWon = ["I":0, "You":1]
        for(key,value) in whoWon {
            if((plays[7] == value && plays[8] == value && plays[9] == value) || // across bottom
                (plays[4] == value && plays[5] == value && plays[6] == value) || // across middle
                (plays[1] == value && plays[2] == value && plays[3] == value) || // across bottom
                (plays[7] == value && plays[4] == value && plays[7] == value) || // down the left
                (plays[3] == value && plays[6] == value && plays[9] == value) || // down the right
                (plays[2] == value && plays[5] == value && plays[8] == value) || // down the middle
                (plays[1] == value && plays[5] == value && plays[9] == value) || // drag left right
                (plays[3] == value && plays[5] == value && plays[7] == value)) {// drag righ  left
            
                userMessage.isHidden = false
                userMessage.text = "Looks like \(key) WON!!!"
                resetButton.isHidden = false
                done = true
            }
        }
        
    }
    
    func checkFor(value:Int, inList:[Int]) -> String {
        var conclusion = ""
        for cell in inList {
            if plays[cell] == value {
                conclusion += "1"
            }else {
                conclusion += "0"
            }
        }
        return conclusion
    }
    
    func checkBottom(value:Int) -> (location:String,pattern:String) {
        return("bottom",checkFor(value: value, inList: [7,8,9]))
    }
    func checkMiddleAcross(value:Int) -> (location:String,pattern:String) {
        return("bottom",checkFor(value: value, inList: [4,5,6]))
    }
    func checkTop(value:Int) -> (location:String,pattern:String) {
        return("bottom",checkFor(value: value, inList: [1,2,3]))
    }
    func checkLeft(value:Int) -> (location:String,pattern:String) {
        return("bottom",checkFor(value: value, inList: [1,4,7]))
    }
    func checkMiddleDown(value:Int) -> (location:String,pattern:String) {
        return("bottom",checkFor(value: value, inList: [2,5,8]))
    }
    func checkRight(value:Int) -> (location:String,pattern:String) {
        return("bottom",checkFor(value: value, inList: [3,6,9]))
    }
    func checkDiagLeftRight(value:Int) -> (location:String,pattern:String) {
        return("bottom",checkFor(value: value, inList: [3,5,7]))
    }
    func checkDiagRightLeft(value:Int) -> (location:String,pattern:String) {
        return("bottom",checkFor(value: value, inList: [1,5,9]))
    }
    
    
    func rowCheck(value:Int) -> (location:String,pattern:String)? {
        var acceptableFinds = ["011","110","101"]
        var findFuncs = [checkTop, checkBottom, checkLeft, checkRight, checkMiddleAcross, checkMiddleDown, checkDiagLeftRight, checkDiagRightLeft]
        for algorithm in findFuncs {
            var algorithmResults = algorithm(value)
            if find(acceptableFinds,algorithmResults.pattern) {
                return algorithmResults
            }
        }
        return nil
        
    }
    
    func aiTurn(){
        
        if done {
            return
        }
        
        aiDeciding = true
        
        // We (computer) have two in a row.
        if let result = rowCheck(value:0) {
            
            var whereToPlayResult = whereToPlay(result.location, pattern:result.pattern)
            
        }
        
        
        aiDeciding = false
        
    }
    
    func whereToPlay(location:String, pattern:String) -> Int {
        var leftPattern = "011"
        var rightPattern = "110"
        var middlePattern = "101"
        
    switch location {
        case "top":
                if pattern == leftPattern {
                    return 1
                } else if pattern == rightPattern{
                    return 3
                }else {
                    return 2
            }
            
        case "bottom":
            if pattern == leftPattern {
                return 7
            } else if pattern == rightPattern{
                return 9
            }else {
                return 8
            }
            
        case "left":
            if pattern == leftPattern {
                return 1
            } else if pattern == rightPattern{
                return 7
            }else {
                return 4
            }
            
        case "right":
            if pattern == leftPattern {
                return 3
            } else if pattern == rightPattern{
                return 9
            }else {
                return 6
            }
            
        case "middleVert":
            if pattern == leftPattern {
                return 2
            } else if pattern == rightPattern{
                return 8
            }else {
                return 5
            }
            
        case "middleHorz":
            if pattern == leftPattern {
                return 4
            } else if pattern == rightPattern{
                return 6
            }else {
                return 5
            }
            
        case "diagRightLeft":
            if pattern == leftPattern {
                return 3
            } else if pattern == rightPattern{
                return 7
            }else {
                return 5
            }
            
        case "diagLeftRight":
            if pattern == leftPattern {
                return 1
            } else if pattern == rightPattern{
                return 9
            }else {
                return 5
            }
        
    default: return 4
        
            
            
            
        }
    }

    
    
    
    
    
    
    
}

