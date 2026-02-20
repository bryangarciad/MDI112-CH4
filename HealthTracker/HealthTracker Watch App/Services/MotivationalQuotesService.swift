import Foundation
import Combine

/// Service To Fetch Quotes From Zen API

class MotivationalQuotesService {

    /// Singleton
    static let shared = MotivationalQuotesService()
    private init() {}

    private let apiURL = "https://zenquotes.io/api/random"

    private let decoder = JSONDecoder()

    // MARK: - Fallback Quotes
    /// Design Principle: Offline-first - always available
    private let fallbackQuotes: [MotivationalQuote] = [
        MotivationalQuote(quote: "The more we value things, the less we value ourselves.", author: "unknown"),
        MotivationalQuote(quote: "Opportunity often comes disguised in the form of misfortune or temporary defeat", author: "unknown"),
        MotivationalQuote(quote: "Man should fear never beginning to live.", author: "unknown")
    ]

    func fetchQuote() async -> MotivationalQuote {
        guard let url = URL(string: apiURL) else {
            return fallbackQuotes.randomElement() ?? fallbackQuotes[0]
        }

        do {
            // data response not decoded 
            let (data, _) = try await URLSession.shared.data(from: url)

            let response = try decoder.decode([MotivationalQuote.APIResponse].self, from: data)

            if let response = response.first {
                return  MotivationalQuote(quote: response.q, author: response.a)
            }
        } catch {
            return fallbackQuotes.randomElement() ?? fallbackQuotes[0]
        }

        return fallbackQuotes.randomElement() ?? fallbackQuotes[0]
    }
}
