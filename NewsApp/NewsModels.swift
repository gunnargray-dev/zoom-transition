import SwiftUI

// MARK: - News Models

struct NewsArticle: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let summary: String
    let content: String
    let author: String
    let publishedDate: Date
    let imageUrl: String
    let category: NewsCategory
    let accentColor: Color

    // Sample data with Unsplash editorial images
    static let sampleArticles: [NewsArticle] = [
        NewsArticle(
            title: "NFL Draft landscape shifts following combine performances at the NFL Combine",
            summary: "Top prospects showcase their skills as teams prepare for upcoming draft decisions with surprising standout performances.",
            content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.\n\nExcepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium.",
            author: "Mike Johnson",
            publishedDate: Date().addingTimeInterval(-3600),
            imageUrl: "https://images.unsplash.com/photo-1566577739112-5180d4bf9390?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1200&q=80",
            category: .sports,
            accentColor: Color(hex: "B8C65A")
        ),
        NewsArticle(
            title: "Global Climate Summit Concludes with Historic Agreement",
            summary: "World leaders unite on ambitious climate targets as renewable energy investments reach record highs globally.",
            content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
            author: "Dr. Sarah Chen",
            publishedDate: Date().addingTimeInterval(-7200),
            imageUrl: "https://images.unsplash.com/photo-1473341304170-971dccb5ac1e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1200&q=80",
            category: .environment,
            accentColor: Color(hex: "4A90E2")
        ),
        NewsArticle(
            title: "Revolutionary Brain-Computer Interface Breakthrough",
            summary: "Scientists achieve major milestone in neural technology, enabling paralyzed patients to control devices with thoughts.",
            content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            author: "Dr. Emily Rodriguez",
            publishedDate: Date().addingTimeInterval(-10800),
            imageUrl: "https://images.unsplash.com/photo-1559757148-5c350d0d3c56?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1200&q=80",
            category: .health,
            accentColor: Color(hex: "E74C3C")
        ),
        NewsArticle(
            title: "Mars Mission Reveals Stunning Geological Discoveries",
            summary: "NASA's Perseverance rover uncovers evidence of ancient water systems and potential signs of past microbial life.",
            content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            author: "Dr. Michael Thompson",
            publishedDate: Date().addingTimeInterval(-14400),
            imageUrl: "https://images.unsplash.com/photo-1446776858070-33f2501b2c5e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1200&q=80",
            category: .science,
            accentColor: Color(hex: "9B59B6")
        ),
        NewsArticle(
            title: "AI Revolution: Major Tech Breakthrough Announced",
            summary: "Leading technology companies unveil next-generation artificial intelligence systems that could transform industries.",
            content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            author: "Alex Kim",
            publishedDate: Date().addingTimeInterval(-18000),
            imageUrl: "https://images.unsplash.com/photo-1485827404703-89b55fcc595e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1200&q=80",
            category: .technology,
            accentColor: Color(hex: "1ABC9C")
        ),
        NewsArticle(
            title: "Global Markets Surge as Economic Optimism Grows",
            summary: "Stock markets worldwide experience significant gains as investors respond to positive economic indicators and growth forecasts.",
            content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            author: "Jennifer Walsh",
            publishedDate: Date().addingTimeInterval(-21600),
            imageUrl: "https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1200&q=80",
            category: .business,
            accentColor: Color(hex: "F39C12")
        )
    ]
}

enum NewsCategory: String, CaseIterable {
    case technology = "Technology"
    case environment = "Environment"
    case health = "Health"
    case science = "Science"
    case business = "Business"
    case sports = "Sports"

    var color: String {
        switch self {
        case .technology: return "1FB8CD"
        case .environment: return "4CAF50"
        case .health: return "FF6B6B"
        case .science: return "9C27B0"
        case .business: return "2196F3"
        case .sports: return "B8C65A"
        }
    }
}
