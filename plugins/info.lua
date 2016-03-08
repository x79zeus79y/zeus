do
local function action_by_reply(extra, success, result)
  local user_info = {}
  local uhash = 'user:'..result.from.id
  local user = redis:hgetall(uhash)
  local um_hash = 'msgs:'..result.from.id..':'..result.to.id
  user_info.msgs = tonumber(redis:get(um_hash) or 0)
  user_info.name = user_print_name(user)..' ['..result.from.id..']'
  local msgs = 'Messages sent : '..user_info.msgs
  if result.from.username then
    user_name = '@'..result.from.username
  else
    user_name = ''
  end
  local msg = result
  local user_id = result.from.id
  local chat_id = msg.to.id
  local user = 'user#id'..msg.from.id
  local channel = 'channel#id'..msg.to.id
  local data = load_data(_config.moderation.data)
  if data[tostring('admins')][tostring(user_id)] then
    who = 'Admin'
  elseif data[tostring(result.to.id)]['moderators'][tostring(user_id)] then
    who = 'Moderator'
  elseif data[tostring(result.to.id)]['set_owner'] == tostring(user_id) then
    who = 'Owner'
  elseif tonumber(result.from.id) == tonumber(our_id) then
    who = 'Teamus Bot'
  else
    who = 'Member'
  end
  for v,user in pairs(_config.sudo_users) do
    if user == user_id then
      who = 'Sudo'
    end
  end
  local text = 'نام و نام خانوادگي : '..(result.from.first_name or '')..' '..(result.from.last_name or '')..'\n\n'
             ..'نام : '..(result.from.first_name or '')..'\n\n'
             ..'نام خانوادگي : '..(result.from.last_name or '')..'\n\n'
             ..'نام کاربري : '..user_name..'\n\n'
             ..'آيدي : '..result.from.id..'\n\n'
             ..msgs..'\n\n'
             ..'درجه : '..who
  send_large_msg(extra.receiver, text)
end

local function run(msg)   
   
    if msg.reply_id and is_momod(msg) then
        msgr = get_message(msg.reply_id, action_by_reply, {receiver=get_receiver(msg)})
    else
    
    local data = load_data(_config.moderation.data)
    if is_sudo(msg) then
      who = 'Sudo'
    elseif is_admin(msg) then
      who = 'Admin'
    elseif is_momod(msg) then
      who = 'Moderator'
    elseif is_owner(msg) then
      who = 'Owner'
    else
      who = 'Member'
  end
  for v,user in pairs(_config.sudo_users) do
    if user == user_id then
      who = 'Sudo'
    end
   end
  
        local text = 'نام و نام خانوادگي : '..msg.from.print_name..'\n\n'
                   ..'نام : '..(msg.from.first_name or '')..'\n\n'
                   ..'نام خانوادگي : '..(msg.from.last_name or '')..'\n\n'
                   ..'نام کاربري : @'..(msg.from.username or '')..'\n\n'
                   ..'آيدي: '..msg.from.id..'\n\n'
                   ..'درجه : '..who
        return text
    end
end
return {
    patterns = {
      '^[#]([Ii]nfo)$',
      '^#info$'
    },
  run = run
}
end
