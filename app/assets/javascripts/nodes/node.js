var Node = function (name, text, level, duration, startdate, enddate, milestone, parent) {
  this.name = name;
  this.text = text;
  this.level = level;
  this.duration = duration;
  this.startdate = startdate;
  if(enddate) {
    this.enddate = getEndDate(startdate, duration);
  } else {
        this.enddate = enddate;
  }

  this.milestone = milestone;
  this.parent = parent;
};

Node.prototype.addDaysToDate = function(startdate, daysToAdd) {
  var newDate = new Date();
  return newDate.setDate( startdate.getDate() + parseInt(daysToAdd) );
};
