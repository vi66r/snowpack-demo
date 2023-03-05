import SnowPack

final class SessionManager: Session {
    static var instance: SessionManager? {
        @Dependency var session: Session
        return session as? SessionManager
    }
}
