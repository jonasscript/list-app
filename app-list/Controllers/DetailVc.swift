//
//  DetailVc.swift
//  app-list
//
//  Created by Jonathan Macias on 1/8/20.
//  Copyright © 2020 jonathan. All rights reserved.
//

import UIKit
import SDWebImage

class DetailVc: UIViewController {

    
    
    var selectedApp: Aplication!
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var descrip: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        name.text = selectedApp.imname
        descrip.text = selectedApp.sumari
        image.sd_setImage(with: URL(string: selectedApp.imimage), completed: nil)
        
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    

}
