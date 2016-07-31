$(document).on('turbolinks:load', function() {
  $("#calendar").fullCalendar({
    firstDay: 1,
    events: function(start, end, timezone, callback) {
      $.ajax({
        url: "/events",
        dataType: "json",
        data: {
          start: start.unix(),
          end: end.unix(),
          _: Date.now()
        },
        success: function(doc) {
          $("#all_business_days").val(doc.business_days);

          uniqueHolidayDays = [];
          uniqueHolidayHash = {};
          $.each(doc.events, function(index, event) {
            date = new Date(event.date);
            if(!uniqueHolidayHash[event.date] && date.getMonth() + 1 == doc.month) {
              uniqueHolidayHash[event.date] = event;
              uniqueHolidayDays.push(event);
            }
          });
          $("#holidays").val(uniqueHolidayDays.length);
          calculate();

          callback(doc.events);
        }
      });
    }
  });
});
