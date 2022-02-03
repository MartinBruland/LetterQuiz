//
//  ResultsViewController.swift
//  LetterQuiz+
//
//  Created by Martin Bruland on 02/02/2019.
//  Copyright © 2019 Martin Bruland. All rights reserved.
//

import UIKit
import StoreKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var resultMessageOne: UILabel!
    @IBOutlet weak var resultMessageTwo: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var returnButton: UIButton!
    
    var correctAnswers = Int()
    var highscore = Int()
    
    

    //PRESENT RESULTS.
    func resultsData() {
    
        if correctAnswers > highscore {
            
            UserDefaults.standard.set(correctAnswers, forKey: "highscore")
            resultMessageOne.text = "NEW HIGHSCORE!"
            resultMessageTwo.text = "You scored \(correctAnswers) points"
            
        } else {
            
            resultMessageOne.text = "GAME OVER"
            resultMessageTwo.text = ""
        }
        
        
    }
    
    override func viewDidLayoutSubviews() {
        
        let hexColor = HexColorToUIColor()
        let myCornerRadius = 12.0
        let myBorderWidth = 1.0
        let myBorderColor = "#000000"
        
        playButton.layer.borderColor = hexColor.convertHexColor(hexColor: myBorderColor).cgColor
        playButton.layer.borderWidth = myBorderWidth
        playButton.layer.cornerRadius = myCornerRadius
        
        returnButton.layer.borderColor = hexColor.convertHexColor(hexColor: myBorderColor).cgColor
        returnButton.layer.borderWidth = myBorderWidth
        returnButton.layer.cornerRadius = returnButton.frame.width / 2
        
    }
 
    

  
    //LOAD DATA ON VIEWDIDLOAD.
    override func viewDidLoad() {
        
        super.viewDidLoad()
        resultsData()
        
        

        
    }

    //HIDE STATUSBAR.
    override var prefersStatusBarHidden: Bool {
        return true
    }

    //SHOW STARTMENU.
    @IBAction func backButtonPressed(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "startmenuView") as! StartmenuViewController
        self.present(viewController, animated:true, completion:nil)
        
    }
    
    @IBAction func playAgainButtonPressed(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "gameView") as! GameViewController
        self.present(viewController, animated:true, completion:nil)
        
    }
}
