package extra_features;

public class NameFormatter {

    public static String formatName(String name) {
        name = name.trim();
        name = name.replaceAll("\\s+", " ");
        String[] words = name.split(" ");
        for (int i = 0; i < words.length; i++) {
            if (!words[i].isEmpty()) {
                words[i] = words[i].substring(0, 1).toUpperCase() + words[i].substring(1).toLowerCase();
            }
        }
        return String.join(" ", words);
    }
}