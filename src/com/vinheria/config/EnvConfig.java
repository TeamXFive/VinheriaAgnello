package com.vinheria.config;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

/**
 * Carrega pares KEY=VALUE de um arquivo .env na raiz do projeto.
 * Procura em: user.dir, catalina.base, diretório pai do war expandido.
 * Fallback para System.getenv(key) quando a chave não está no arquivo.
 */
public final class EnvConfig {

    private static final Map<String, String> VALUES = new HashMap<>();
    private static boolean loaded = false;

    private EnvConfig() {}

    public static synchronized String get(String key) {
        if (!loaded) load();
        String v = VALUES.get(key);
        return v != null ? v : System.getenv(key);
    }

    public static String get(String key, String defaultValue) {
        String v = get(key);
        return (v == null || v.isEmpty()) ? defaultValue : v;
    }

    private static void load() {
        loaded = true;
        for (Path candidate : candidates()) {
            if (candidate != null && Files.isRegularFile(candidate)) {
                parse(candidate);
                return;
            }
        }
    }

    private static Path[] candidates() {
        return new Path[] {
            Paths.get(System.getProperty("user.dir", "."), ".env"),
            Paths.get(System.getProperty("catalina.base", "."), ".env"),
            Paths.get(System.getProperty("user.home", "."), ".env")
        };
    }

    private static void parse(Path file) {
        try (BufferedReader br = new BufferedReader(new FileReader(file.toFile()))) {
            String line;
            while ((line = br.readLine()) != null) {
                String trimmed = line.trim();
                if (trimmed.isEmpty() || trimmed.startsWith("#")) continue;
                int eq = trimmed.indexOf('=');
                if (eq <= 0) continue;
                String key = trimmed.substring(0, eq).trim();
                String val = trimmed.substring(eq + 1).trim();
                if (val.length() >= 2
                        && ((val.startsWith("\"") && val.endsWith("\""))
                         || (val.startsWith("'")  && val.endsWith("'")))) {
                    val = val.substring(1, val.length() - 1);
                }
                VALUES.put(key, val);
            }
        } catch (IOException ignored) {}
    }
}
