//
//  ViewController.swift
//  CLMenuView
//
//  Created by 赵永强 on 2017/10/19.
//  Copyright © 2017年 cleven. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var menuItem:CLMenuView = {
        let menuItem = CLMenuView(itemTypes: [.copy,.collect,.reply,.report,.resend,.translate])
        
        menuItem.delegate = self
        
        return menuItem
    }()
    
    var tableView:UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), style: UITableViewStyle.plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "menuItem测试 + \(indexPath.row)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        guard let keyWindow = UIApplication.shared.delegate?.window else {return}
        if menuItem.alpha == 0 {
            keyWindow?.addSubview(self.menuItem)
        }
        let rect = cell?.contentView.convert((cell?.contentView.frame)!, to: keyWindow)
        menuItem.setTargetRect(targetRect: rect!)
        menuItem.showMenuItemView(indexPath: indexPath)

    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat(60 + (arc4random() % 100))
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        menuItem.hiddenMenuItemView()
    }
    
}


extension ViewController:ClMenuItemViewDelegate
{
    
    func menuItemAction(indexPath: IndexPath, itemIndex: Int) {
        print("=====indexPath = \(indexPath) itemIndex = \(itemIndex)")
    }
    
}
