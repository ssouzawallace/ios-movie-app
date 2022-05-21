//
//  ColorPickerViewController.swift
//  MasterDetail
//
//  Created by user on 18/05/22.
//

import UIKit

protocol ColorPickerDelegate {
    func colorChaged(to color: UIColor)
}

class ColorPickerViewController: UIViewController {
    
    @IBOutlet var outputViews: [UIView]!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    var delegate: ColorPickerDelegate?
    
    var selectedColor: UIColor = UIColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        if selectedColor.getRed(&red, green: &green, blue: &blue, alpha: nil) {
            redSlider.setValue(Float(red), animated: false)
            greenSlider.setValue(Float(green), animated: false)
            blueSlider.setValue(Float(blue), animated: false)
            computeColor()
        }        
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        computeColor()
        delegate?.colorChaged(to: selectedColor)
    }
    
    private func computeColor() {
        let color = UIColor(red: CGFloat(redSlider.value),
                            green: CGFloat(greenSlider.value),
                            blue: CGFloat(blueSlider.value),
                            alpha: 1.0)
        outputViews.forEach { view in
            view.backgroundColor = color
        }
        selectedColor = color
    }
}
