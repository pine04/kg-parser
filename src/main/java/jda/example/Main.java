package jda.example;

import io.github.cdimascio.dotenv.Dotenv;
import jda.query.resource.Connection;

public class Main {
  public static void main(String... args) {
    final var dotenv = Dotenv.configure().filename(".env").load();
    final var dbUri = dotenv.get("NEO4J_URI");
    final var dbUser = dotenv.get("NEO4J_USERNAME");
    final var dbPassword = dotenv.get("NEO4J_PASSWORD");
    final var dbName = dotenv.get("NEO4J_DATABASE");

    if (dbUri == null || dbUser == null || dbPassword == null ||
        dbName == null) {
      System.err.println("Missing environment variables");
      return;
    }

    final var dbConnection = Connection.getInstance(dbUri, dbUser, dbPassword);
    final var session = dbConnection.newSession(dbName);
    session.debug();

    session.close();
    dbConnection.close();
  }
}
