//
//  RecipeModel+ReadableTime.swift
//  Reciplease
//
//  Created by Redouane on 05/12/2024.
//

import Foundation

extension RecipeModel {
    var readableTime: String {

        guard time > 0 else { return "-"}

        let totalSeconds = time * 60

        let (hours, minutes) = (totalSeconds / 3600, (totalSeconds % 3600) / 60)

        let hoursString = hours == 0 ? "" : "~" + String(hours) + "h"

        let minutesString = minutes == 0 ? "" : String(minutes) + "m"

        let output = hoursString.isEmpty ? minutesString : hoursString

        return output
    }
}
