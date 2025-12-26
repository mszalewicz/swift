import Vapor

@main
struct app {
    static func main() async {
        let app: Vapor.Application

        do {
            app = try await Vapor.Application.make(.detect())
        } catch {
            print("error: \(error)")
            exit(1)
        }

        app.get("hello") { req in
            "Hello, world!"
        }

        do {
            try await app.execute()
        } catch {
            print("error: \(error)")
            exit(1)
        }

    }
}
