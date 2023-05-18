//
//  utils.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-18.
//

import Foundation

func formatFloatValue(_ floatValue: Float) -> String? {
  let numberFormatter = NumberFormatter()
  numberFormatter.locale = Locale(identifier: "en_US")
  numberFormatter.numberStyle = .decimal
  numberFormatter.minimumFractionDigits = 1
  numberFormatter.maximumFractionDigits = 1

  return numberFormatter.string(from: NSNumber(value: floatValue))
}
