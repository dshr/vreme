//
//  String+Bitmask.swift
//  vreme
//
//  Created by Desislav Hristov on 25/10/2017.
//  Copyright © 2017 Desislav Hristov. All rights reserved.
//

import Foundation

extension String {
	
	func toBitmask() -> [Bool] {
		
		return self.characters.map { character in
			
			character.unicodeScalars.first!.value
			}.map { code in
				
				return String(code, radix: 2, uppercase: true)
			}.joined().characters.map { character in
				
				character == "1"
		}
	}
}
