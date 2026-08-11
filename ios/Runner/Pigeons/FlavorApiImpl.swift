import Foundation

class FlavorApiImpl: FlavorApi {
    func getFlavor() throws -> String {
        return Bundle.main.infoDictionary?["APP_FLAVOR"] as? String ?? ""
    }

    func getAppName() throws -> String {
        return Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? ""
    }

    func isProd() throws -> Bool {
        return (try getFlavor()) == "prod"
    }
}
