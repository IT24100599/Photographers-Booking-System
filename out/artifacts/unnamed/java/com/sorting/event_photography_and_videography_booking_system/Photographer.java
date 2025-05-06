package com.sorting.event_photography_and_videography_booking_system;

public class Photographer {
    private String name;
    private double rating;
    private double price;
    private String eventType;

    public Photographer(String name, double rating, double price, String eventType) {
        this.name = name;
        this.rating = rating;
        this.price = price;
        this.eventType = eventType;
    }

    public String getName() {
        return name;
    }

    public double getRating() {
        return rating;
    }

    public double getPrice() {
        return price;
    }

    public String getEventType() {
        return eventType;
    }
}
