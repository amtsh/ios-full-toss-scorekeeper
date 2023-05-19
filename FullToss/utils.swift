//
//  utils.swift
//  FullToss
//
//  Created by Amit Shinde on 2023-05-18.
//

import Foundation

func formatFloatValue(_ floatValue: Float, maximumFractionDigits:Int = 1) -> String? {
  let numberFormatter = NumberFormatter()
  numberFormatter.locale = Locale(identifier: "en_US")
  numberFormatter.numberStyle = .decimal
  numberFormatter.minimumFractionDigits = 1
  numberFormatter.maximumFractionDigits = maximumFractionDigits

  return numberFormatter.string(from: NSNumber(value: floatValue))
}

func getCurrentDate() -> String {
  let formatter = DateFormatter()
  formatter.dateStyle = .long
  return formatter.string(from: Date())
}
