//
//  SwitchTableViewCell.swift
//  CompareApp
//
//  Created by Karsten Bruns on 29/08/15.
//  Copyright © 2015 bruns.me. All rights reserved.
//

import UIKit



public class SwitchTableViewCell: UITableViewCell, UpdateableTableViewCell {
    
    var titleLabel = UILabel()
    var switchControl = UISwitch()
    
    private var item: SwitchItem? = nil
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .None
        addSubviews()
        addViewConstraints()
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addSubviews() {
        // Title View
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        // Value View
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        switchControl.addTarget(self, action: "switchValueChanged:", forControlEvents: .ValueChanged)
        addSubview(switchControl)
    }
    
    
    private func addViewConstraints() {
        let views = ["titleLabel": titleLabel, "switchControl": switchControl]
        let h = NSLayoutConstraint.constraintsWithVisualFormat("H:|-[titleLabel]-[switchControl]-|", options: [], metrics: nil, views: views)
        let vColorView = NSLayoutConstraint.constraintsWithVisualFormat("V:|-[titleLabel]-|", options: [], metrics: nil, views: views)
        let vCounterView = NSLayoutConstraint.constraintsWithVisualFormat("V:|-(>=6)-[switchControl]-(>=6)-|", options: [], metrics: nil, views: views)
        addConstraints(h + vColorView + vCounterView)
    }

    
    private func switchValueChanged(sender: AnyObject) {
        item?.valueHandler(value: switchControl.on)
    }
 
    
    public func updateCellWithItem(item: ComparableItem, animated: Bool) {
        
        guard let switchItem = item as? SwitchItem else { return }

        self.item = switchItem
        
        if switchControl.on != switchItem.value {
            switchControl.setOn(switchItem.value, animated: animated)
        }
        
        if titleLabel.text != switchItem.title {
            titleLabel.text = switchItem.title
        }
    }

}
