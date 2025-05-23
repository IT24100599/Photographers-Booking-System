package com.paymentMgr.models;

import java.util.ArrayList;

import com.paymentMgr.models.Payment;

public class OrderQueue {
    private ArrayList<Payment> arr;
    private int front;
    @SuppressWarnings("unused")
	private int rear;
    private int count;

    public OrderQueue() {
        arr = new ArrayList<>();
        front = 0;
        rear = 0;
        count = 0;
    }

    public void insert(Payment item, String prompt) {
        System.out.println(prompt + item);
        arr.add(item);
        rear++;
        count++;
    }

    public Payment remove() {
        if (isEmpty()) {
            System.out.println("Queue is empty. Cannot remove item.");
            return null;
        }
        Payment item = arr.get(front);
        System.out.println("Removing: " + item);
        front++;
        count--;
        return item;
    }

    public Payment peekFront() {
        if (isEmpty()) {
            System.out.println("Queue is empty.");
            return null;
        }
        return arr.get(front);
    }

    public boolean isEmpty() {
        return count == 0;
    }

    public int getCount() {
        return count;
    }

}
