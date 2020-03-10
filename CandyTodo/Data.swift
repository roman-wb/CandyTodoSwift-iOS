//
//  Data.swift
//  CandyTodo
//
//  Created by roman on 19.02.2020.
//  Copyright © 2020 ROMAN DOBYNDA. All rights reserved.
//

import Foundation

struct Task {
    var done: Bool
    var title: String
}

struct Notify {
    var title: String
}

let TodoData = [
    Task(done: true, title: "Read Type Guidelines"),
    Task(done: false, title: "Complete Responsive Design"),
    Task(done: false, title: "Bring Groceries"),
    Task(done: true,  title: "Take Muffy for walk"),
    Task(done: false, title: "Talk to Pamela and Betty"),
    Task(done: false, title: "Long long long long long long long long long long long long long long Talk to Pamela and Betty"),
    Task(done: false, title: "Read Type Guidelines"),
    Task(done: false, title: "Complete Responsive Design"),
    Task(done: false, title: "Bring Groceries"),
    Task(done: false, title: "Take Muffy for walk"),
    Task(done: true,  title: "Talk to Pamela and Betty"),
    Task(done: false, title: "Long long long long long long long long long long long long long long Talk to Pamela and Betty"),
    Task(done: false, title: "Read Type Guidelines"),
    Task(done: false, title: "Complete Responsive Design"),
    Task(done: false, title: "Bring Groceries"),
    Task(done: true,  title: "Take Muffy for walk"),
    Task(done: false, title: "Talk to Pamela and Betty"),
    Task(done: false, title: "Long long long long long long long long long long long long long long Talk to Pamela and Betty"),
    Task(done: false, title: "Read Type Guidelines"),
    Task(done: false, title: "Complete Responsive Design"),
    Task(done: true,  title: "Bring Groceries"),
    Task(done: false, title: "Take Muffy for walk"),
    Task(done: false, title: "Talk to Pamela and Betty"),
    Task(done: false, title: "Long long long long long long long long long long long long long long Talk to Pamela and Betty"),
]

let SchedulerData = [
        (
            title: "Tomorrow",
            tasks: [
                Task(done: false, title: "Clean Room"),
                Task(done: false, title: "Take Abby to Doctor"),
            ]
        ),
        (
            title: "Sat, Aug 5, 2017",
            tasks: [
                Task(done: false, title: "Sleep in the afternoon"),
                Task(done: true,  title: "Talk to Mom"),
                Task(done: false, title: """
                                         Long long long long long long long long long long long long long long Long long
                                         long long long long long long long long long long long long
                                         """),
            ]
        ),
        (
            title: "Mon, Aug 7, 2017",
            tasks: [
                Task(done: false, title: "Go to Amber Park"),
                Task(done: false, title: "Clean Room"),
            ]
        ),
    ]

let NotificationsData = [
    (
        title: "Today",
        notifies: [
            Notify(title: "Hooray! You have completed all the tasks for today"),
            Notify(title: "A new update is available! Go to Play Store"),
        ]
    ),
    (
        title: "Yesterday",
        notifies: [
            Notify(title: "Sleep in the afternoon"),
            Notify(title: "You missed one task yesterday"),
            Notify(title: """
                          Long long long long long long long long long long long long long long Long long
                          long long long long long long long long long long long long
                          """),
        ]
    ),
    (
        title: "Tue, Aug 1, 2017",
        notifies: [
            Notify(title: "You missed one task yesterday"),
        ]
    ),
]

let SettingsData = [
    (
        title: "Notification Settings",
        items: ["Get email notifications", "Vibrate on alert"]
    ),
    (
        title: "Floss Settings",
        items: ["Share profile with other floss users hare profile with other floss users",
                "Show your task completion status",
                """
                Long long long long long long long long long long long long long long Long
                long long long long long long long long long long long long long
                """,
        ]
    ),
]

let MenuData = ["To-do", "Scheduler", "Notifications", "Profile", "Logout"]

#if canImport(SwiftUI) && DEBUG
let PreviewDevices = ["iPhone SE", "iPhone 8", "iPhone 11 Pro Max", "iPad Air (3rd generation)"]
#endif
