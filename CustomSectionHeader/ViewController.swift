//
//  ViewController.swift
//  CustomSectionHeader
//
//  Created by Onur Tuna on 12.02.2019.
//  Copyright © 2019 onurtuna. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var customTableView: UITableView!
    var isExpanded = [true, true, true]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customTableView.dataSource = self
        self.customTableView.delegate = self
        customTableView.estimatedRowHeight = 30
        customTableView.rowHeight = UITableView.automaticDimension
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = UINib(nibName: "CustomSectionHeader", bundle: nil).instantiate(withOwner: self, options: nil).last as! CustomSectionHeader
        
        header.btnHeader.tag = section
        header.btnHeader.addTarget(self, action: #selector(sectionTapped(_:)), for: .touchUpInside)
        if self.isExpanded[section] == true {
            header.bottomContent.isHidden = false
        }else {
            header.bottomContent.isHidden = true
        }
        
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let data = self.isExpanded[section]
        if data == true {
            return 140
        }else {
            return 45
        }
    }
    
    
    @objc func sectionTapped(_ sender: UIButton){
        print("tapped")
        self.isExpanded[sender.tag] = !(self.isExpanded[sender.tag])
        print(sender.tag)
        
        DispatchQueue.main.async {
            self.customTableView.reloadSections(IndexSet(integer: sender.tag), with: .none)
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return isExpanded.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = self.isExpanded[section]
        if data == true {
            return 3
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DataCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let data = self.isExpanded[section]
        if data == true {
            return 45
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UINib(nibName: "CustomFooter", bundle: nil).instantiate(withOwner: self, options: nil).first as? CustomFooter
        footer?.btnModify.tag = section
        footer?.btnRepeat.tag = section
        footer?.btnModify.addTarget(self, action: #selector(didTapModify(_:)), for: .touchUpInside)
        footer?.btnRepeat.addTarget(self, action: #selector(didTapRepeat(_:)), for: .touchUpInside)
        
        if self.isExpanded[section] == true {
            footer?.btnRepeat.isHidden = false
            footer?.btnModify.isHidden = false
        }else {
            footer?.btnRepeat.isHidden = true
            footer?.btnModify.isHidden = true
        }
        return footer
    }
    
    @objc func didTapRepeat(_ sender: UIButton) {
        print(#function)
        print(sender.tag)
    }
    @objc func didTapModify(_ sender: UIButton) {
        print(#function)
        print(sender.tag)
    }
    
    
    
}

