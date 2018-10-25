// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.


// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html";
import jQuery from 'jquery';
window.jQuery = window.$ = jQuery;
import "bootstrap";
import _ from "lodash";
import css from "../css/app.scss";

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
var startTime = "~N[2000-01-01 23:00:07]";
var endTime = "~N[2000-01-01 23:00:07]";

$(function () {
  let startAction = $('#start-work-button');
  let stopAction = $('#end-work-button');

  startAction.click((ev) => {
    startTime = new Date();
    startAction.attr("disabled", true);
    stopAction.attr("disabled", false);
  });


  stopAction.click((ev) => {
    let task_id = $(ev.target).data('task-id');
    let endTime = new Date();
    stopAction.attr("disabled", true);
    startAction.attr("disabled", false);
    location.reload();
    let text = JSON.stringify({
      timeblock: {
        startTime: startTime,
        endTime: endTime,
        task_id: task_id,
      },
    });

    $.ajax("/ajax/timeblocks/", {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: text,
    });
  });

  let editAction = $('#edit-work-button');
  let deleteAction = $('#delete-work-button');
  
  deleteAction.click((ev) => {
    console.log("delete");
  let timeBlockID = $(ev.target).data('timeblock-id');
  console.log({timeBlockID});
  location.reload();
    $.ajax("/ajax/timeblocks/" + timeBlockID, {
      method: "delete",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      // success: (resp) => {
      //   $('#timeblock-div').text(`(your update: ${resp.data.task_id})`);
      // },
    });
  });

editAction.click((ev) => {
  console.log("edit");

});
});
