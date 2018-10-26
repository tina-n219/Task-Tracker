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
      });
  });

  window.editTimeBlock = (ev) => {
    let timeBlock_id = $(ev).data('timeblock-id');

    $('#startTD' + timeBlock_id).hide();
    $('#endTD' + timeBlock_id).hide();
    $('#startInput' + timeBlock_id).show();
    $('#endInput' + timeBlock_id).show();  
    
    $('#edit-work-button' + timeBlock_id).hide();
    $('#save-work-button' + timeBlock_id).show(); 
  }

  window.saveTimeBlock = (ev) => {
    let timeBlock_id = $(ev).data('timeblock-id');
    let task_id = $(ev).data('task-id');

    let sTime = $('#start-'+timeBlock_id).val();
    let eTime = $('#end-'+timeBlock_id).val();

    let newStart = new Date(sTime);
    let newEnd = new Date(eTime);

    let text = JSON.stringify({
      timeblock: {
        startTime: newStart,
        endTime: newEnd,
        task_id: task_id,
      }
    });
    console.log(newStart);
    console.log(newEnd);

    $.ajax("/ajax/timeblocks/" + timeBlock_id, {
      method: "put",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: text,
    }).done(() => {
      location.reload();
    });

    $('#startTD' + timeBlock_id).show();
    $('#endTD' + timeBlock_id).show();
    $('#startInput' + timeBlock_id).hide();
    $('#endInput' + timeBlock_id).hide();  
    
    $('#edit-work-button' + timeBlock_id).show();
    $('#save-work-button' + timeBlock_id).hide();
  }
});


