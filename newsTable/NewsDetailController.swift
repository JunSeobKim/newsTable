//
//  NewsDetailController.swift
//  newsTable
//
//  Created by 김준섭 on 2020/11/23.
//

import UIKit

class NewsDetailController: UIViewController {
    
    @IBOutlet weak var ImageMain: UIImageView!
    @IBOutlet weak var LabelMain: UILabel!
    
    // 1. 이미지 url
    // 2. desc 받기
    
    var imageUrl: String?
    var desc: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let img = imageUrl {
            // 이미지 가져오기
            // Data
            if let data = try? Data(contentsOf: URL(string: img)!) {
                // Main Thread
                DispatchQueue.main.async {
                    self.ImageMain.image = UIImage(data: data)
                }
                
            }
            
            
        }
        
        if let d = desc {
            // 본문 가져오기
            self.LabelMain.text = d
        }
        
    }
}
