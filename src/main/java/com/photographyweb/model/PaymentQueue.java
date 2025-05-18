package com.photographyweb.model;

public class PaymentQueue {

    private class Node {
        Payment payment;
        Node next;

        Node(Payment payment) {
            this.payment = payment;
            this.next = null;
        }
    }

    private Node head;
    private Node tail;
    private int size;

    public PaymentQueue() {
        this.head = null;
        this.tail = null;
        this.size = 0;
    }

    public synchronized void add(Payment payment) {
        Node newNode = new Node(payment);

        if (isEmpty()) {
            head = newNode;
            tail = newNode;
        } else {
            tail.next = newNode;
            tail = newNode;
        }

        size++;
    }

    public synchronized Payment poll() {
        if (isEmpty()) {
            return null;
        }

        Payment payment = head.payment;
        head = head.next;

        if (head == null) {
            tail = null;
        }

        size--;
        return payment;
    }

    public synchronized boolean isEmpty() {
        return head == null;
    }

    public synchronized int size() {
        return size;
    }

    public synchronized Payment peek() {
        if (isEmpty()) {
            return null;
        }
        return head.payment;
    }
}