package jda.example;

import io.github.cdimascio.dotenv.Dotenv;
import org.neo4j.driver.AuthTokens;
import org.neo4j.driver.Driver;
import org.neo4j.driver.GraphDatabase;
import org.neo4j.driver.SessionConfig;

public class Main implements AutoCloseable {
  private final Driver driver;

  public Main(final String uri, final String user, final String password) {
    driver = GraphDatabase.driver(uri, AuthTokens.basic(user, password));
    driver.verifyConnectivity();
    System.out.println("Connection estabilished.");
  }

  @Override
  public void close() throws RuntimeException {
    driver.close();
    System.out.println("Connection ended.");
  }

  public void example(final String databaseName) {
    try (final var session =
             driver.session(SessionConfig.forDatabase(databaseName))) {
      final var result = session.run("match( n:ANNOTATION ) return n");
      while (result.hasNext()) {
        final var record = result.next();
        record.keys().forEach(key -> {
          final var node = record.get(key).asNode();
          node.keys().forEach(propertyKey -> {
            final var propertyValue = node.get(propertyKey);
            System.out.println(propertyKey + ": " + propertyValue);
          });
        });
      }
    }
  }

  public static void main(String... args) {
    final var dotenv = Dotenv.configure().filename(".env").load();
    final var dbUri = dotenv.get("NEO4J_URI");
    final var dbUser = dotenv.get("NEO4J_USERNAME");
    final var dbPassword = dotenv.get("NEO4J_PASSWORD");
    final var dbName = dotenv.get("NEO4J_DATABASE");

    if (dbUri == null || dbUser == null || dbPassword == null) {
      System.err.println("Missing environment variables");
      return;
    }

    try (final var connection = new Main(dbUri, dbUser, dbPassword)) {
      connection.example(dbName);
    }
  }
}
