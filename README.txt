My Portfolio IOS "Task Manager"

This is my first experience after learning the basic knowledge of IOS development. An application created for better learning and gaining practical knowledges. The functionality of the application is to create tasks for the corresponding category and record the entire progress of the task in the application for real-time and future monitoring.

Features:
  1) Creating category for tasks with preferable color and title
  2) Creating task with title,description,start & end date and subtasks wich is switchs to chekmarks after creation task
  3) On the main screen, the application has two sections, the first section has two banners/links: "Category" and "Completed", which navigate to the corresponding page where you can view categories and completed tasks, in the second section "Current tasks", where all uncomplited tasks.
4) The task page has visual elements, such as a progress bar that shows the status of the task as a percentage,at the bottom of the page there is a list of current subtasks with a checkmark on the left and the subtask name on the right, the subtask's names have an edit function that works when you tap on the subtask name, the checkmarks work dynamically with a progress bar and a percentage value, for example, when a task has four subtasks, where only two are completed, the progress bar shows 50% and when the third subtask is marked as completed at that time, the progress bar and the percentage value are dynamically increase. In the top left corner there is a button labeled "Add New Subtask" which adds the new subtask to the existing subtasks and checks that the new subtask is not empty or contains only spaces, after adding a new subtask to the list of existing subtasks, the value of progresbar and precentege is dynamically decremented.
5) All tasks has delete action, wich works with swiping to the left in list inside Home,Categorie and Completed pages,

Libraries:
1)SwiftUI
2)CoreData

