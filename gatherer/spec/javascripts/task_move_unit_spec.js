describe("with a list of tasks", function() {

  beforeEach(function() {
    jasmine.addMatchers(customMatchers);
    table = affix("table");
    table.affix("tr.task#task_1 a.up");
    table.affix("tr.task#task_2 a.up+a.down");
    table.affix("tr.task#task_3 a.up");
  });

  it("identifies row from target", function() {
    expect(Project.taskFromAnchor($("#task_2 .up"))).toHaveId("task_2")
  });

  it("identifies predecessor if it exists", function() {
    expect(Project.previousTask($("#task_2"))).toHaveId("task_1");
  });

  it("returns null as a predecessor if there is none", function() {
    expect(Project.previousTask($("#task_1"))).toBeNull();
  });

  it("can swap two rows", function() {
    Project.swapRows($("#task_1"), $("#task_2"));
    expect($("tr")).toMatchDomIds(["task_2", "task_1", "task_3"]);
  });

  //START:spy
  it("can handle up click", function() {
    spyOn(Project, 'taskFromAnchor').and.returnValue($("#task_2"))
    Project.upClickOn($("#task_2 .up"));
    expect($("tr")).toMatchDomIds(["task_2", "task_1", "task_3"]);
    expect(Project.taskFromAnchor).toHaveBeenCalled();
  });
  //END:spy

});
