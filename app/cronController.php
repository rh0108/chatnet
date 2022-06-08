<?php
namespace App;

/* This class is handling all the requests in the cron*/

class cronController{

    function delete_guests() {
        if (SETTINGS['guest_inactive_hours'] > 0) {
            app('db')->where ('user_type', 3);
            app('db')->where ('last_seen <= (NOW() - interval '.SETTINGS['guest_inactive_hours'].' hour) OR last_seen IS NULL');
            $users = app('db')->get('users', null, 'id');
            foreach ($users as $user) {
                $delete_user = $user['id'];
                if (isset(SETTINGS['unlink_with_delete']) && SETTINGS['unlink_with_delete'] == true) {

                    //unlink group chats files
                    app('db')->where('sender_id', $delete_user);
                    app('db')->where('type', Array(2, 6, 7, 8), 'IN');
                    $group_chats = app('db')->get('group_chats');
                    foreach ($group_chats as $chat) {
                        app('chat')->unlink_files($chat['message'], $chat['type']);
                    }

                    //unlink private chats files
                    app('db')->where('sender_id', $delete_user);
                    app('db')->where('type', Array(2, 6, 7, 8), 'IN');
                    $private_chats = app('db')->get('private_chats');
                    foreach ($private_chats as $chat) {
                        app('chat')->unlink_files($chat['message'], $chat['type']);
                    }
                }
                app('db')->where ('user', $delete_user);
                app('db')->delete('group_users');

                app('db')->where ('sender_id', $delete_user);
                app('db')->delete('group_chats');

                app('db')->where ('from_user', $delete_user);
                app('db')->delete('private_chat_meta');

                app('db')->where ('sender_id', $delete_user);
                app('db')->delete('private_chats');

                app('db')->where ('id', $delete_user);
                app('db')->delete('users');
            }
        }
    }

    function delete_group_chats() {
        if (SETTINGS['delete_group_chat_hours'] > 0) {
            if (isset(SETTINGS['unlink_with_delete']) && SETTINGS['unlink_with_delete'] == true) {
                //unlink group chats files
                app('db')->where ('time <= (NOW() - interval '.SETTINGS['delete_group_chat_hours'].' hour)');
                app('db')->where('type', Array(2, 6, 7, 8), 'IN');
                $group_chats = app('db')->get('group_chats');
                foreach ($group_chats as $chat) {
                    app('chat')->unlink_files($chat['message'], $chat['type']);
                }
            }
            app('db')->where ('time <= (NOW() - interval '.SETTINGS['delete_group_chat_hours'].' hour)');
            app('db')->delete('group_chats');
        }
    }

    function delete_private_chats() {
        if (SETTINGS['delete_private_chat_hours'] > 0) {
            if (isset(SETTINGS['unlink_with_delete']) && SETTINGS['unlink_with_delete'] == true) {
                //unlink group chats files
                app('db')->where ('time <= (NOW() - interval '.SETTINGS['delete_private_chat_hours'].' hour)');
                app('db')->where('type', Array(2, 6, 7, 8), 'IN');
                $private_chats = app('db')->get('private_chats');
                foreach ($private_chats as $chat) {
                    app('chat')->unlink_files($chat['message'], $chat['type']);
                }
            }
            app('db')->where ('time <= (NOW() - interval '.SETTINGS['delete_private_chat_hours'].' hour)');
            app('db')->delete('private_chats');
        }
    }

     /*============================ SCHEDULER ============================*/
     function schedule_chats() {
        app('db')->where ('time <= NOW()');
        $schedule_chats = app('db')->get('schedule_chats');
        if(count($schedule_chats) > 0) {
            var_dump($schedule_chats);
            foreach ($schedule_chats as $chat) { 
                $message_list = explode("<br/>", $chat['message']);                
                $msg_index = ($chat['last_sent_msg_index'] - 1) % count($message_list);
                $message = $message_list[$msg_index];
                $data = Array ("user_1" => $chat['user_1'],
                                   "user_2" => $chat['user_2'],
                                   "sender_id" => $chat['sender_id'],
                                   "room_id" => $chat['room_id'],
                                   "type" => 1,
                                   "message" => $message,
                                   "status" => 1,
                                   "time" => $chat['time'],
                                   "updated_at" => app('db')->now(),
                                );
                $id = app('db')->insert ('private_chats', $data);
                app('db')->where('id', $id);
                $chat_data = app('db')->getOne('private_chats');

                if($chat['chat_meta_id']){
                    app('db')->where('id', $chat['chat_meta_id']);
                    $chat_meta_data = app('db')->getOne('private_chat_meta');

                    $update_meta = array();
                    $update_meta['chat_meta_id'] = $chat_meta_data['id'];
                    $update_meta['unread_count'] = $chat_meta_data['unread_count'] + 1;
                    $update_meta['last_chat_id'] = $id;
                    $update_meta['is_typing'] = 0;
                    app('chat')->updateChatMetaData($update_meta);

                    if($chat['user_2'] > $chat['user_1']) {
                        $to_user = $chat['user_2'];
                    }else{
                        $to_user = $chat['user_1'];
                    }

                    //active user chat meta
                    $to_user_chat_meta_data = app('chat')->getChatMetaData($to_user, $chat['sender_id'], $chat['room_id']);
                    $to_user_update_meta = array();
                    $to_user_update_meta['chat_meta_id'] = $to_user_chat_meta_data['id'];
                    $to_user_update_meta['last_chat_id'] = $id;
                    app('chat')->updateChatMetaData($to_user_update_meta);
                }
                if($id) {
                    $chat['time'] = date('Y-m-d H:i', strtotime($chat['time']. ' + 7 days'));                    
                    $chat['last_sent_msg_index'] = app('chat')->getLastSentMsgIndex($chat['user_1'], $chat['user_2'], $chat['room_id']) + 1;
                    app('db')->where ('id = '.$chat['id']);
                    $result = app('db')->update('schedule_chats',$chat);                    
                }
            }
        } else {
            echo "No message scheduled.";
        }    
    }
    /*============================ /SCHEDULER ============================*/
}
