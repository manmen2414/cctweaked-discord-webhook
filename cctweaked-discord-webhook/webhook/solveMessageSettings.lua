local replace = require("cctweaked-discord-webhook.util").replace;

---@param settings MessageSettings
---@param self DiscordWebhook
local function settingsToPayload(self, settings)
  local payload = {
    query = "",
    content = settings.content,
    username = self.username,
    avatar_url = self.avatarUrl,
  };
  local queryPrefix = "?"
  if settings.username then
    payload.username = settings.username;
  end
  if settings.avaterUrl then
    payload.avatar_url = settings.avaterUrl;
  end
  if settings.threadName then
    payload.thread_name = settings.threadName;
  end
  if settings.appliedTags then
    payload.applied_tags = settings.appliedTags;
  end
  if settings.threadId then
    payload.query = payload.query .. queryPrefix .. "thread_id=" .. settings.threadId;
    queryPrefix = "&";
  end
  if settings.getSentMessage then
    payload.query = payload.query .. queryPrefix .. "wait=true";
    queryPrefix = "&";
  end
  return payload;
end


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

  if (type(messageSettings) ~= "string") and messageSettings.charUseAltOfBackslash then
    local REPLACEAT = "__CCTWEAKED_DISCORD_WEBHOOK_ALT__";
    body = replace(body, string.rep(messageSettings.charUseAltOfBackslash, 2), REPLACEAT);
    body = replace(body, messageSettings.charUseAltOfBackslash, "\\");
    body = replace(body, REPLACEAT, messageSettings.charUseAltOfBackslash);
  end

  return {
    url .. payload.query,
    body
  }
end
return solveMessageSettings, settingsToPayload;
