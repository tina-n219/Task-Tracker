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

$(function () {
    $('#start-work-button').click((ev) => {
      let task_id = $(ev.target).data('task-id');
      let startTime = "~N[2000-01-01 23:00:07]";
      let endTime = "~N[2000-01-01 23:00:07]";
  
      let text = JSON.stringify({
        timeblock: {
          task_id: task_id,
          startTime: startTime,
          endTime: endTime
        },
      });
      console.log(text);

      $.ajax(timeblocks_path, {
        method: "post",
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        data: text,
        success: (resp) => {
          $('#timeblock-form').text(`(your sart time: ${resp.data.startTime})`);
        },
      });
    });
  });