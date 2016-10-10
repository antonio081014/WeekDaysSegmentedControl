//
//  WeekdaysSegmentedControl.swift
//
//  Created by Antonio081014 on 9/14/16.
//  Copyright © 2016 Perfecular.com. All rights reserved.
//

import UIKit

protocol WeekDaysSegmentedControlDelegate {
    /// Invoke when segment changes, if the delegate is not nil.
    func segmentsDidChange(control: WeekDaysSegmentedControl, with Status: WeekDaysSegmentedControl.Weekday)
}

@objc class WeekDaysSegmentedControl: UIView {
    
    /// The Weekday struct.
    struct Weekday: OptionSet {
        let rawValue: Int
        
        /// An array of all the available Days in a Week, starting with Sunday.
        static let AllDays: [Weekday] = [.Sunday, .Monday, .Tuesday, .Wednesday, .Thursday, .Friday, .Saturday]
        
        /// Sunday
        static let Sunday    = Weekday(rawValue: 1 << 0)
        /// Monday
        static let Monday    = Weekday(rawValue: 1 << 1)
        /// Tuesday
        static let Tuesday    = Weekday(rawValue: 1 << 2)
        /// Wednesday
        static let Wednesday    = Weekday(rawValue: 1 << 3)
        /// Thursday
        static let Thursday    = Weekday(rawValue: 1 << 4)
        /// Friday
        static let Friday    = Weekday(rawValue: 1 << 5)
        /// Saturday
        static let Saturday    = Weekday(rawValue: 1 << 6)
        
        /// The String description of Weekday instance.
        /// It returns String formatted description of seven Weekdays.
        var description: String {
            get {
                switch self.rawValue{
                case Weekday.Sunday.rawValue:
                    return "Sun"
                case Weekday.Monday.rawValue:
                    return "Mon"
                case Weekday.Tuesday.rawValue:
                    return "Tue"
                case Weekday.Wednesday.rawValue:
                    return "Wed"
                case Weekday.Thursday.rawValue:
                    return "Thu"
                case Weekday.Friday.rawValue:
                    return "Fri"
                case Weekday.Saturday.rawValue:
                    return "Sat"
                default:
                    return "Unknown"
                }
            }
        }
    }
    
    /// The list of button titles.
    private var buttonTitles: [Weekday] = Weekday.AllDays
    /// The list of status of each buttons.
    private var selected: [Bool] = Array.init(repeating: false, count: Weekday.AllDays.count)
    
    /// The color of background.
    public var backColor = UIColor.white
    /// The color of text, aka fore color.
    public var textColor = UIColor.init(red: CGFloat(0x2A) / CGFloat(255), green: CGFloat(0x4F) / CGFloat(255), blue: CGFloat(0x6E) / CGFloat(255), alpha: CGFloat(1))
    /// The font of text on the button.
    public var font = UIFont.systemFont(ofSize: 13)
    
    /// The delegate of WeekdaysSegmentedControl.
    public var delegate: WeekDaysSegmentedControlDelegate?
    
    /// Weekday Set of selected days in a week.
    public var selectedDays: Weekday {
        /// Getter
        get {
            var days = Weekday()
            for i in 0..<selected.count {
                if selected[i] {
                    days.insert(buttonTitles[i])
                }
            }
            return days
        }
        /// Setter
        set {
            
            for i in 0..<selected.count {
                if newValue.contains(buttonTitles[i]) {
                    selected[i] = true
                } else {
                    selected[i] = false
                }
            }
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 2
        self.layer.masksToBounds = true
        
        let size = min(self.bounds.size.width / CGFloat(buttonTitles.count), self.bounds.size.height)
        let space = (self.bounds.size.width - size * CGFloat(buttonTitles.count)) / CGFloat(1 + buttonTitles.count)
        
        if self.subviews.count <= 0 {
            for (index, title) in buttonTitles.enumerated() {
                let buttonWidth = size
                let buttonHeight = size
                
                let button = UIButton(frame: CGRect(x: CGFloat(index) * buttonWidth + space * CGFloat(index + 1), y: 0, width: buttonWidth, height: buttonHeight))
                
                button.setTitle(title.description.uppercased(), for: .normal)
                button.titleLabel?.font = self.font
                button.addTarget(self, action: #selector(changeSegment(sender:)), for: .touchUpInside)
                button.layer.borderWidth = 1
                button.layer.cornerRadius = size / 2
                button.layer.masksToBounds = true
                
                self.updateButton(button: button, selected: selected[index])
                
                self.addSubview(button)
            }
        }
    }
    
    /// Update button UI based on the selected status of the button.
    private func updateButton(button: UIButton, selected: Bool) {
        if selected {
            button.backgroundColor = self.textColor
            button.setTitleColor(self.backColor, for: .normal)
            button.layer.borderColor = self.backColor.cgColor
        } else {
            button.backgroundColor = self.backColor
            button.setTitleColor(self.textColor, for: .normal)
            button.layer.borderColor = self.textColor.cgColor
        }
    }
    
    /// Change Segument Event.
    func changeSegment(sender: UIButton) {
        for (index, title) in buttonTitles.enumerated() {
            if sender.currentTitle == title.description.uppercased() {
                selected[index] = !selected[index]
                self.updateButton(button: sender, selected: selected[index])
                self.delegate?.segmentsDidChange(control: self, with: selectedDays)
                return
            }
        }
    }
    
}
