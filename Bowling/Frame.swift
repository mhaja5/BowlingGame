//
//  Frame.swift
//  Bowling
//
//  Created by Haja Masood on 2018-06-04.
//  Copyright © 2018 hajamasood. All rights reserved.
//

import Foundation

class Frame {
    //MARK: Properties
    let maxBalls: Int = 2
    private var scoresByBall = [Int]()
    private var currentBall: Int = 0
    
    //MARK: Methods
    func setScore(pinsDown: Int, tenthFrame: Bool) -> Bool {
        currentBall += 1
        let rulesResult = Rules.getResult(tenthFrame: tenthFrame == true, frame: self, ball1Score: self.getScoresForBall(0) ?? 0, ball2Score: self.getScoresForBall(1) ?? 0, ballNumber: currentBall, pinsDown: pinsDown)
        if currentBall < scoresByBall.count {
            scoresByBall[currentBall] = pinsDown
        }
        else {
            scoresByBall.append(pinsDown)
        }
        return rulesResult.frameEnds
    }
        
    func getScoresByBall() -> [Int] {
        return scoresByBall
    }

    func getScoresForBall(_ num: Int ) -> Int? {
        if num < scoresByBall.count {
            return scoresByBall[num]
        }
        return nil
    }

    func ballsBowled() -> Int {
        return currentBall
    }
}
