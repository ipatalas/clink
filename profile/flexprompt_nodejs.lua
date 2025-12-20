--------------------------------------------------------------------------------
-- NODEJS MODULE:  {nodejs:color=color_name,alt_color_name}
--  - color_name is a name like "green", or an sgr code like "38;5;60".
--  - alt_color_name is optional; it is the text color in rainbow style.
--
-- Shows the current Node.js version when inside a Node.js project (when
-- package.json is found in the current directory or a parent directory).
local nodejs = {}

-- Helper function to find package.json
local function get_package_json_dir(dir)
    return flexprompt.scan_upwards(dir, function(dir)  -- luacheck: ignore 432
        local package_file = path.join(dir, "package.json")
        if os.isfile(package_file) then
            return dir
        end
    end)
end

-- Collects Node.js version info.
-- Uses async coroutine calls.
local function collect_nodejs_info()
    local pipe = flexprompt.popenyield("node --version 2>nul")
    if not pipe then
        return { version = nil, error = true }
    end

    local version = pipe:read("*l")
    pipe:close()

    if version then
        -- Strip the leading 'v' if present (e.g., "v18.16.0" -> "18.16.0")
        version = version:match("^v?(.+)$")
    end

    return { version = version, error = not version }
end

local function render_nodejs(args)
    -- Check if we're in a Node.js project
    local nodejs_dir = get_package_json_dir()
    if not nodejs_dir then
        return
    end

    -- Collect or retrieve cached info
    local info, refreshing = flexprompt.prompt_info(nodejs, nodejs_dir, nil, collect_nodejs_info)

    if not info.version or info.error then
        return
    end

    -- Parse color arguments
    local colors = flexprompt.parse_arg_token(args, "c", "color")
    local color, altcolor
    local style = flexprompt.get_style()

    if style == "rainbow" then
        color = flexprompt.use_best_color("green", "38;5;40")
        altcolor = "realblack"
    elseif style == "classic" then
        color = flexprompt.use_best_color("green", "38;5;40")
    else
        color = flexprompt.use_best_color("green", "38;5;76")
    end

    color, altcolor = flexprompt.parse_colors(colors, color, altcolor)

    -- Build the text with version
    local text = "v" .. info.version

    -- Add symbol if available
    local symbol = flexprompt.get_module_symbol(refreshing)
    if symbol and symbol ~= "" then
        text = flexprompt.append_text(symbol, text)
    end

    return text, color, altcolor
end

-- Register the module with flexprompt
flexprompt.add_module("nodejs", render_nodejs, {
    nerdfonts2 = { "", " " },
    nerdfonts3 = { "", " " }
})