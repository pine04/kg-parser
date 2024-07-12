package jda.parser.resource;

import java.io.File;
import java.util.ArrayDeque;
import java.util.HashSet;

public class Resource {
  private static final String[] resource = {
      "jda/main/src/main/java/jda/modules/sccl/syntax",
      "jda/main/src/main/java/jda/modules/mccl/syntax"};

  public static final HashSet<File> bfsScan() {
    var result = new HashSet<File>();
    var directories = new ArrayDeque<File>();
    for (final var path : resource) {
      final var startDir = new File(path);
      if (startDir.exists() && startDir.isDirectory()) {
        directories.add(startDir);
      }
    }

    while (!directories.isEmpty()) {
      final var currentDir = directories.poll();
      final var filesList = currentDir.listFiles();
      if (filesList != null) {
        for (final var file : filesList) {
          if (file.isFile()) {
            System.out.println("File: " + file.getAbsolutePath());
            result.add(file);
          } else if (file.isDirectory()) {
            directories.add(file);
          }
        }
      }
    }

    return result;
  }
}
