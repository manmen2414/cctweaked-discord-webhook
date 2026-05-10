local settingsToPayload = require("cctweaked-discord-webhook.webhook.settingsToPayload");

---@param self DiscordWebhook
---@param messageSettings string|MessageSettings
---@param url string
local function solveMessageSettings(self, messageSettings, url)
  local payload = {
    query = "",
    username = self.username,
    avatar_url = self.avatarUrl,
  };
  if (type(messageSettings) == "string") then
    payload.content = messageSettings
  else
    payload = settingsToPayload(self, messageSettings);
  end

  local body = textutils.serialiseJSON(payload);

  if (type(messageSettings) ~= "string") and messageSettings.noEscapeBackslash then
    body = string.gsub(body, "__CCTWEAKED_DISCORD_WEBHOOK_CONTENT__", messageSettings.content, 1)
  end

  return {
    url .. payload.query,
    body
  }
end
return solveMessageSettings;
