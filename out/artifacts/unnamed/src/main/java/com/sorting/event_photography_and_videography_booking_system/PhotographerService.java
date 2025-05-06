package com.sorting.event_photography_and_videography_booking_system;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class PhotographerService {
    private static final String FILE_PATH = "D:/project/Event Photography and Videography Booking System/src/main/webapp/Database/photographers.txt";

    // Read photographers from file
    public List<Photographer> getPhotographers() {
        List<Photographer> photographers = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length == 4) {
                    String name = data[0];
                    double rating = Double.parseDouble(data[1]);
                    double price = Double.parseDouble(data[2]);
                    String eventType = data[3];
                    photographers.add(new Photographer(name, rating, price, eventType));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return photographers;
    }

    // Bubble Sort photographers by rating
    public List<Photographer> sortByRating(List<Photographer> photographers) {
        int n = photographers.size();
        for (int i = 0; i < n - 1; i++) {
            for (int j = 0; j < n - i - 1; j++) {
                if (photographers.get(j).getRating() < photographers.get(j + 1).getRating()) {
                    // Swap
                    Photographer temp = photographers.get(j);
                    photographers.set(j, photographers.get(j + 1));
                    photographers.set(j + 1, temp);
                }
            }
        }
        return photographers;
    }
    public List<Photographer> sortByPrice(List<Photographer> photographers, boolean ascending) {
        int n = photographers.size();
        for (int i = 0; i < n - 1; i++) {
            for (int j = 0; j < n - i - 1; j++) {
                if ((ascending && photographers.get(j).getPrice() > photographers.get(j + 1).getPrice()) ||
                        (!ascending && photographers.get(j).getPrice() < photographers.get(j + 1).getPrice())) {
                    // Swap
                    Photographer temp = photographers.get(j);
                    photographers.set(j, photographers.get(j + 1));
                    photographers.set(j + 1, temp);
                }
            }
        }
        return photographers;
    }

    // Filter photographers by event type
    public List<Photographer> filterByEventType(List<Photographer> photographers, String eventType) {
        List<Photographer> filteredList = new ArrayList<>();
        for (Photographer p : photographers) {
            if (p.getEventType().equalsIgnoreCase(eventType)) {
                filteredList.add(p);
            }
        }
        return filteredList;
    }
}
