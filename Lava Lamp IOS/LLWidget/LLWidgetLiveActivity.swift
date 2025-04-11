//
//  LLWidgetLiveActivity.swift
//  LLWidget
//
//  Created by Shaunak Ghosh on 10/04/2025.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct LLWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct LLWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LLWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension LLWidgetAttributes {
    fileprivate static var preview: LLWidgetAttributes {
        LLWidgetAttributes(name: "World")
    }
}

extension LLWidgetAttributes.ContentState {
    fileprivate static var smiley: LLWidgetAttributes.ContentState {
        LLWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: LLWidgetAttributes.ContentState {
         LLWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: LLWidgetAttributes.preview) {
   LLWidgetLiveActivity()
} contentStates: {
    LLWidgetAttributes.ContentState.smiley
    LLWidgetAttributes.ContentState.starEyes
}
