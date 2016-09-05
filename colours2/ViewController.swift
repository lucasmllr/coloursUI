//
//  ViewController.swift
//  colours2
//
//  Created by Lucas Moeller on 10.08.16.
//  Copyright © 2016 Lucas Moeller. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var blueSlider: UISlider!
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var randomButton: UIButton!
    @IBOutlet var discoSwitch: UISwitch!
    
    var randomTimer: NSTimer?
    
    var greenPart: Float = 0
    var bluePart: Float = 0
    var redPart: Float = 0
    
    var greenNorm:Float = 0
    var blueNorm: Float = 0
    var redNorm: Float = 0
    
    func normalizeColor() {
        let sum = greenPart + bluePart + redPart
        greenNorm = greenPart / sum
        blueNorm = bluePart / sum
        redNorm = redPart / sum
    }
    
    func updateBackground() {
        self.view.backgroundColor = UIColor(red: CGFloat(redNorm), green: CGFloat(greenNorm), blue: CGFloat(blueNorm), alpha: 1)
    }
    
    func updateSliders() {
        normalizeColor()
        redSlider.value = redNorm
        blueSlider.value = blueNorm
        greenSlider.value = greenNorm
    }
    
    func changeToRandomColor() {
        self.greenPart = Float(arc4random_uniform(1000))
        self.redPart = Float(arc4random_uniform(1000))
        self.bluePart = Float(arc4random_uniform(1000))
        normalizeColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func blueSliderChanged(sender: UISlider) {
        bluePart = sender.value
        normalizeColor()
        updateBackground()
        updateSliders()
    }
    
    @IBAction func redSliderChanged(sender: UISlider) {
        redPart = sender.value
        normalizeColor()
        updateBackground()
        updateSliders()
    }
    
    @IBAction func greenSliderChanged(sender: UISlider) {
        greenPart = sender.value
        normalizeColor()
        updateBackground()
        updateSliders()
    }
    
    @IBAction func randomButtonPressed(sender: AnyObject) {
        changeToRandomColor()
        normalizeColor()
        updateBackground()
        updateSliders()
    }
    
    @IBAction func discoSwitchChanged(sender: UISwitch) {
        if sender.on {
            randomTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: (#selector(ViewController.randomButtonPressed(_:))), userInfo: nil, repeats: true)
        } else {
            randomTimer?.invalidate()
        }
    }
    
}

