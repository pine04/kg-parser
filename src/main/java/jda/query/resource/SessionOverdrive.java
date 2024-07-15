package jda.query.resource;

import org.neo4j.driver.Session;

public class SessionOverdrive {
  private final Session session;
  public SessionOverdrive(final Session session) { this.session = session; }

  public void debug() {
    System.out.println(session.toString());
  }
}
