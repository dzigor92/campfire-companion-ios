import Foundation

protocol SessionStoring {
    func load() -> GiveawaySession?
    func save(_ session: GiveawaySession)
    func clear()
}

struct UserDefaultsSessionStore: SessionStoring {
    private let storageKey = "giveaway.session"
    private let defaults: UserDefaults
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func load() -> GiveawaySession? {
        guard let data = defaults.data(forKey: storageKey) else {
            return nil
        }

        do {
            return try decoder.decode(GiveawaySession.self, from: data)
        } catch {
            return nil
        }
    }

    func save(_ session: GiveawaySession) {
        guard let data = try? encoder.encode(session) else {
            return
        }

        defaults.set(data, forKey: storageKey)
    }

    func clear() {
        defaults.removeObject(forKey: storageKey)
    }
}
