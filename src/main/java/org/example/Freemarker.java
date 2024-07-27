package org.example;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;

import java.io.IOException;
import java.util.TimeZone;

public class Freemarker {
    private static Configuration cfg = null;

    public static void init() {
        cfg = new Configuration(Configuration.VERSION_2_3_23);

        cfg.setClassForTemplateLoading(Main.class, "/");
        cfg.setDefaultEncoding("UTF-8");
        cfg.setTemplateExceptionHandler(TemplateExceptionHandler.HTML_DEBUG_HANDLER);
        cfg.setLogTemplateExceptions(false);
        cfg.setWrapUncheckedExceptions(true);
        cfg.setFallbackOnNullLoopVariable(false);
        cfg.setSQLDateAndTimeTimeZone(TimeZone.getDefault());
    }

    public static Template getTemplate(String templateName) throws IOException, NullPointerException {
        if (cfg == null) {
            throw new NullPointerException("Freemarker not initialized");
        }

        return cfg.getTemplate(templateName);
    }
}
