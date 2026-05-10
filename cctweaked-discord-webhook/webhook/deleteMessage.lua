---@param self DiscordWebhook
---@param targetMessageId string
---@param isSynchronously boolean|nil
---@return boolean
local function deleteMessage(self, targetMessageId, isSynchronously)
  local requestSuccessed = http.request({
    url = self.url .. "/messages/" .. targetMessageId,
    method = "DELETE"
  });

  if not requestSuccessed then
    return false;
  end
  return true;
  -- //TODO: Was message deleted?
end
return deleteMessage;
