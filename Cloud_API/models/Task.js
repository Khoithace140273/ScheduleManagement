class Task {
    constructor(id, done, titleTask, reminderTime, lastEditedTime) {
        this.id = id;
        this.done = done;
        this.titleTask = titleTask;     this.reminderTime = reminderTime;
        this.lastEditedTime = lastEditedTime;
    }
}

module.exports = Task;