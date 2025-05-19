import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class PackageService {
    private static final String FILE_PATH = "D:\\Java Projects\\Event_Photography_and_Videography\\data\\packages.txt";

    public List<EventPackage> getAllPackages() {
        return readFromFile();
    }

    public void addPackage(EventPackage pkg) {
        List<EventPackage> packages = readFromFile();
        packages.add(pkg);
        writeToFile(packages);
    }

    public void updatePackage(EventPackage updatedPackage) {
        List<EventPackage> packages = readFromFile();
        packages.removeIf(p -> p.getPackageId().equals(updatedPackage.getPackageId()));
        packages.add(updatedPackage);
        writeToFile(packages);
    }

    public void deletePackage(String packageId) {
        List<EventPackage> packages = readFromFile();
        packages.removeIf(p -> p.getPackageId().equals(packageId));
        writeToFile(packages);
    }

    private List<EventPackage> readFromFile() {
        List<EventPackage> packages = new ArrayList<>();
        File file = new File(FILE_PATH);

        if (!file.exists()) {
            return packages;
        }

        try(BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))){

            reader.readLine();

            String line;
            while ((line = reader.readLine()) != null){
                String[] parts = line.split(",");
                if (parts.length == 8) {
                    EventPackage pkg = new EventPackage();
                    pkg.setPackageId(parts[0]);
                    pkg.setPackageName(parts[1]);
                    pkg.setPackageDescription(parts[2]);
                    pkg.setPrice(Double.parseDouble(parts[3]));
                    pkg.setHoursCoverage(Integer.parseInt(parts[4]));
                    pkg.setPhotographers(Integer.parseInt(parts[5]));
                    pkg.setEdittingEnabled(Boolean.parseBoolean(parts[6]));
                    pkg.setVideoIncluded(Boolean.parseBoolean(parts[7]));
                    packages.add(pkg);
                }
            }
        }catch (IOException e){
            e.printStackTrace();
        }
        return packages;
    }

    private void writeToFile(List<EventPackage> packages) {
        new File(FILE_PATH).getParentFile().mkdirs();

        try(BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))){
            writer.write("packageId,packageName,description,price,hoursCoverage,photographers,edittingEnabled,videoIncluded\n");
            for (EventPackage pkg : packages) {
                writer.write(String.format("%s, %s, %s, %.2f, %d, %d, %b,%b\n",
                        pkg.getPackageId(),
                        pkg.getPackageName(),
                        pkg.getPackageDescription(),
                        pkg.getPrice(),
                        pkg.getHoursCoverage(),
                        pkg.getPhotographers(),
                        pkg.isEdittingEnabled(),
                        pkg.isVideoIncluded()));
            }
        }catch (IOException e){
            e.printStackTrace();
        }
    }
}
