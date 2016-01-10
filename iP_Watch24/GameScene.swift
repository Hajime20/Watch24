//
//  GameScene.swift
//  iP_Watch24
//
//  Created by Hisa28a on 2015/05/07.
//  Copyright (c) 2015年 HajimeH. All rights reserved.

import SpriteKit

class GameScene: SKScene {
    
    var colori = 1
    
    //イラスト用スプライト
    let path1Sprite = SKSpriteNode(imageNamed: "path1.png")
    let secondSprite = SKSpriteNode(imageNamed: "second_hand.png")
    let minuteSprite = SKSpriteNode(imageNamed: "minute_hand1.png")
    let hourSprite = SKSpriteNode(imageNamed: "hour_hand.png")
    
    //現在時刻を取得.ここに書くと、その時の時間で変化しない
    //let timeNow: NSDate = NSDate()
    
    override func didMoveToView(view: SKView) {
        
        //背景色
        backgroundColor = SKColor.blackColor()
        
        // 文字盤　針
        path1Sprite.position = CGPoint(x: CGRectGetMidX(self.frame),
            y: CGRectGetMidY(self.frame) + 100)
        secondSprite.position = CGPoint(x: CGRectGetMidX(self.frame),
            y: CGRectGetMidY(self.frame) + 100)
        minuteSprite.position = CGPoint(x: CGRectGetMidX(self.frame),
            y: CGRectGetMidY(self.frame) + 100)
        hourSprite.position = CGPoint(x: CGRectGetMidX(self.frame),
            y: CGRectGetMidY(self.frame) + 100)
        
        //サイズ調整
        path1Sprite.size = CGSize(width: path1Sprite.size.width * 0.6,
            height: path1Sprite.size.height * 0.6)
        secondSprite.size = CGSize(width: secondSprite.size.width * 0.6,
            height: secondSprite.size.height * 0.6)
        minuteSprite.size = CGSize(width: minuteSprite.size.width * 0.6,
            height: minuteSprite.size.height * 0.6)
        hourSprite.size = CGSize(width: hourSprite.size.width * 0.6,
            height: hourSprite.size.height * 0.6)
        
        
        //********
        
        self.addChild(path1Sprite)
        self.addChild(secondSprite)
        self.addChild(hourSprite)
        self.addChild(minuteSprite)
        
        
        //0.1  今は２秒
        var Timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self,
            selector: Selector("TimeMove"), userInfo: nil, repeats: true)
    }
    
    //********
    /*
    度数からラジアンに変換するメソッド
    */
    func DegreeToRadian(Degree : Double!)-> CGFloat{
        return CGFloat(Degree) / CGFloat(180.0 * M_1_PI)
    }
    
    
    func TimeMove(){
        let timeNow: NSDate = NSDate()
        //println("Time: \(timeNow)")
        
        //取得するコンポーネントを決める.
        //カレンダーを取得.
        let myCalendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        //取得するコンポーネントを決める.
        let myComponetns = myCalendar.components(
            [NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second] ,
            fromDate: timeNow)
        
        //
        // var sec:CGFloat = (CGFloat(M_PI) * 2 * CGFloat(myComponetns.second))/60
        let sec:CGFloat = (CGFloat(M_PI) * CGFloat(myComponetns.second))/30
        let mi:CGFloat = (CGFloat(M_PI) * CGFloat(myComponetns.minute))/30
        let ho:CGFloat = (CGFloat(M_PI) * CGFloat(myComponetns.hour ))/12 + CGFloat(M_PI) + (CGFloat(myComponetns.minute) * CGFloat(M_PI)/720)
        
        let action = SKAction.rotateToAngle(-sec, duration: 0)
        secondSprite.runAction(action)
        let actionm = SKAction.rotateToAngle(-mi, duration: 0)
        minuteSprite.runAction(actionm)
        let actionh = SKAction.rotateToAngle(-ho, duration: 0)
        hourSprite.runAction(actionh)
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let touchNode = self.nodeAtPoint(location)
            
            if touchNode == path1Sprite {
                
                if colori == 1 {
                    backgroundColor = SKColor.whiteColor()
                    colori = 0
                } else{
                    backgroundColor = SKColor.blackColor()
                    colori = 1
                }
                
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
