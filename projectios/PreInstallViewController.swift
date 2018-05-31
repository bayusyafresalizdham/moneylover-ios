//
//  PreInstallViewController.swift
//  projectios
//
//  Created by Bayu Syafresal Izdham on 30/05/18.
//  Copyright © 2018 Bayu Syafresal Izdham. All rights reserved.
//

import UIKit

class PreInstallViewController: UIViewController , UIScrollViewDelegate{
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var btnLewati: UIButton!
    var gambar: [String] = ["gambar1","gambar2","gambar3","gambar4"]
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    var contentWidth:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        
        for image in 0..<4 {
            let imageToDisplay = UIImage(named: gambar[image])
            let imageView = UIImageView(image: imageToDisplay)
            
            let xCoordinate = view.frame.midX + view.frame.width * CGFloat(image)
            contentWidth += view.frame.width
            scrollView.addSubview(imageView)
            imageView.frame = CGRect(x: xCoordinate - +150, y: (view.frame.height / 2) - 150, width: 300, height: 220)
        }
        pageControl.size(forNumberOfPages: 3)
        scrollView.contentSize = CGSize(width: contentWidth, height: view.frame.height)
        // Do any additional setup after loading the view.
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         pageControl.currentPage = Int(scrollView.contentOffset.x / CGFloat(414))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
