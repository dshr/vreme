//
//  vremeView.swift
//  vreme
//
//  Created by Desislav Hristov on 13/10/2017.
//  Copyright © 2017 Desislav Hristov. All rights reserved.
//

import AppKit
import ScreenSaver

class vremeView: ScreenSaverView {
  
  var date: Date
  let calendar = Calendar.current
  let formatter = DateFormatter()
  
  var debugData = [String: Any]()
  
  override init?(frame: NSRect, isPreview: Bool) {
    
    date = Date()
    formatter.dateFormat = "HH:mm:ss"
    formatter.timeZone = .current
    
    super.init(frame: frame, isPreview: isPreview)
    
    animationTimeInterval = 0.25
  }
  
  required init?(coder: NSCoder) {
    
    fatalError("init(coder:) has not been implemented")
  }
  
  override func startAnimation() {
    
    super.startAnimation()
  }
  
  override func stopAnimation() {
    
    super.stopAnimation()
  }
  
  override func animateOneFrame() {
    
    super.animateOneFrame()
    
    NSColor.black.setFill()
    bounds.fill()
    drawTime()
    drawDebug()
  }
  
  fileprivate func drawTime() {
    
    date = Date()
    let timeString = formatter.string(from: date) as NSString
    
    let hours = Double(calendar.component(.hour, from: date))
    let minutes = Double(calendar.component(.minute, from: date))
    let seconds = Double(calendar.component(.second, from: date))
    let red = CGFloat(hours / 24.0)
    let green = CGFloat(minutes / 60.0)
    let blue = CGFloat(seconds / 60.0)
    let backgroundColour = NSColor(red: red, green: green, blue: blue, alpha: 1.0)
    
    let textColour = backgroundColour.brightnessComponent > 0.5 ? NSColor.black : NSColor.white
    
    let size = bounds.width / 10
    let attributes: [NSAttributedStringKey: Any] = [
      .foregroundColor: textColour,
      .font: NSFont(name: "Menlo", size: size)!
    ]
    
    let textRect = timeString.boundingRect(with: NSZeroSize, options: .usesLineFragmentOrigin, attributes: attributes)
    let textX = (bounds.width - textRect.width) / 2
    let textY = (bounds.height - textRect.height) / 2
    
    let padding = bounds.width / 100
    let backgroundRect = NSRect(x: textX - padding * 3, y: textY - padding, width: textRect.width + padding * 6, height: textRect.height)
    
    backgroundColour.setFill()
    backgroundRect.fill()
    
    timeString.draw(at: NSPoint(x: textX, y: textY), withAttributes: attributes)
  }
  
  fileprivate func addToDebug(value: Any, under name: String) {
  
    debugData[name] = value
  }
  
  fileprivate func drawDebug() {
    
    var output = ""
    for entry in debugData.enumerated() {
      
      output.append("\(entry.element.key): \(entry.element.value)\n")
    }
    let outputString = output as NSString
    let size = bounds.width / 100
    let attributes: [NSAttributedStringKey: Any] = [
      .foregroundColor: NSColor.black,
      .backgroundColor: NSColor.white,
      .font: NSFont(name: "Menlo", size: size)!
    ]
    outputString.draw(at: NSPoint(x: 0, y: 0), withAttributes: attributes)
  }
}
