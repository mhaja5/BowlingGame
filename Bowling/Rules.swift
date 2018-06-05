//
//  Rules.swift
//  Bowling
//
//  Created by Haja Masood on 2018-06-04.
//  Copyright © 2018 hajamasood. All rights reserved.
//

import Foundation

enum Hit {
    case strike
    case spare
    case miss
    case undefined
}

struct Result {
    var result: Hit
    var frameEnds: Bool
    var points: Int
    var bonusBalls: Int
}

class Rules {
    
    static func getResult(tenthFrame: Bool, frame: Frame?, ball1Score:Int, ball2Score:Int, ballNumber: Int, pinsDown: Int) -> Result {
        let ballsScore = ball1Score + ball2Score
        if let frame = frame, tenthFrame == true {
            if ballNumber == 1 && pinsDown == 10 {
                return Result(result: .strike, frameEnds: false, points: pinsDown, bonusBalls: 2)
            }
            else if ballNumber == 2 && pinsDown == 10 {
                return Result(result: .spare, frameEnds: false, points: pinsDown, bonusBalls: 1)
            }
            else if ballNumber == 1 && pinsDown < 10 {
                return Result(result: .undefined, frameEnds: false, points: pinsDown, bonusBalls: 0)
            }
            else if ballNumber == 2 && pinsDown < 10 {
                return Result(result: .undefined, frameEnds: true, points: pinsDown, bonusBalls: 0)
            }
            else if ballNumber == 3 && (frame.getScoresForBall(0) == 10 || frame.getScoresForBall(1) == 10) {
                return Result(result: .undefined, frameEnds: true, points: pinsDown, bonusBalls: 0)
            }
            else if ballNumber == 4 && frame.getScoresForBall(0) == 10 {
                return Result(result: .undefined, frameEnds: false, points: pinsDown, bonusBalls: 0)
            }
        }
        else if ballNumber == 1 && pinsDown == 10 {
            return Result(result: .strike, frameEnds: true, points: 10, bonusBalls: 0)
        }
        else if ballNumber == 2 && pinsDown == 10 {
            return Result(result: .spare, frameEnds: true, points: 10, bonusBalls: 0)
        }
        else if ballNumber == 2 && ballsScore >= 10 {
            return Result(result: .spare, frameEnds: true, points: 10, bonusBalls: 0)
        }
        else {
            return Result(result: .miss, frameEnds: ballNumber == 2, points: pinsDown, bonusBalls: 0)
        }
        
        return Result(result: .miss, frameEnds: ballNumber == 2, points: pinsDown, bonusBalls: 0)
    }
    
    
}
