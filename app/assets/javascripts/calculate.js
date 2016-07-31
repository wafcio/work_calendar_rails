function calculate() {
  allBusinessDays = parseInt($("#all_business_days").val());
  allBusinessHours = allBusinessDays * 8;
  holidays = parseInt($("#holidays").val());
  businessHoursInHolidays = holidays * 8;
  $("#all_business_hours").val(allBusinessHours);
  $("#business_hours_in_holidays").val(businessHoursInHolidays);

  $("#business_days").val(allBusinessDays - holidays);
  $("#business_hours").val(allBusinessHours - businessHoursInHolidays);
  $("#extended_business_hours").val(8 + (businessHoursInHolidays / allBusinessDays));
};

$(document).on('turbolinks:load', function() {
  $("#calculate_form").on("submit", function (e) {
    e.preventDefault();
    $("#calculate_form input[type=submit]").removeAttr("data-disable-with");
    calculate();
  });
});
