//
//  ProgressStruct.swift
//  LetterQuiz
//
//  Created by Martin Bruland on 27/05/2019.
//  Copyright © 2019 Martin Bruland. All rights reserved.
//

import UIKit

struct DifficultiesStruct: Codable {
    
    var levelNumber = Int()
    var scoreToBeat = Int()
    var amountOfTime = Double()
    var extraTime = Double()
    
}
