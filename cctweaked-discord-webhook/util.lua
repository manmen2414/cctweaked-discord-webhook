return {
  checkHTTP = function()
    if (not http) then return false end;
    return true;
  end,
  ---@param str string
  ---@param target string
  ---@param replacement string
  ---@param count number|nil
  ---@return unknown
  replace = function(str, target, replacement, count)
    local escapedTarget = target:gsub("[%(%)%.%%%+%-%*%?%[%^%$]", "%%%1")
    local escapedReplacement = replacement:gsub("%%", "%%%%")
    local result = str:gsub(escapedTarget, escapedReplacement, count)
    return result
  end

}
