package jda.query.resource;

import javax.annotation.Nullable;
import org.neo4j.driver.AuthTokens;
import org.neo4j.driver.Driver;
import org.neo4j.driver.GraphDatabase;
import org.neo4j.driver.SessionConfig;

public class Connection implements AutoCloseable {
  @Nullable private static Connection instance = null;
  private final Driver driver;

  private Connection(final String uri, final String user, final String password)
      throws Exception {
    driver = GraphDatabase.driver(uri, AuthTokens.basic(user, password));
    driver.verifyConnectivity();
    System.out.println("Connection estabilished.");
  }

  public static Connection getInstance(final String uri, final String user,
                                       final String password) {
    if (instance == null) {
      try {
        instance = new Connection(uri, user, password);
      } catch (Exception e) {
        System.err.println("Failed to create a connection instance: " +
                           e.getMessage());
        System.exit(1);
      }
    }
    return instance;
  }

  public SessionOverdrive newSession(final String dbName) {
    SessionOverdrive session = null;

    try {
      session = new SessionOverdrive(
          driver.session(SessionConfig.forDatabase(dbName)));
    } catch (Exception e) {
      System.err.println("Failed to connect database: " + e.getMessage());
      System.exit(1);
    }

    return session;
  }

  @Override
  public void close() {
    driver.close();
    System.out.println("Connection ended.");
  }
}
