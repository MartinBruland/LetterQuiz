//
//  GameViewController.swift
//  LetterQuiz
//
//  Created by Martin Bruland on 02/02/2019.
//  Copyright © 2019 Martin Bruland. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    //CONSTRAINTS
    @IBOutlet weak var progressbarPosition: NSLayoutConstraint!
    @IBOutlet weak var countdownbarWidth: NSLayoutConstraint!
    @IBOutlet weak var mainProgressTrackerWidth: NSLayoutConstraint!
    @IBOutlet weak var extendedProgressTrackerWidth: NSLayoutConstraint!
    
    //GAME CONTAINER VIEW
    @IBOutlet weak var gameContentView: UIView!
    
    //PROGRESSBAR VIEWS
    @IBOutlet weak var progressbarMainView: UIView!
    @IBOutlet weak var progressbarMainDefaultProgress: UIView!
    @IBOutlet weak var progressbarMainPointStackView: UIStackView!
    @IBOutlet weak var progressbarMainTracker: UIView!
    @IBOutlet weak var scoreToBeat: UILabel!
    @IBOutlet weak var currentScore: UILabel!
    
    @IBOutlet weak var progressbarExtensionPointStackView: UIStackView!
    @IBOutlet weak var progressbarExtensionTracker: UIView!
    @IBOutlet weak var currentScore2: UILabel!
    @IBOutlet weak var scoreToBeat2: UILabel!
    
    //COUNTDOWN BAR
    @IBOutlet weak var countdownContainer: UIView!
    @IBOutlet weak var countdownBar: UIView!

    //LIVES AND HIGHSCORE DATA VIEWS
    @IBOutlet weak var amountOfLivesLabel: UILabel!

    //QUESTION CARD VIEW
    @IBOutlet weak var questionLabel: UILabel!
    
    //ANSWER ALTERNATIVE VIEWS
    @IBOutlet weak var answerStackView: UIStackView!
    @IBOutlet weak var topAnswerStackView: UIStackView!
    @IBOutlet weak var bottomAnswerStackView: UIStackView!
    @IBOutlet weak var answerAlternativeOne: UIButton!
    @IBOutlet weak var answerAlternativeTwo: UIButton!
    @IBOutlet weak var answerAlternativeThree: UIButton!
    @IBOutlet weak var answerAlternativeFour: UIButton!
    
    
    

    
    //ADDITIONAL DESIGN
    let hexColor = HexColorToUIColor()
    var currentLevelColor = String()
    var nextLevelColor = String()
    var countdownAnimation = UIViewPropertyAnimator()
    var progressBarAnimation = UIViewPropertyAnimator()
    
    //LEVELS.
    var difficulties = [DifficultiesStruct]()
    var currentDifficulty = DifficultiesStruct()
    var numberOfQuestions = Int()
    var questionNumber = Int()
    
    //QUESTIONS.
    var alphabet = [String]()
    var letters = [String]()
    var listOfSteps = [Int]()
    var numberOfSteps = Int()
    var questionTextString = String()
    var randomLetter = String()
    var correctAnswer = String()
    var pickedAnswer = String()
    
    //PROGRESS.
    var amountOfLives = Int()
    var correctAnswers = Int()
    var highscore = Int()
    


    //SET GENERAL DATA.
    func setup() {
        
        alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
        amountOfLives = 3
        highscore = UserDefaults.standard.integer(forKey: "highscore")
        
        setupLevels()
        
        setupAdditionalViews()
        countdownAnimations()
        progressBarAnimations()
        
        
        
        amountOfLivesLabel.text = "\(amountOfLives)"
        markHighscore()
        
    }
    
    /*---  LEVEL CONTROLLERS   -----------------------------------------------------------*/
    
    //CREATE NEW LEVEL.
    func createLevel() {
        
        var levelNumber = 1
        var scoreToBeat = 10
        let amountOfTime = 10.0
        let extraTime = 3.0
        
        if difficulties.isEmpty {
            
            difficulties.append(DifficultiesStruct(levelNumber: levelNumber, scoreToBeat: scoreToBeat, amountOfTime: amountOfTime, extraTime: extraTime))
            
        } else {
            
            levelNumber = difficulties.last!.levelNumber + 1
            scoreToBeat = difficulties.last!.scoreToBeat + 10
            
            difficulties.append(DifficultiesStruct(levelNumber: levelNumber, scoreToBeat: scoreToBeat, amountOfTime: amountOfTime, extraTime: extraTime))
            
        }
    }
    
    //SETUP LEVELS.
    func setupLevels() {
        
        if difficulties.isEmpty {
            createLevel()
            createLevel()
        } else {
            createLevel()
        }
        
        let currentLevelIndex = difficulties.count - 2
        let nextLevelIndex = difficulties.count - 1
        
        currentDifficulty = difficulties[currentLevelIndex]
        
        numberOfQuestions = currentDifficulty.scoreToBeat - correctAnswers

        scoreToBeat.text = "\(currentDifficulty.scoreToBeat)"
        scoreToBeat2.text = "\(difficulties[nextLevelIndex].scoreToBeat)"
        
        
        if currentDifficulty.levelNumber == 1 {
            
            listOfSteps = [1]
            
            progressbarMainDefaultProgress.backgroundColor = UIColor.clear
            currentLevelColor = "#98bc76"   //Green
            nextLevelColor = "#98bc76"  //Green
            
        } else if currentDifficulty.levelNumber == 2 {
            
            listOfSteps = [2]
            
            progressbarMainDefaultProgress.backgroundColor = hexColor.convertHexColor(hexColor: "#98bc76")
            currentLevelColor = "#98bc76"   //Green
            nextLevelColor = "#80b8e9"  //Blue
            
        } else if currentDifficulty.levelNumber == 3 {
            
            listOfSteps = [-1]
            
            progressbarMainDefaultProgress.backgroundColor = hexColor.convertHexColor(hexColor: "#80b8e9")
            currentLevelColor = "#80b8e9"   //Blue
            nextLevelColor = "#80b8e9"  //Blue
            
        } else if currentDifficulty.levelNumber == 4 {
            
            listOfSteps = [-2]
            
            progressbarMainDefaultProgress.backgroundColor = hexColor.convertHexColor(hexColor: "#80b8e9")
            currentLevelColor = "#80b8e9"   //Blue
            nextLevelColor = "#7637a0"  //Purple
            
        } else if currentDifficulty.levelNumber == 5 {
            
            listOfSteps = [-3]
            
            progressbarMainDefaultProgress.backgroundColor = hexColor.convertHexColor(hexColor: "#7637a0")
            currentLevelColor = "#7637a0"   //Purple
            nextLevelColor = "#7637a0"  //Purple
            
        } else if currentDifficulty.levelNumber == 6 {
            
            listOfSteps = [-4]
            
            progressbarMainDefaultProgress.backgroundColor = hexColor.convertHexColor(hexColor: "#7637a0")
            currentLevelColor = "#7637a0"   //Purple
            nextLevelColor = "#710c10"  //Red
            
        } else if currentDifficulty.levelNumber == 7 {
            
            listOfSteps = [-3, -4]
            
            progressbarMainDefaultProgress.backgroundColor = hexColor.convertHexColor(hexColor: "#710c10")
            currentLevelColor = "#710c10"   //Red
            nextLevelColor = "#710c10"  //Red
            currentDifficulty.extraTime = 2.0
            
        } else {
            
            listOfSteps = [-4, -3, -2, 3, 4]
            
            progressbarMainDefaultProgress.backgroundColor = hexColor.convertHexColor(hexColor: "#710c10")
            currentLevelColor = "#710c10"   //Red
            nextLevelColor = "#710c10"  //Red
            currentDifficulty.extraTime = 2.0
            
        }
        
        progressbarMainTracker.backgroundColor = hexColor.convertHexColor(hexColor: currentLevelColor)
        progressbarExtensionTracker.backgroundColor = hexColor.convertHexColor(hexColor: nextLevelColor)
        
    }

    
    
    /*--- QUIZ DATA GETTERS  -----------------------------------------------------------*/
    
    //GET RANDOM LETTER.
    func getQuestion() {
        
        if letters.isEmpty {
            
            letters.append(contentsOf: alphabet)
            
        }
        
        randomLetter = getRandomElementFromList(array: letters)
        
        if let a = letters.firstIndex(of: randomLetter) {
            letters.remove(at: a)
        }
        
        switch numberOfSteps {
        case 1:
            
            questionTextString = "Which letter is after"
            
        case -1:
            
            questionTextString = "Which letter is before"
            
        case 2:
            
            questionTextString = "Which letter is two steps after"
            
        case -2:
            
            questionTextString = "Which letter is two steps before"
            
        case 3:
            
            questionTextString = "Which letter is three steps after"
            
        case -3:
            
            questionTextString = "Which letter is three steps before"
            
        case 4:
            
            questionTextString = "Which letter is four steps after"
            
        case -4:
            
            questionTextString = "Which letter is four steps before"
            
            
        default:
            
            print("")
            
        }
        
        questionLabel.text = questionTextString + " " + randomLetter + "?"
    }
    
    //GET CORRECT ANSWER.
    func getCorrectAnswer() {
        
        var loopControl1 = true
        
        while loopControl1 {
            
            if let x = getElementAccordingToElementInList(array: alphabet, steps: numberOfSteps, element: randomLetter) {
                
                correctAnswer = x
                loopControl1 = false
                
            } else {
                
                getQuestion()
                
            }
        }
    }
    
    //GET ANSWER ALTERNATIVES.
    func getAnswerAlternatives() {
        
        var answerAlternatives = [String]()
        
        //Get three random elements from list.
        for _ in 1...3 {
            
            var loopControl2 = true
            
            while loopControl2 {
                
                let a = getRandomElementFromList(array: alphabet)
                
                if !answerAlternatives.contains(a) && a != randomLetter && a != correctAnswer {
                    
                    answerAlternatives.append(a)
                    loopControl2 = false
                }
            }
        }
        
        
        //Insert correct answer at random index.
        let index = Int(arc4random_uniform(UInt32(answerAlternatives.count + 1)))
        answerAlternatives.insert(correctAnswer, at: index)
        
        answerAlternativeOne.setTitle(answerAlternatives[0], for: .normal)
        answerAlternativeTwo.setTitle(answerAlternatives[1], for: .normal)
        answerAlternativeThree.setTitle(answerAlternatives[2], for: .normal)
        answerAlternativeFour.setTitle(answerAlternatives[3], for: .normal)
        
    }
    

    /*--- MAIN GAME CONTROLLERS   -----------------------------------------------------------*/
    
    //SET QUIZ DATA.
    func setupQuiz() {
        
        let randomStep = Int(arc4random_uniform(UInt32(listOfSteps.count)))
        numberOfSteps = listOfSteps[randomStep]
        
        getQuestion()
        getCorrectAnswer()
        getAnswerAlternatives()
        
        updateQuestionNumber()
        
    }
    
    //CHECK GIVEN ANSWER.
    func check() {
        
        //Check answer.
        if pickedAnswer == correctAnswer {
            
            increaseProgress()
            updateCountdown()
            
        } else {
            
            decreaseLives()
            
        }
        
        //Check if level is beat, game over or continue..
        if correctAnswers == currentDifficulty.scoreToBeat {
            
            countdownAnimation.pauseAnimation()
            
            answerStackView.isUserInteractionEnabled = false
            answerStackView.isHidden = true
            questionLabel.isHidden = true

            
            currentScore2.text = "\(correctAnswers)"
            
            progressBarAnimations()
            progressBarAnimation.startAnimation()
            
        } else if amountOfLives > 0 {
        
            setupQuiz()
                
        } else {
                
            gameOver()
                
        }
    }
    
    
    //GAME OVER: SHOW BEFORE AD VIEW OR RESULTS.
    func gameOver() {
        
        self.performSegue(withIdentifier: "showResultsView", sender: nil)
            
    }

    
 
    
    /*--- SUB FUNCTIONS   -----------------------------------------------------------*/
    
    //UPDATE CURRENT QUESTION.
    func updateQuestionNumber() {
        
        questionNumber = (correctAnswers - (currentDifficulty.scoreToBeat - 10)) + 1
        
    }
    
    //UPDATE PROGRESSBAR.
    func increaseProgress() {
        
        progressbarMainPointStackView.arrangedSubviews[questionNumber - 1].layer.backgroundColor = hexColor.convertHexColor(hexColor: currentLevelColor).cgColor
    
        correctAnswers += 1
        currentScore.text = "\(correctAnswers)"
        
    }
    
    //DECREASE AMOUNT OF LIVES.
    func decreaseLives() {
        
        amountOfLives -= 1
        amountOfLivesLabel.text = "\(amountOfLives)"
        
    }
    
    //PROGRESSBAR: MARK HIGHSCORE.
    func markHighscore() {
        
        //MARK IN MAIN PROGRESSBAR
        if (correctAnswers + 1...currentDifficulty.scoreToBeat).contains(highscore) {
            
            let indexA = highscore - (currentDifficulty.scoreToBeat - 10)
            
            progressbarMainPointStackView.arrangedSubviews[indexA - 1].layer.backgroundColor = hexColor.convertHexColor(hexColor: "#ebb93e").cgColor
            
        }
        
        //MARK IN EXTENDED PROGRESSBAR
        if (currentDifficulty.scoreToBeat + 1...difficulties.last!.scoreToBeat).contains(highscore) {
            
            let indexB = highscore - (difficulties.last!.scoreToBeat - 10)
            
            progressbarExtensionPointStackView.arrangedSubviews[indexB - 1].layer.backgroundColor = hexColor.convertHexColor(hexColor: "#ebb93e").cgColor
            
        }
    }
    

    
    /*--- CORE SETTINGS   -----------------------------------------------------------*/
    
    //VIEWDIDLOAD.
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(exitGame), name: UIApplication.willResignActiveNotification, object: nil)
        
        setup()
        setupQuiz()
    
    }

    //VIEWDIDAPPEAR.
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(true)
        countdownAnimation.pauseAnimation()
        countdownAnimation.startAnimation()
        
    }
    
    //HIDE STATUSBAR.
    override var prefersStatusBarHidden: Bool {
        
        return true
        
    }
    
    //SEND DATA TO RESULTS VIEWCONTROLLER.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showResultsView" {
            
            let view = segue.destination as! ResultsViewController
            view.correctAnswers = correctAnswers
            view.highscore = highscore
            
    }}
    
    //BUTTON: ANSWER ALTERNATIVE WAS PRESSED.
    @IBAction func answerButtonPressed(_ sender: AnyObject) {
        
        switch sender.tag {
        case 1:
            
            pickedAnswer = answerAlternativeOne.currentTitle!
            
        case 2:
            
            pickedAnswer = answerAlternativeTwo.currentTitle!
            
        case 3:
            
            pickedAnswer = answerAlternativeThree.currentTitle!
            
        case 4:
            
            pickedAnswer = answerAlternativeFour.currentTitle!
    
        default:
            
            pickedAnswer = ""
            
        }
        
        check()
    }
    
    //EXIT GAME.
    @objc func exitGame() {
        
        if correctAnswers > highscore {
            UserDefaults.standard.set(correctAnswers, forKey: "highscore")
        }
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "startmenuView") as! StartmenuViewController
        self.present(viewController, animated:true, completion:nil)
    }

    
    /*--- ADDITIONAL DESIGN   -----------------------------------------------------------*/
    
    func setupAdditionalViews() {
        
        let myCornerRadius = 5.0
        let myBorderWidth = 0.5
        let myBorderColor = "#000000"
        
        
        
        for _ in 1...numberOfQuestions {
            
            let newView = UIView()
            newView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 10).isActive = true
            
            let newView2 = UIView()
            newView2.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 10).isActive = true
            
            progressbarMainPointStackView.addArrangedSubview(newView)
            progressbarExtensionPointStackView.addArrangedSubview(newView2)
            
        }
        
        mainProgressTrackerWidth.constant = UIScreen.main.bounds.width / 10
        extendedProgressTrackerWidth.constant = UIScreen.main.bounds.width / 10
        
        progressbarMainDefaultProgress.layer.cornerRadius = myCornerRadius
        progressbarMainDefaultProgress.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        
        progressbarMainTracker.layer.cornerRadius = myCornerRadius
        progressbarExtensionTracker.layer.cornerRadius = myCornerRadius
        
        countdownBar.layer.cornerRadius = myCornerRadius
        countdownContainer.layer.cornerRadius = myCornerRadius
        countdownContainer.layer.borderWidth = myBorderWidth
        countdownContainer.layer.borderColor = hexColor.convertHexColor(hexColor: myBorderColor).cgColor
        
        
        for i in progressbarMainPointStackView.arrangedSubviews {
            
            i.layer.cornerRadius = myCornerRadius
            i.layer.borderWidth = myBorderWidth
            i.layer.borderColor = hexColor.convertHexColor(hexColor: myBorderColor).cgColor
        }
        
        for i in progressbarExtensionPointStackView.arrangedSubviews {
            
            i.layer.cornerRadius = myCornerRadius
            i.layer.borderWidth = myBorderWidth
            i.layer.borderColor = hexColor.convertHexColor(hexColor: myBorderColor).cgColor
        }
        
        for i in topAnswerStackView.arrangedSubviews {
            
            i.layer.cornerRadius = myCornerRadius
            i.layer.borderWidth = myBorderWidth
            i.layer.borderColor = hexColor.convertHexColor(hexColor: myBorderColor).cgColor
            
        }
        
        for i in bottomAnswerStackView.arrangedSubviews {
            
            i.layer.cornerRadius = myCornerRadius
            i.layer.borderWidth = myBorderWidth
            i.layer.borderColor = hexColor.convertHexColor(hexColor: myBorderColor).cgColor
            
        }
        
        self.view.layoutIfNeeded()
        
    }
    

    
    //ADDITIONAL DESIGN: REMOVE PROGRESS COLOR.
    func removeProgressColor() {
        
        for i in self.progressbarMainPointStackView.arrangedSubviews {
            
            i.layer.backgroundColor = UIColor.clear.cgColor
            
        }
        
        for i in self.progressbarExtensionPointStackView.arrangedSubviews {
            
            i.layer.backgroundColor = UIColor.clear.cgColor
            
        }
    }
    






    /*---  ANIMATIONS   -----------------------------------------------------------*/

    //ANIMATION: PROGRESSBAR FORWARD.
    func progressBarAnimations() {
        
        progressBarAnimation = UIViewPropertyAnimator(duration: 1.5, curve: .linear)
        
        progressBarAnimation.addAnimations {
            
            self.progressbarPosition.constant -= (self.progressbarMainView.frame.width - 5)
            self.view.layoutIfNeeded()
            
        }
        
        progressBarAnimation.addCompletion {_ in
            
            self.progressbarPosition.constant = 0
            self.view.layoutIfNeeded()
            //ADDIDTIONAL UPDATES
            self.removeProgressColor()
            self.setupLevels()
            self.setupQuiz()
            self.markHighscore()
            self.answerStackView.isHidden = false
            self.questionLabel.isHidden = false
            self.answerStackView.isUserInteractionEnabled = true
            self.countdownAnimation.startAnimation()
        
        }}

    //ANIMATION: COUNTDOWN BAR.
    func countdownAnimations() {
        
        let distance = countdownContainer.frame.width / 2
        
        countdownAnimation = UIViewPropertyAnimator(duration: currentDifficulty.amountOfTime, curve: .linear)
        countdownAnimation.pausesOnCompletion = true
        countdownAnimation.addObserver(self, forKeyPath: "running", options: [.new], context: nil)
        

        countdownAnimation.addAnimations {
            
            UIView.animateKeyframes(withDuration: self.currentDifficulty.amountOfTime, delay: 0, options: [.calculationModeLinear], animations: {
                
                UIView.addKeyframe(withRelativeStartTime: 0,  relativeDuration: 0.5) {
                    
                    self.countdownbarWidth.constant -= distance
                    self.countdownBar.backgroundColor = self.hexColor.convertHexColor(hexColor: "#ebb93e")
                    self.view.layoutIfNeeded()
                    
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                    
                    self.countdownbarWidth.constant -= distance
                    self.countdownBar.backgroundColor = self.hexColor.convertHexColor(hexColor: "#ff4757")
                    self.view.layoutIfNeeded()
    }})}}
    
    
    //ANIMATION: UPDATE COUNTDOWNBAR.
    func updateCountdown() {
        
        let fractionPerExtraTime = (1.0/currentDifficulty.amountOfTime)*currentDifficulty.extraTime
        let fractionOnStop = Double(countdownAnimation.fractionComplete)
        var fractionOnContinue = fractionOnStop - fractionPerExtraTime
        
        if fractionOnContinue < 0 {
            
            fractionOnContinue = 0
            
        }
        
        countdownAnimation.pauseAnimation()
        countdownAnimation.fractionComplete = CGFloat(fractionOnContinue)
        countdownAnimation.startAnimation()
        
    }

    //ANIMATION: COUNTDOWN IS FINISHED.
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if !countdownAnimation.isRunning && countdownAnimation.fractionComplete == 1 {
            
            if amountOfLives > 0 {
                
                decreaseLives()
                
            }
            
            if amountOfLives == 0 {
                
                gameOver()
                
            } else {
                
                countdownAnimation.pauseAnimation()
                countdownAnimation.fractionComplete = 0
                countdownAnimation.startAnimation()
    }}}
    
}
