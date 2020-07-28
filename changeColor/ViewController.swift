//
//  ViewController.swift
//  changeColor
//
//  Created by 方芸萱 on 2020/7/27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var apronColor: UIView!
    @IBOutlet weak var flower: UIView!
    @IBOutlet weak var apronView: UIView!
    @IBOutlet weak var skirtView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var showCornerRadius: UILabel!
    @IBOutlet weak var sliderMainViewCornerRadius: UISlider!
    @IBOutlet weak var sliderApronColor: UISlider!
    @IBOutlet weak var sliderApronAlpha: UISlider!
    @IBOutlet weak var button: UIButton!
    var apronColorValue:CGFloat = 0.5
    var apronAlphaValue:CGFloat = 0.5
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //apron
        let apronImageView = UIImageView(image: UIImage(named: "apron"))
        apronImageView.frame = apronView.bounds
        apronView.mask = apronImageView
        apronView.addSubview(flower)//背景圖
        apronColor.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
        apronView.addSubview(apronColor)
        //skirt
        let skirtImageView = UIImageView(image: UIImage(named: "skirt"))
        skirtImageView.frame = skirtView.bounds
        skirtView.mask = skirtImageView
        skirtView.backgroundColor = UIColor.yellow
//        //main view 漸層，會蓋掉整片
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = mainView.bounds
//        gradientLayer.colors = [UIColor.orange.cgColor, UIColor.blue.cgColor]
//        mainView.layer.addSublayer(gradientLayer)
        //Init slider and other
        initSlider()
    }
    func changeApronColorAlpha(){
        apronColor.backgroundColor = UIColor(hue: apronColorValue, saturation: 0.8, brightness: 1, alpha: apronAlphaValue)
    }
    func random(){
        let value = Float.random(in: 0...180)
        showCornerRadius.text = String(format: "%.1f", value)
        mainView.layer.cornerRadius = CGFloat(value)
        sliderMainViewCornerRadius.setValue(value, animated: true)
    }
    func shadow(){
        button.layer.cornerRadius = 40
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.layer.shadowOpacity = 0.8
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.blue.cgColor
    }
    func initSlider(){
        sliderApronColor.setValue(Float(apronColorValue), animated: true)
        sliderApronAlpha.setValue(Float(apronAlphaValue), animated: true)
        changeApronColorAlpha()
        mainView.clipsToBounds = true//圓角功能才會動
        random()
        shadow()
        //skirt HSB color, init red
        skirtView.backgroundColor = UIColor(hue:0, saturation: 0.8, brightness: 1, alpha: 1)
    }
    @IBAction func changeApronColor(_ sender: UISlider) {
        apronColorValue = CGFloat(sender.value)
        changeApronColorAlpha()
    }
    @IBAction func changeApronAlpha(_ sender: UISlider) {
        apronAlphaValue = CGFloat(sender.value)
        changeApronColorAlpha()
    }
    @IBAction func changeSkirtColor(_ sender: UISlider) {
        //skirt 漸層 左上藍 右下HSB
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = skirtView.bounds
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor(hue: CGFloat(sender.value), saturation: 0.8, brightness: 1, alpha: 1).cgColor]
        gradientLayer.locations = [0, 0.8]
        gradientLayer.startPoint = CGPoint(x: 0,y: 0)
        gradientLayer.endPoint = CGPoint(x: 1,y: 1)
        skirtView.layer.addSublayer(gradientLayer)
        //HSB color
//        skirtView.backgroundColor = UIColor(hue: CGFloat(sender.value), saturation: 0.8, brightness: 1, alpha: 1)
    }
    @IBAction func changeMainViewCornerRadius(_ sender: UISlider) {
        mainView.layer.cornerRadius = CGFloat(sender.value)
        showCornerRadius.text = String(format: "%.1f", sender.value)
    }
    @IBAction func changeMainViewCornerRadiusRandom(_ sender: UIButton) {
        random()
    }
    @IBAction func switchMainViewCornerRadius(_ sender: UISwitch) {
        if sender.isOn{
            button.isEnabled = true
            sliderMainViewCornerRadius.isEnabled = true
        }else{
            button.isEnabled = false
            sliderMainViewCornerRadius.isEnabled = false
        }
    }
}

