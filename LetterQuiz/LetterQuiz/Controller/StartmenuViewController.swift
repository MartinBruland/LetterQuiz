//
//  StartMenuViewController.swift
//  LetterQuiz
//
//  Created by Martin Bruland on 02/02/2019.
//  Copyright © 2019 Martin Bruland. All rights reserved.
//

import UIKit

class StartmenuViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    
    @IBOutlet weak var settingsViewButton: UIButton!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    
   override func viewDidLayoutSubviews() {
        
        let hexColor = HexColorToUIColor()
        let myCornerRadius = 12.0
        let myBorderWidth = 1.0
        let myBorderColor = "#000000"
        
        settingsViewButton.layer.borderColor = hexColor.convertHexColor(hexColor: myBorderColor).cgColor
        settingsViewButton.layer.borderWidth = myBorderWidth
        settingsViewButton.layer.cornerRadius = settingsViewButton.frame.width / 2
        
        startGameButton.layer.borderColor = hexColor.convertHexColor(hexColor: myBorderColor).cgColor
        startGameButton.layer.borderWidth = myBorderWidth
        startGameButton.layer.cornerRadius = myCornerRadius
        
    }
    
    
    //VIEWDIDLOAD.
    override func viewDidLoad() {

        super.viewDidLoad()
        
        let high = UserDefaults.standard.integer(forKey: "highscore")
        
        if high != 0 {
        highscoreLabel.text = "Highscore: \(high)"
        } else {
            highscoreLabel.text = ""
        }
        

        
    }
        
    
    //BUTTON: SHOW SETTINGS VIEWCONTROLLER.
    @IBAction func settingsButtonPressed(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "settingsView") as! SettingsViewController
        self.present(viewController, animated:true, completion:nil)
        
    }
    
    //BUTTON: SHOW GAME VIEWCONTROLLER.
    @IBAction func startGame(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "gameView") as! GameViewController
        self.present(viewController, animated:true, completion:nil)
        
    }
    
    //HIDE STATUSBAR.
    override var prefersStatusBarHidden: Bool {
        
        return true
    
    }
}
