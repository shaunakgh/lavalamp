import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        let currentDate = Date()
        let entry = SimpleEntry(date: currentDate)
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct LLWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Image("blobs")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()

            Color.clear
                .background(.ultraThinMaterial)
                .ignoresSafeArea()

            VStack(spacing: 8) {
                Text(entry.date, style: .time)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                let index = Int.random(in: 1...120)
                Image("\(index)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100.0, height: 100.0)
            }
            .padding()
        }
        .containerBackground(.clear, for: .widget)
    }
}

struct LLWidget: Widget {
    let kind: String = "LLWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            LLWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Lava Lamp")
        .description("This is the lava lamp widget for the app 'Lava Lamp'")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
    

#Preview(as: .systemSmall) {
    LLWidget()
} timeline: {
    SimpleEntry(date: .now)
}
