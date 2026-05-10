local solveResult = require("cctweaked-discord-webhook.webhook.result");
local settingsToPayload = require("cctweaked-discord-webhook.webhook.settingsToPayload");

---@param self DiscordWebhook
---@param arg1 string|MessageSendSettings
---@param isSynchronously boolean|nil
---@return boolean|MessageResult [1] If `isSynchronously` enabled, this will return MessageResult
local function send(self, arg1, isSynchronously)
  local payload = {
    url = self.url,
    username = self.username,
    avatar_url = self.avatarUrl,
  };
  -- string argment
  if (type(arg1) == "string") then
    payload.content = arg1
  else
    payload = settingsToPayload(self, arg1);
  end

  local requestSuccessed = http.request(
    payload.url,
    textutils.serialiseJSON(payload),
    { ["Content-Type"] = "application/json" },
    false
  )
  if not requestSuccessed then
    return false;
  end
  if isSynchronously then
    return solveResult();
  else
    return requestSuccessed;
  end
end
return send;
