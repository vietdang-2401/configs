local mcphub = require("mcphub")

mcphub.add_tool("neovim", {
  name = "read_filee",
  description = "Read contents of a file",
  inputSchema = {
    type = "object",
    properties = {
      path = {
        type = "string",
        description = "Path to the file to read",
      },
      start_line = {
        type = "number",
        description = "Start reading from this line (1-based)",
        default = 1,
      },
      end_line = {
        type = "number",
        description = "Read until this line (inclusive)",
        default = -1,
      },
    },
    required = { "path" },
  },
  handler = function(req, res)
    local params = req.params
    local p = Path:new(params.path)

    -- Validate file exists
    if not p:exists() then
      return res:error("File not found: " .. params.path)
    end

    -- Handle line range reading
    if params.start_line and params.end_line then
      local extracted = {}
      local current_line = 0

      for line in p:iter() do
        current_line = current_line + 1
        if current_line >= params.start_line and (params.end_line == -1 or current_line <= params.end_line) then
          table.insert(extracted, string.format("%4d │ %s", current_line, line))
        end
        if params.end_line ~= -1 and current_line > params.end_line then
          break
        end
      end
      return res:text(table.concat(extracted, "\n")):send()
    end

    -- Read entire file
    return res:text(p:read()):send()
  end,
})

mcphub.add_prompt("example", {
  name = "chat",
  description = "Start a friendly chat",

  -- Optional arguments
  arguments = {
    {
      name = "topic",
      description = "What to chat about",
      required = true,
    },
  },

  -- Prompt handler
  handler = function(req, res)
    return res
      -- Set behavior
      :system()
      :text("You are a friendly chat assistant.\n" .. "Topic: " .. req.params.topic)
      -- Add example interaction
      :user()
      :text("Tell me about " .. req.params.topic)
      :llm()
      :text("I'd love to discuss " .. req.params.topic)
      -- Send prompt
      :send()
  end,
})
