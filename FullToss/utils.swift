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

// 1623170885
func getEpochTime() -> Int {
  return Int(Date().timeIntervalSince1970)
}

// May 21, 2023
func getDateString(_ epochTime: Int = getEpochTime()) -> String {
  let date = Date(timeIntervalSince1970: Double(epochTime))
  let formatter = DateFormatter()
  formatter.dateStyle = .long
  return formatter.string(from: date)
}

// May 21, 2023 at 1:45:30 PM
func getLocalTimeString(_ epochTime: Int) -> String {
  let date = Date(timeIntervalSince1970: Double(epochTime))
  let dateFormatter = DateFormatter()
  dateFormatter.dateStyle = .medium
  dateFormatter.timeStyle = .short
  dateFormatter.timeZone = TimeZone.current

  return dateFormatter.string(from: date)
}

func getTimeAgoString(_ epochTime: Int) -> String {
  let date = Date(timeIntervalSince1970: Double(epochTime))
  let formatter = RelativeDateTimeFormatter()
  formatter.unitsStyle = .full

  return formatter.localizedString(for: date, relativeTo: date)
}
