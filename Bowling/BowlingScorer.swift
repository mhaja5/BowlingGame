//
//  BowlingScorer.swift
//  Bowling
//
//  Created by Haja Masood on 2018-06-04.
//  Copyright © 2018 hajamasood. All rights reserved.
//

import Foundation

class BowlingScorer {
    
    private var currentBall: Int
    private var totalScore: Int
    private var frames: [Frame]
    private var currentFrame: Frame = Frame()
    
    /**
     Constructor method
     */
    init() {
        self.currentBall = 0
        self.totalScore = 0
        self.frames = [Frame]()
        createNewFrame()
    }
    
    /**
     Frame number method - returns the current frame about to be bowled
     
     */
    func frameNumber() -> Int {
        return frames.count
    }
    
    /**
     scoreSoFar method - returns the total score
     
     */

    func scoreSoFar() -> Int {
        var totalScore = 0
        let framesCount = frames.count
        for i in 0..<framesCount {
            totalScore += self.scoreForFrame(frameNum: i) ?? 0
        }
        return totalScore
    }
    
    /**
     gameIsOver method - return boolen if the game is over
     
     */

    func gameIsOver() -> Bool {
        return frames.count > 10
    }
    
    /**
     roll method
     - pinsDown: Int -  number of pins down with ball rolled
     - returns: [Frame] - an array of frame bowled so far
     */

    func roll(pinsDown: Int) -> [Frame]? {
        if gameIsOver() {
            return nil//cannot roll
        }
        let isFrameEnds = currentFrame.setScore(pinsDown: pinsDown, tenthFrame: frameNumber() == 10)
        if isFrameEnds {
            currentBall = 0 //to advance the frame
            createNewFrame()
        }
        else {
            currentBall += 1
        }
        return frames
    }
    
    /**
     scoreForFrame method
     - frameNum: Int -  frame number for which the score is needed
     - returns: Int - score for the frame,
                nil is returned if invalid frame num is supplied or no balls bowled yet in the frame
     */

    func scoreForFrame(frameNum: Int) -> Int? {
        let frameIndex = frameNum
        if !(frameIndex < frames.count) {
            return nil
        }
        let frame = frames[frameIndex]
        let ballsBowled = frame.ballsBowled()
        var frameScore: Int = 0
        if ballsBowled == 0 {
            return nil
        }
        if frameNum == 10 {
            for ballNum in 0..<ballsBowled {
                let ballScore = frame.getScoresForBall(ballNum) ?? 0
                frameScore += ballScore
            }
        }
        else if frameNum < 10 {
            for ballNum in 0..<ballsBowled {
                let ballScore = frame.getScoresForBall(ballNum) ?? 0
                frameScore += ballScore
                
                //bonus points, if any
                let result0 = Rules.getResult(tenthFrame: false, frame: frame, ball1Score: frame.getScoresForBall(0) ?? 0, ball2Score: frame.getScoresForBall(1) ?? 0, ballNumber: ballNum + 1, pinsDown: ballScore)
                if result0.result == .strike {
                    frameScore += strikeBonusScore(frameIndex: frameIndex)
                }
                else if result0.result == .spare {
                    frameScore += spareBonusScore(frameIndex: frameIndex)
                }
                
            }
            
        }
        
        return frameScore
        
    }
    
    //MARK: Helper Methods
    
    //This method assumes the calling method calls only for strike in a frame
    private func strikeBonusScore(frameIndex: Int) -> Int {
        var bonusScore = 0
        //add score of 2 additional balls
        var index = frameIndex + 1
        if index < frames.count {
            //ball 1
            var nextFrame = frames[index]
            var ballNum = 0
            let ballScore1 = nextFrame.getScoresForBall(ballNum)
            bonusScore += ballScore1 ?? 0
            
            //ball 2
            if ballScore1 == 10 {  //another strike marks frame ends
                index += 1
                if index < frames.count {
                    nextFrame = frames[index]
                }
            }
            else {
                ballNum += 1
            }
            
            let ballScore2 = nextFrame.getScoresForBall(ballNum)
            bonusScore += ballScore2 ?? 0
        }
        return bonusScore
    }
    
    //This method assumes the calling method calls only for spare in a frame
    private func spareBonusScore(frameIndex: Int) -> Int {
        var bonusScore = 0
        //add score of 1 additional ball
        let index = frameIndex + 1
        if index < frames.count {
            //ball 1
            let nextFrame = frames[index]
            let ballNum = 0
            let ballScore1 = nextFrame.getScoresForBall(ballNum)
            bonusScore += ballScore1 ?? 0
        }
        return bonusScore
    }

    /**
     createNewFrame method - creates a new frame and add to the frames array
     
     */

    private func createNewFrame() {
        currentFrame = Frame()
        frames.append(currentFrame)
    }
    
}
