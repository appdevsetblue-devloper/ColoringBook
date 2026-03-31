//
//  FillImageVC.swift
//  ColoringBook
//
//  Created by Apple on 22/12/21.
//  Copyright © 2021 I MAC. All rights reserved.
//

import UIKit

class FillImageVC: BaseVC, DTColorPickerDelegate {
    
    @IBOutlet weak var lblColor: UILabel!
    
    @IBOutlet var imgFillImage: FloodFillImageView!
    @IBOutlet weak var colorPicker: DTColorPicker!
    
    var selectedImage: UIImage = UIImage()
    
    var selectedColor : UIColor!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imgFillImage.image = self.selectedImage
        self.imgFillImage.tolorance = 100
        colorPicker.delegate = self
    }
    
    func DTColorColorPickerTouched(sender: DTColorPicker, color: UIColor, point: CGPoint, state: UIGestureRecognizerState) {
        self.selectedColor = color
        self.imgFillImage.newcolor = self.selectedColor
        lblColor.backgroundColor = selectedColor
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
