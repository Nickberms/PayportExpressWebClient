package extra_features;

public class NameFormatter {

    // Function to properly format name inputs
    public static String formatName(String name) {
        // Remove leading and trailing spaces
        name = name.trim();
        // Replace multiple spaces with a single space
        name = name.replaceAll("\\s+", " ");
        // Split the string into words
        String[] words = name.split(" ");
        // Capitalize the first letter of each word
        for (int i = 0; i < words.length; i++) {
            if (!words[i].isEmpty()) {
                words[i] = words[i].substring(0, 1).toUpperCase() + words[i].substring(1).toLowerCase();
            }
        }
        // Join the words back together
        return String.join(" ", words);
    }
}