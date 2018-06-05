//
//  BowlingTests.swift
//  BowlingTests
//
//  Created by Haja Masood on 2018-06-04.
//  Copyright © 2018 hajamasood. All rights reserved.
//

import XCTest
@testable import Bowling

class BowlingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    

    func testFrameNumber() {
        let bowlingScorer = BowlingScorer()
        _ = bowlingScorer.roll(pinsDown: 9)
        _ = bowlingScorer.roll(pinsDown: 1)
        _ = bowlingScorer.roll(pinsDown: 0)
        _ = bowlingScorer.roll(pinsDown: 10)
        _ = bowlingScorer.roll(pinsDown: 10)
        _ = bowlingScorer.roll(pinsDown: 10)
        _ = bowlingScorer.roll(pinsDown: 6)
        _ = bowlingScorer.roll(pinsDown: 2)
        _ = bowlingScorer.roll(pinsDown: 7)

        let num = bowlingScorer.frameNumber()
        XCTAssertTrue(num == 6)
    }
    
    func testScoreSoFar() {
        let bowlingScorer = BowlingScorer()
        _ = bowlingScorer.roll(pinsDown: 9)
        _ = bowlingScorer.roll(pinsDown: 1)
        _ = bowlingScorer.roll(pinsDown: 0)
        _ = bowlingScorer.roll(pinsDown: 10)
        _ = bowlingScorer.roll(pinsDown: 10)
        _ = bowlingScorer.roll(pinsDown: 10)
        _ = bowlingScorer.roll(pinsDown: 6)
        _ = bowlingScorer.roll(pinsDown: 2)
        _ = bowlingScorer.roll(pinsDown: 7)
        _ = bowlingScorer.roll(pinsDown: 3)
        _ = bowlingScorer.roll(pinsDown: 8)
        _ = bowlingScorer.roll(pinsDown: 2)
        _ = bowlingScorer.roll(pinsDown: 10)
        _ = bowlingScorer.roll(pinsDown: 9)
        _ = bowlingScorer.roll(pinsDown: 0)
        _ = bowlingScorer.roll(pinsDown: 10)
        _ = bowlingScorer.roll(pinsDown: 10)
        _ = bowlingScorer.roll(pinsDown: 8)

        let totalScore = bowlingScorer.scoreSoFar()
        XCTAssertTrue(totalScore == 176)
    }
    
    func testGameIsOver() {
        let bowlingScorer = BowlingScorer()
        for _ in 0..<20 {
           _ = bowlingScorer.roll(pinsDown: 2)
        }
        XCTAssertTrue(bowlingScorer.gameIsOver() == true)
    }
    
    func testGameIsNotOver() {
        let bowlingScorer = BowlingScorer()
        for _ in 0..<10 {
            _ = bowlingScorer.roll(pinsDown: 2)
        }
        XCTAssertTrue(bowlingScorer.gameIsOver() == false)
    }

    
    func testRoll() {
        let bowlingScorer = BowlingScorer()
        _ = bowlingScorer.roll(pinsDown: 9)
        _ = bowlingScorer.roll(pinsDown: 1)
        _ = bowlingScorer.roll(pinsDown: 0)
        _ = bowlingScorer.roll(pinsDown: 10)
        _ = bowlingScorer.roll(pinsDown: 10)
        _ = bowlingScorer.roll(pinsDown: 10)
        _ = bowlingScorer.roll(pinsDown: 6)
        _ = bowlingScorer.roll(pinsDown: 2)
        _ = bowlingScorer.roll(pinsDown: 7)
        let frames = bowlingScorer.roll(pinsDown: 3)

        XCTAssertTrue(frames?.count == 7
            && bowlingScorer.scoreForFrame(frameNum: 4)! == 8)

    }
    
    
    func testBallsBowledInFrame() {
        let bowlingScorer = BowlingScorer()
        _ = bowlingScorer.roll(pinsDown: 9)
        let frames = bowlingScorer.roll(pinsDown: 1)
        XCTAssertTrue(frames?[0].ballsBowled() == 2)
    }
    
    func testGetScoreForFrame() {
        let bowlingScorer = BowlingScorer()
        _ = bowlingScorer.roll(pinsDown: 9)
        _ = bowlingScorer.roll(pinsDown: 1)
        _ = bowlingScorer.roll(pinsDown: 0)
        _ = bowlingScorer.roll(pinsDown: 10)
        _ = bowlingScorer.roll(pinsDown: 10)
        _ = bowlingScorer.roll(pinsDown: 6)
        _ = bowlingScorer.roll(pinsDown: 2)
        _ = bowlingScorer.roll(pinsDown: 7)
        let frames = bowlingScorer.roll(pinsDown: 3)
        
        XCTAssertTrue(
            frames?.count == 6
            && bowlingScorer.scoreForFrame(frameNum: 0) == 10
            && bowlingScorer.scoreForFrame(frameNum: 1) == 20
        )
    }

    
    func testGetScoreForBall() {
        let bowlingScorer = BowlingScorer()
        _ = bowlingScorer.roll(pinsDown: 9)
        _ = bowlingScorer.roll(pinsDown: 1)
        _ = bowlingScorer.roll(pinsDown: 0)
        _ = bowlingScorer.roll(pinsDown: 10)
        _ = bowlingScorer.roll(pinsDown: 10)
        _ = bowlingScorer.roll(pinsDown: 6)
        _ = bowlingScorer.roll(pinsDown: 2)
        _ = bowlingScorer.roll(pinsDown: 7)
        let frames = bowlingScorer.roll(pinsDown: 3)
        
        XCTAssertTrue(frames?[0].getScoresForBall(0)! == 9 && frames?[0].getScoresForBall(1)! == 1)

    }
        
}
