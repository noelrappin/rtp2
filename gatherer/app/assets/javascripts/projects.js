var Project = {

  taskFromAnchor: function(anchorElement) {
    return anchorElement.parents("tr");
  },

  previousTask: function(task_row) {
    result = task_row.prev();
    if(result.length > 0) {
      return result;
    } else {
      return null;
    }
  },

  nextTask: function(task_row) {
    result = task_row.next();
    if(result.length > 0) {
      return result;
    } else {
      return null;
    }
  },

  swapRows: function(first_row, second_row) {
    second_row.detach();
    second_row.insertBefore(first_row);
  },

  //##START:ajax
  upClickOn: function(anchorElement) {
    row = Project.taskFromAnchor(anchorElement);
    previousRow = Project.previousTask(row);
    if(previousRow == null) { return };
    Project.swapRows(previousRow, row);
    Project.ajaxCall(row.data("task"), "up");
  },

  downClickOn: function(anchorElement) {
    row = Project.taskFromAnchor(anchorElement);
    nextRow = Project.nextTask(row);
    if(previousRow == null) { return };
    Project.swapRows(row, nextRow);
    Project.ajaxCall(row.data("task"), "down");
  },

  ajaxCall: function(taskId, upOrDown) {
    $.ajax({
      url: "/tasks/" + taskId + "/" + upOrDown + ".js",
      data: { "_method": "PATCH"},
      type: "POST"
    }).done(function(data) {
      Project.successfulUpdate(data)
    }).fail(function(data) {
      Project.failedUpdate(data);
    });
  },

  successfulUpdate: function(data) {

  },

  failedUpdate: function(data) {

  }
  //#END:ajax
}

$(function() {
  $(document).on("click", ".up", function(event) {
    event.preventDefault();
    Project.upClickOn($(this));
  });

  $(document).on("click", ".down", function() {
    Project.downClickOn($(this));
  });
})


