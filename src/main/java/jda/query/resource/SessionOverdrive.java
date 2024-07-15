package jda.query.resource;

import org.neo4j.driver.Session;

public class SessionOverdrive implements AutoCloseable {
  private final Session session;
  public SessionOverdrive(final Session session) { this.session = session; }

  public void debug() {
    final var result = session.run(
        "MATCH (c:CLASS) <- [:ATTACH_TO] - (u:USE_OF_ANNOTATION) - [:INSTANCE_OF] -> (k:ANNOTATION) RETURN c, u, k");

    final var list = result.list();
    list.forEach((record) -> {
      var c = record.get("c").asNode();
      var k = record.get("k").asNode();

      String output =
          String.format("Class: %s, Annotation: %s", c.get("name").asString(),
                        k.get("name").asString());

      System.out.println(output);
    });
  }

  @Override
  public void close() {
    System.out.println("Session ended.");
    session.close();
  }
}
