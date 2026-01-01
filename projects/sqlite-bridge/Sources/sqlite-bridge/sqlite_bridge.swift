import CSQLite
import Foundation

enum SQLiteError: Error {
    case openFailed
    case notInitialized
    case executionFailed(String)
}

actor SQLiteBridge {
    static let shared = SQLiteBridge()

    private var db: OpaquePointer?
    private var isInitialized = false

    private init() {}

    func initialize(at path: String) throws {
        guard !isInitialized else { return }

        let flags = SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE

        if sqlite3_open_v2(path, &db, flags, nil) != SQLITE_OK {
            defer { sqlite3_close(db) }
            throw SQLiteError.openFailed
        }

        isInitialized = true
    }

    // deinit {
    //     if db != nil {
    //         sqlite3_close(db)
    //     }
    // }

    // static func initialize(at path: String) async throws {
    //     guard shared == nil else { return }
    //     shared = try SQLiteBridge(at: path)
    // }

    // private init(at path: String) throws {
    //     var db: OpaquePointer?

    //     let flags = SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE

    //     if sqlite3_open_v2(path, &db, flags, nil) != SQLITE_OK {
    //         fatalError("Failed to open database")
    //     }

    //     self.db = db
    // }
}

func main() {
    // do {
    //     try await SQLiteBridge.shared.initialize(at: "./my.db")
    // } catch SQLiteError.openFailed {
    //     exit(1)
    // } catch {
    //     exit(1)
    // }

    Task {
        do {
            try await SQLiteBridge.shared.initialize(at: "./my.db")
        } catch SQLiteError.openFailed {
            exit(1)
        } catch {
            exit(1)
        }
    }

    // Keep the program running if needed
    RunLoop.current.run()

}
