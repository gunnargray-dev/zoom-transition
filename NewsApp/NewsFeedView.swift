import SwiftUI

// MARK: - Constants
struct Constants {
    static let borderOffsetPlus = Color.white.opacity(0.1)
}

struct NewsFeedView: View {
    // MARK: - Properties
    @State private var articles = NewsArticle.sampleArticles
    @State private var selectedArticle: NewsArticle?
    @State private var showDetailView = false
    @Namespace private var imageTransition

    // MARK: - Body
    var body: some View {
        ZStack {
            // Main Feed View
            NavigationStack {
                ZStack {
                    Color(hex: "191a1a").ignoresSafeArea()

                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(articles) { article in
                                if selectedArticle?.id != article.id || !showDetailView {
                                    Button {
                                        selectedArticle = article
                                        withAnimation(.easeInOut(duration: 0.6)) {
                                            showDetailView = true
                                        }
                                    } label: {
                                        NewsCardView(
                                            article: article, 
                                            imageTransition: imageTransition,
                                            isSelected: selectedArticle?.id == article.id && showDetailView
                                        )
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                    }
                }
                .navigationTitle("News Feed")
                .navigationBarTitleDisplayMode(.large)
                .preferredColorScheme(.dark)
            }
            
            // Modal Detail View Overlay
            if showDetailView, let article = selectedArticle {
                NewsDetailView(
                    article: article, 
                    imageTransition: imageTransition,
                    onDismiss: {
                        withAnimation(.easeInOut(duration: 0.6)) {
                            showDetailView = false
                        }
                    }
                )
                .zIndex(1)
            }
        }
    }
}

// MARK: - News Card View
struct NewsCardView: View {
    // MARK: - Properties
    let article: NewsArticle
    let imageTransition: Namespace.ID
    let isSelected: Bool

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Responsive Image with matched transition
            ZStack {
                AsyncImage(url: URL(string: article.imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()
                } placeholder: {
                    Rectangle()
                        .fill(article.accentColor.opacity(0.3))
                        .frame(height: 200)
                        .overlay(
                            ProgressView()
                                .tint(.white)
                        )
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .matchedGeometryEffect(id: "\(article.id)-image", in: imageTransition)
            .padding(.horizontal, 12)
            .padding(.top, 12)
            
            // Content area with fixed height to prevent jumping
            VStack(alignment: .leading, spacing: 12) {
                // Title
                Text(article.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
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
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .frame(height: 100, alignment: .top)
            .opacity(isSelected ? 0 : 1)
        }
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                stops: [
                    Gradient.Stop(color: article.accentColor.opacity(0), location: 0.00),
                    Gradient.Stop(color: article.accentColor, location: 1.00),
                ],
                startPoint: UnitPoint(x: 0.5, y: 0.4),
                endPoint: UnitPoint(x: 0.02, y: 0.01)
            )
            .opacity(isSelected ? 0 : 1)
        )
        .background(Color(red: 0.14, green: 0.15, blue: 0.15).opacity(isSelected ? 0 : 1))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .inset(by: 0.5)
                .stroke(Constants.borderOffsetPlus, lineWidth: 1)
                .opacity(isSelected ? 0 : 1)
        )
        .layoutPriority(1)
    }
}

#Preview {
    NewsFeedView()
}
