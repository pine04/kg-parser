package jda.parser;

import com.github.javaparser.StaticJavaParser;
import com.github.javaparser.ast.body.AnnotationDeclaration;
import com.github.javaparser.ast.comments.BlockComment;
import com.github.javaparser.ast.visitor.VoidVisitorAdapter;
import java.io.File;

public class Parser {
  public final static void parse(File file) {
    try {
      var parsed = StaticJavaParser.parse(file);
      new NodeVisitor().visit(parsed, null);
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  private static class NodeVisitor extends VoidVisitorAdapter<Void> {
    @Override
    public void visit(AnnotationDeclaration n, Void arg) {
      System.out.println(
          n.getClass().getSimpleName() /* + ": " + n.toString() */);
      super.visit(n, arg);
    }

    @Override
    public void visit(BlockComment n, Void arg) {
      System.out.println(
          n.getClass().getSimpleName() /* + ": " + n.toString() */);
      super.visit(n, arg);
    }
  }
}
