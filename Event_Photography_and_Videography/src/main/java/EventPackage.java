public class EventPackage {
    private String packageId;
    private String packageName;
    private String packageDescription;
    private double Price;
    private int hoursCoverage;
    private int photographers;
    private boolean edittingEnabled;
    private boolean videoIncluded;

    public EventPackage() {
    }

    public String getPackageId() {
        return packageId;
    }

    public void setPackageId(String packageId) {
        this.packageId = packageId;
    }

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }

    public String getPackageDescription() {
        return packageDescription;
    }

    public void setPackageDescription(String packageDescription) {
        this.packageDescription = packageDescription;
    }

    public double getPrice() {
        return Price;
    }

    public void setPrice(double price) {
        Price = price;
    }

    public int getHoursCoverage() {
        return hoursCoverage;
    }

    public void setHoursCoverage(int hoursCoverage) {
        this.hoursCoverage = hoursCoverage;
    }

    public int getPhotographers() {
        return photographers;
    }

    public void setPhotographers(int photographers) {
        this.photographers = photographers;
    }

    public boolean isEdittingEnabled() {
        return edittingEnabled;
    }

    public void setEdittingEnabled(boolean edittingEnabled) {
        this.edittingEnabled = edittingEnabled;
    }

    public boolean isVideoIncluded() {
        return videoIncluded;
    }

    public void setVideoIncluded(boolean videoIncluded) {
        this.videoIncluded = videoIncluded;
    }
}
