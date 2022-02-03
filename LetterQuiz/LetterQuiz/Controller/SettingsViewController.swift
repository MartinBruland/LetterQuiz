//
//  SettingsViewController.swift
//  LetterQuiz
//
//  Created by Martin Bruland on 02/02/2019.
//  Copyright © 2019 Martin Bruland. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var returnButton: UIButton!
    

    //BUTTON: RESET PROGRESS.
    @IBAction func resetProgress(_ sender: Any) {
        
        let alert = UIAlertController(title: "Reset Highscore", message: "Are you sure you want to reset the highscore?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Reset", style: UIAlertAction.Style.default, handler: { action in
            
            UserDefaults.standard.removeObject(forKey: "highscore")

        }))
        
        self.present(alert, animated: true, completion: nil)
    
    }
    

    //LOAD DATA ON VIEWDIDLOAD.
    override func viewDidLoad() {
        
        super.viewDidLoad()

    }
    
    override func viewDidLayoutSubviews() {
        
        let hexColor = HexColorToUIColor()
        let myCornerRadius = 12.0
        let myBorderWidth = 1.0
        let myBorderColor = "#000000"
        
        resetButton.layer.borderColor = hexColor.convertHexColor(hexColor: myBorderColor).cgColor
        resetButton.layer.borderWidth = myBorderWidth
        resetButton.layer.cornerRadius = myCornerRadius
        
        
        returnButton.layer.borderColor = hexColor.convertHexColor(hexColor: myBorderColor).cgColor
        returnButton.layer.borderWidth = myBorderWidth
        returnButton.layer.cornerRadius = returnButton.frame.width / 2
        
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

}
