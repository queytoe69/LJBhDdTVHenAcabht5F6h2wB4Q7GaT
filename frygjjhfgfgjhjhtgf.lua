local SCRIPTNAME = "Image Previewing Window"

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
WindUI:SetNotificationLower(true)

local DefaultBackgroundImageTransparency = 0.6

local Window = WindUI:CreateWindow({
    Title = "Image Previewing Window",
    Icon = "door-open",
    Author = "breezyjazzy9",
    Folder = SCRIPTNAME,
    Size = UDim2.fromOffset(580, 460),
    Transparent = false,
    Theme = "Dark",
    SideBarWidth = 150,
    Background = "rbxassetid://12079114459", -- rbxassetid only
    BackgroundImageTransparency = DefaultBackgroundImageTransparency,
    HideSearchBar = false,
    ScrollBarEnabled = true,
    User = {
        Enabled = false,
        Anonymous = false,
    },
})

local Tab = Window:Tab({
    Title = "Options",
    Icon = "circle-ellipsis",
    Locked = false,
})

local Backgrounds = {["None"] = 0, ["Shinto Cherry Blossom"] = 12079114459, ["Pixel Night Sky"] = 1078423085, ["Mountain Valleys"] = 719528392, ["Japanese Maple"] = 559952576, ["Pink Sky"] = 3624585765, ["Vibrant Sunset"] = 76376895, ["Winter Landscape"] = 959779451, ["Pine Forest"] = 18220445082, ["Gun Metal"] = 1590498564, ["Light Blue Clouds"] = 1291494234, ["Hawaiian Sunset"] = 1155183436, ["Fantasy World"] = 7224215094, ["Anime Sky"] = 4881317910, ["Electric Blue"] = 1508708931, ["Summer Lights"] = 3339522315, ["Space Stars"] = 2379791008, ["Marble Counter"] = 4062337094, ["City Skylines"] = 298555708, ["Green Polygons"] = 2588834657, ["Abstract Blue"] = 469656079, ["New Year Red"] = 339807971, ["Gray Clouds"] = 17450340679, ["Purple Galaxy"] = 873833331, ["Photoshoot Bridge"] = 260196528, ["Anime City"] = 6453315707, ["Abstract Forest"] = 932321170, ["Anime Porch"] = 6453316884, ["Mountainous Sunset"] = 440031769, ["Winter Forest"] = 199051682, ["Snow Mountains"] = 417121410, ["Cartoon River"] = 1196587477, ["Sunny Mountain"] = 3137318001, ["Arctic Night Sky"] = 417121130, ["Mysterious Place"] = 417121563, ["Sunset Drawing"] = 8453225818, ["Anime Scenery"] = 1098069078, ["Mount Fuji"] = 17731290311, ["Shinto Dojo"] = 13989496498, ["Cherry Blossom Town"] = 82745992498390}
local UIElements = {}

UIElements.WindowTransparencyToggle = Tab:Toggle({
    Title = "Window Transparency";
    Desc = "Toggles the transparency of the window.";
    Type = "Checkbox";
    Default = false;
    Callback = function(state)
        Window:ToggleTransparency(state)
    end
})

UIElements.BackgroundImageDropdown = Tab:Dropdown({
    Title = "Background Image";
    Values = {"None", "Shinto Cherry Blossom", "Pixel Night Sky", "Mountain Valleys", "Japanese Maple", "Pink Sky", "Vibrant Sunset", "Winter Landscape", "Pine Forest", "Gun Metal", "Light Blue Clouds", "Hawaiian Sunset", "Fantasy World", "Anime Sky", "Electric Blue", "Summer Lights", "Space Stars", "Marble Counter", "City Skylines", "Green Polygons", "Abstract Blue", "New Year Red", "Gray Clouds", "Purple Galaxy", "Photoshoot Bridge", "Anime City", "Abstract Forest", "Anime Porch", "Mountainous Sunset", "Winter Forest", "Snow Mountains", "Cartoon River", "Sunny Mountain", "Arctic Night Sky", "Mysterious Place", "Sunset Drawing", "Anime Scenery", "Mount Fuji", "Shinto Dojo", "Cherry Blossom Town"};
    Value = "Shinto Cherry Blossom";
    Callback = function(option)
        Window:SetBackgroundImage("rbxassetid://"..tostring(Backgrounds[option]))
    end
})

UIElements.BackgroundImageInput = Tab:Input({
    Title = "Custom Background Image";
    Desc = "Input the id of any image on the roblox marketplace that you want as the background.";
    Value = "";
    Type = "Input";
    Placeholder = "Enter a number..";
    Callback = function(input)
        if input and input ~= "" then
            Window:SetBackgroundImage("rbxassetid://"..tostring(input))
        end
    end
})

UIElements.BackgroundImageTransparencySlider = Tab:Slider({
    Title = "Background Image Transparency";
    Step = 0.01;
    Value = {
        Min = 0;
        Max = 1;
        Default = DefaultBackgroundImageTransparency;
    };
    Callback = function(value)
        Window:SetBackgroundImageTransparency(tonumber(value))
    end
})
