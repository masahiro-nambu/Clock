//
//  ViewController.swift
//  Clock
//
//  Created by 山口智生 on 2015/10/19.
//  Copyright © 2015年 Tomoki Yamaguchi. All rights reserved.
//

import UIKit

/** Xcode 7用、Swift 2.0、iOS8.0以上 */
class ViewController: UIViewController {
    
    @IBOutlet var hour10ImageView: UIImageView!
    @IBOutlet var hour1ImageView: UIImageView!
    
    @IBOutlet var minute10ImageView: UIImageView!
    @IBOutlet var minute1ImageView: UIImageView!
    
    @IBOutlet var second10ImageView: UIImageView!
    @IBOutlet var second1ImageView: UIImageView!
    
    // 背景
    @IBOutlet var backgroundImageView: UIImageView!
    
    
    // 現在のNSDate
    var currentDate: NSDate! = nil
    
    let numberImage = [
        UIImage(named: "0.png"),
        UIImage(named: "1.png"),
        UIImage(named: "2.png"),
        UIImage(named: "3.png"),
        UIImage(named: "4.png"),
        UIImage(named: "5.png"),
        UIImage(named: "6.png"),
        UIImage(named: "7.png"),
        UIImage(named: "8.png"),
        UIImage(named: "9.png"),
    ]
    
    var updateTimer: NSTimer! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1秒ごとにself.onUpdate()を呼び出すように設定
        if updateTimer == nil {
            updateTimer = NSTimer.scheduledTimerWithTimeInterval(
                1.0,
                target: self,
                selector: Selector("onUpdate"),
                userInfo: nil,
                repeats: true
            )
        }
        
        // はじめに一回だけ更新しておく
        updateCurrentTime()
        updateView()
    }
    
    /** 1秒ごとに呼ばれる */
    func onUpdate(){
        updateCurrentTime()
        updateView()
    }
    
    /** 現在時刻を更新 */
    func updateCurrentTime() {
        currentDate = NSDate()
    }
    
    /** place(=10^n)の位の値を取得(10進数) */
    func calcNumberAtPlace(number: Int, _ place: Int) -> Int {
        return (number/place)%10
    }
    
    /** 画面に反映 */
    func updateView() {
        // 西暦カレンダーを用いて、currentDateから、必要な情報を抽出
        let calender = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let components = calender!.components([.Hour, .Minute, .Second], fromDate: currentDate)
        
        // 時、分、秒に分割
        let hour:   Int = components.hour
        let minute: Int = components.minute
        let second: Int = components.second
        
        // 10の位と1の位に分ける
        let hour10 = calcNumberAtPlace(hour, 10)
        let hour1  = calcNumberAtPlace(hour, 1)
        
        let minute10 = calcNumberAtPlace(minute, 10)
        let minute1  = calcNumberAtPlace(minute, 1)
        
        let second10 = calcNumberAtPlace(second, 10)
        let second1  = calcNumberAtPlace(second, 1)
        
        // 画像をセット
        hour10ImageView.image = numberImage[hour10]
        hour1ImageView.image = numberImage[hour1]
        
        minute10ImageView.image = numberImage[minute10]
        minute1ImageView.image = numberImage[minute1]
        
        second10ImageView.image = numberImage[second10]
        second1ImageView.image = numberImage[second1]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

