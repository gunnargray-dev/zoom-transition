import SwiftUI

// MARK: - Constants
struct Constants {
    static let borderOffsetPlus = Color.white.opacity(0.1)
}

struct NewsFeedView: View {
    // MARK: - Properties
    @State private var articles = NewsArticle.sampleArticles
    @Namespace private var transitionNamespace

    private let columns = [
        GridItem(.flexible(), spacing: 16)
    ]

    // MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: "191a1a").ignoresSafeArea()

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(articles) { article in
                            NavigationLink {
                                NewsDetailView(article: article)
                                    .navigationTransition(.zoom(sourceID: article.id, in: transitionNamespace))
                            } label: {
                                NewsCardView(article: article)
                                    .matchedTransitionSource(id: article.id, in: transitionNamespace)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                }
            }
        }
        .navigationTitle("News Feed")
        .navigationBarTitleDisplayMode(.large)
        .preferredColorScheme(.dark)
    }
}

// MARK: - News Card View
struct NewsCardView: View {
    // MARK: - Properties
    let article: NewsArticle

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Inset Image with rounded corners
            AsyncImage(url: URL(string: article.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 345, height: 200)
                    .clipped()
            } placeholder: {
                Rectangle()
                    .fill(article.accentColor.opacity(0.3))
                    .frame(width: 345, height: 200)
                    .overlay(
                        ProgressView()
                            .tint(.white)
                    )
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, 8)
            .padding(.top, 8)
            
            Spacer()
            
            // Bottom content with proper spacing
            VStack(alignment: .leading, spacing: 12) {
                // Title at bottom
                Text(article.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                
                // Bottom row with sources and icons
                HStack {
                    HStack(spacing: 4) {
                        // Source indicator circles
                        HStack(spacing: -4) {
                            Circle()
                                .fill(Color.white.opacity(0.4))
                                .frame(width: 16, height: 16)
                            Circle()
                                .fill(Color.white.opacity(0.4))
                                .frame(width: 16, height: 16)
                            Circle()
                                .fill(Color.white.opacity(0.4))
                                .frame(width: 16, height: 16)
                        }
                        
                        Text("13 sources")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    
                    Spacer()
                    
                    // Action icons
                    HStack(spacing: 16) {
                        Image(systemName: "heart")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                        
                        Image(systemName: "ellipsis")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 12)
        }
        .frame(width: 361, alignment: .topLeading)
        .background(
            LinearGradient(
                stops: [
                    Gradient.Stop(color: article.accentColor.opacity(0), location: 0.00),
                    Gradient.Stop(color: article.accentColor, location: 1.00),
                ],
                startPoint: UnitPoint(x: 0.5, y: 0.4),
                endPoint: UnitPoint(x: 0.02, y: 0.01)
            )
        )
        .background(Color(red: 0.14, green: 0.15, blue: 0.15))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .inset(by: 0.5)
                .stroke(Constants.borderOffsetPlus, lineWidth: 1)
        )
    }
}

#Preview {
    NewsFeedView()
}
