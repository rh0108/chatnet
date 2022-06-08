/*============================ SCHEDULER ============================*/
(function(){

    "use strict";

    //Get current user's schedule message function
    const SETTINGS = {
        'system_timezone': '{{SETTINGS.timezone}}',
        'system_timezone_offset': '{{SYSTEM_TIMEZONE_OFFSET}}',
    }

    // User Object
    const USER = {
        'id': parseInt('{{ USER.id }}'),
        'user_type': parseInt('{{ USER.user_type }}'),
        'dob': '{{ USER.dob }}',
        'timezone': '{{USER.timezone}}'
    }

    var favourite_user_list = [];
    loadFavUsers();

    $(document).on('click', '.btn-send-schedule', function(e) {        
        getScheduleMessage();
    });

    //Send schedule message function
    $(document).on('click', '#sendSchedule', function(e) {
        sendScheduleMessages();
    });

    //Stop schedule message function
    $(document).on('click', '#stopSchedule', function(e) {        
        deleteScheduleMessages();
    });

    //Refresh message body function
    $(document).on('click', '#scheduleRefresh', function(e) {        
        $('#schedule_msg_body').val("");
    });

    // new schedule message save
    function newScheduleMessage(message_data, active_user, schedule_dates, decode=true){
        var random_id = Math.random();
        if(message_data != ""){        
            var active_group = $("#active_group").val();
            var active_room = $("#active_room").val();
            var chat_meta_id = $("#chat_meta_id").val();
            if (active_user) {
                active_group = null;
            }        
            $.ajax({
                url: "{{ url('ajax-save-schedule-message') }}",
                type: "POST",
                dataType: 'json',
                data: {
                    csrftoken: '{{ csrf_token_ajax() }}',
                    active_user: active_user,
                    active_group: active_group,
                    active_room: active_room,
                    chat_meta_id: chat_meta_id,
                    message_content: message_data,
                    schedule_date: schedule_dates,                
                    random_id: random_id,
                },
                success: function(data) {
                    if(data.status) {
                        toastr.success(
                            data.message, '',
                            {
                                timeOut: 3000,
                                fadeOut: 3000,
                            }
                        );
                        $('#scheduleModal').modal('toggle');
                    } else {
                        toastr.error(
                            data.message, '',
                            {
                                timeOut: 1500,
                                fadeOut: 1500,
                            }
                        );         
                    }                
                }
            });
        }    
    }

    //send schedule messages
    function sendScheduleMessages() {
        var msg_content = $('#schedule_msg_body').val();
        var schedule_times = [];
        $("input[name='weekday']:checked").each(function (index, obj) {
            schedule_times.push(obj.value);
        });        
        if (msg_content != "") {
            var schedules = [];
            var today = new Date();
            var day = today.getDay();
            for(var i = 0 ; i < schedule_times.length ; i++) {
                var schedule_date = new Date(today.getTime() + (schedule_times[i] - day) * 24 * 3600 * 1000);
                if($('.days-of-week-time').val() != "") {
                    var time_array = $('.days-of-week-time').val().split(':');
                    schedule_date.setHours(time_array[0]);
                    schedule_date.setMinutes(time_array[1]);    
                } else {
                    schedule_date.setHours(0);
                    schedule_date.setMinutes(0);
                }
                if(schedule_date.getTime() < today.getTime()) {
                    schedule_date = new Date(schedule_date.getTime() + 7 * 24 * 3600 * 1000);
                }
                var schedule_date_str = moment(schedule_date.getTime()).format('YYYY-MM-DD HH:mm');                
                schedules.push(moment(schedule_date_str).tz(SETTINGS.system_timezone).format('YYYY-MM-DD HH:mm'));
            }
            var send_mode = $('#scheduleUserType').val();
            if(send_mode == 1) {                        //New
                var active_user = $("#active_user").val();                        
                if(active_user == "")
                    alert("{{_('Select User!')}}");
                else
                    newScheduleMessage(msg_content, active_user, schedules, false);
            } else if(send_mode == 2) {
                $.ajax({
                        url: "{{ url('ajax-delete-schedule-messages') }}",
                        type: "POST",
                        dataType: 'json',
                        data: {
                            csrftoken: '{{ csrf_token_ajax() }}',
                            room_id: $("#active_room").val(),
                            current_user_id: $("#active_user").val(),
                        },
                        success: function(data) {
                            newScheduleMessage(msg_content, $("#active_user").val(), schedules, false);        
                        }
                    });
            } else {                 //Favourites                        
                if(favourite_user_list == "")
                    alert("{{_('Add favourite user!')}}")
                else
                    favourite_user_list.forEach(function(fav_user) {
                        newScheduleMessage(msg_content, fav_user['user_id'], schedules, false);    
                    });                        
            }            
        } else {
            toastr.error(
                "{{_('Empty Message')}}", '',
                {
                    timeOut: 1500,
                    fadeOut: 1500,
                }
            );
        }
    }

    //get current user's schedule message
    function getScheduleMessage() {
        $.ajax({
            url: "{{ url('ajax-get-schedule-messages') }}",
            type: "POST",
            dataType: 'json',
            data: {
                csrftoken: '{{ csrf_token_ajax() }}',
                room_id: $("#active_room").val(),
                current_user_id: $("#active_user").val(),
            },
            success: function(data) {                
                if(data.schedule_messages.length > 0) {       
                    $('#scheduleUserType').html("<option value = '2'>" + $("#active_user_name").val() + "</option><option value = '3'>Favourites</option>");
                    $('#scheduleUserType').val(2);
                    $('#schedule_msg_body').val('');
                    $("input[name='weekday']").each(function (index, obj) {                            
                        $(this).prop('checked', false);                            
                    });
                    data.schedule_messages.forEach(function(msg) {
                        var time = new Date(moment(msg.time+SETTINGS.system_timezone_offset));
                        $("input[name='weekday']").each(function (index, obj) {
                            if(index == time.getDay()) {
                                $(this).prop('checked', true);
                            }
                        });                        
                        $('.days-of-week-time').val(moment(msg.time+SETTINGS.system_timezone_offset).format("hh:mm"));
                    });

                    data.rest_messages.forEach(function(msg) {
                        var current = $('#schedule_msg_body').val();
                        if(current != '') {
                            current += '\n';
                        }
                        current += msg;
                        $('#schedule_msg_body').val(current);
                    });       
                } else {
                    $('#scheduleUserType').html("<option value = '1'>New</option><option value = '3'>Favourites</option>");
                    $('#scheduleUserType').val(1);
                    $('#schedule_msg_body').val('');
                }
            }
        });
    }

    //stop schedule messages
    function deleteScheduleMessages() {
        $.ajax({
            url: "{{ url('ajax-delete-schedule-messages') }}",
            type: "POST",
            dataType: 'json',
            data: {
                csrftoken: '{{ csrf_token_ajax() }}',
                room_id: $("#active_room").val(),
                current_user_id: $("#active_user").val(),
            },
            success: function(data) {
                if(data == true) {
                    toastr.success(
                        "Stop all schedule messages!", '',
                        {
                            timeOut: 3000,
                            fadeOut: 3000,
                        }
                    );
                    $('#scheduleUserType').html("<option value = '1'>New</option><option value = '3'>Favourites</option>");                    
                    $('#scheduleUserType').val(1);
                    $('#schedule_msg_body').val('');                
                    $("input[name='weekday']").each(function (index, obj) {                    
                        $(this).prop('checked', false);                    
                    });
                    $('.days-of-week-time').val('');
                }
            }
        });
    }

    //Load Favourites users.
    function loadFavUsers() {
        var active_room = $("#active_room").val();
        var user_list_sec = $(".list-section.active").attr('id');
        $.ajax({
            url: "{{ url('ajax-online-list') }}",
            type: "POST",
            dataType: 'json',
            data: {
                csrftoken: '{{ csrf_token_ajax() }}',
                active_room: active_room,
                user_list_section: user_list_sec,
            },
            success: function(data) {                
                if ('list' in data) {
                    $.each(data.list, function( index, obj ) {
                        if(obj.is_favourite && !obj.blocked_by_you){
                            favourite_user_list.push(obj);
                        }
                    });                      
                }                
            }
        });
    }
})();
/*============================ /SCHEDULER ============================*/