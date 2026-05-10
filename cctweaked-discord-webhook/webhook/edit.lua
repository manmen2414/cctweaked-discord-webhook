local solveResult = require("cctweaked-discord-webhook.webhook.requestResult");
local solveMessageSettings = require("cctweaked-discord-webhook.webhook.solveMessageSettings");

---@param self DiscordWebhook
---@param targetMessageId string
---@param messageSettings string|MessageSettings
---@param isSynchronously boolean|nil
---@return boolean|MessageResult [1] If `isSynchronously` enabled, this will return MessageResult
local function edit(self, targetMessageId, messageSettings, isSynchronously)
  local requestConfigs = solveMessageSettings(self, messageSettings,
    self.url .. "/messages/" .. targetMessageId
  );

  local requestSuccessed = http.request({
    url = requestConfigs[1],
    body = requestConfigs[2],
    headers = { ["Content-Type"] = "application/json" },
    method = "PATCH"
  });

  if not requestSuccessed then
    return false;
  end
  if isSynchronously then
    return solveResult();
  else
    return requestSuccessed;
  end
end
return edit;
