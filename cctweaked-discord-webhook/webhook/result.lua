return function()
  while true do
    local args = { os.pullEvent() };
    ---@type MessageResult
    local messageResult = {
      url = args[2],
      successed = false
    }
    if args[1] == "http_failure" then
      ---@type http.Response|nil
      local handle = args[4]
      if #args[3] == "Could not connect" then
        messageResult.reason = "Could not connect";
      elseif handle then
        local code = handle.getResponseCode();
        local errorJson = handle.readAll();
        if errorJson then
          messageResult.errorResponse = textutils.unserialiseJSON(errorJson);
        end
        if code == 400 then
          messageResult.reason = "Bad Request";
        elseif code == 401 then
          messageResult.reason = "Wrong Token";
        elseif code == 404 then
          messageResult.reason = "Not Found";
        elseif code == 429 then
          messageResult.reason = "Too Many Requests";
        end
      end
      return messageResult;
    elseif args[1] == "http_success" then
      messageResult.successed = true;
      ---@type http.Response
      local handle = args[3];
      messageResult.message = textutils.unserialiseJSON(handle.readAll());
      return messageResult;
    end
  end
end
