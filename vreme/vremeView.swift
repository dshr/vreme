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
	
  let calendar = Calendar.current
  let formatter = DateFormatter()
  
  var debugData = [String: Any]()
  
  override init?(frame: NSRect, isPreview: Bool) {
		
    formatter.dateFormat = "HH:mm:ss"
    formatter.timeZone = .current
    
    super.init(frame: frame, isPreview: isPreview)
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
		
		let date = Date()
		let time = formatter.string(from: date)
		
    NSColor.black.setFill()
    bounds.fill()
		
		NSColor.white.setFill()
		NSColor.white.set()
		let directions: [(CGFloat, CGFloat)] = [(1, 1), (1, -1), (-1, 1), (-1, -1)]
		let bitmask = time.toBitmask()
		let step = bounds.height / 14
		for (x, y) in directions {
			
			drawScreenQuarter(for: bitmask, x: x, y: y, step: step)
		}
		
    drawTime(for: time)
		drawCredit()
    drawDebug()
  }
	
	fileprivate func drawScreenQuarter(for bitmask: [Bool], x: CGFloat, y: CGFloat, step: CGFloat) {
		
		let shim = (x: (x == -1.0 ? step : 0), y: (y == -1.0 ? step : 0))
		let start = (x: (bounds.width / 2) - x * (bounds.width / 2) - shim.x,
		             y: (bounds.height / 2) - y * (bounds.height / 2) - shim.y)
		for (index, bit) in bitmask.enumerated() {
			
			if bit {
				
				let position = (x: CGFloat(index / 7), y: CGFloat(index % 7))
				let bitRect = NSRect(x: start.x + position.x * step * x, y: start.y + position.y * step * y, width: step, height: step).insetBy(dx: -0.2, dy: -0.2)
				bitRect.fill()
			}
		}
	}
  
	fileprivate func drawTime(for time: String) {
		
    let timeString = time as NSString
    
    let size = bounds.width / 17
    let attributes: [NSAttributedStringKey: Any] = [
      .foregroundColor: NSColor.black,
      .font: NSFont(name: "Menlo", size: size)!
    ]
    
    let textRect = timeString.boundingRect(with: NSZeroSize, options: .usesLineFragmentOrigin, attributes: attributes)
    let textX = (bounds.width - textRect.width) / 2
    let textY = ((bounds.height - textRect.height) / 2) + size / 10

    let backgroundRect = NSRect(x: bounds.height / 2, y: (bounds.height / 14) * 6, width: bounds.width - bounds.height, height: bounds.height / 7)
    
    NSColor.white.setFill()
    backgroundRect.fill()
    
    timeString.draw(at: NSPoint(x: textX, y: textY), withAttributes: attributes)
  }
	
	fileprivate func drawCredit() {
		
		let credit = " vreme\nby dshr" as NSString // quite lazy, i know 😅
		let size = bounds.width / 100
		let attributes: [NSAttributedStringKey: Any] = [
			.foregroundColor: NSColor.white,
			.font: NSFont(name: "Menlo", size: size)!
		]
		
		let textRect = credit.boundingRect(with: NSZeroSize, options: .usesLineFragmentOrigin, attributes: attributes)
		let textX = (bounds.width - textRect.width) / 2
		let textY = bounds.height / 112
		credit.draw(at: NSPoint(x: textX, y: textY), withAttributes: attributes)
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
