//
//  LLWidgetBundle.swift
//  LLWidget
//
//  Created by Shaunak Ghosh on 10/04/2025.
//

import WidgetKit
import SwiftUI

@main
struct LLWidgetBundle: WidgetBundle {
    var body: some Widget {
        LLWidget()
        LLWidgetControl()
        LLWidgetLiveActivity()
    }
}
