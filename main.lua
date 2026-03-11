-- Xanoxxl Status Notification
-- Auth: Gigs & Xyren Lab

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Xanoxxl_Notification"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- [1] TEXT LABEL (CENTERED)
local StatusLabel = Instance.new("TextLabel", ScreenGui)
StatusLabel.Size = UDim2.new(1, 0, 0, 50)
StatusLabel.Position = UDim2.new(0, 0, 0.45, 0) -- Pas di tengah mata
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Script In Reset, Pls Request New Script For Seller !"
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.TextSize = 25 -- Ukuran gede biar kebaca
StatusLabel.TextStrokeTransparency = 0.2 -- Biar ada bayangan hitam dikit biar jelas

-- [2] RAINBOW LOGIC
task.spawn(function()
    local hue = 0
    while task.wait(0.01) do
        -- Geser warna berdasarkan HSV
        StatusLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
        hue = (hue + 0.01) % 1
    end
end)

-- [3] OPTIONAL: AUTO DESTROY (Kalau mau ilang sendiri setelah berapa detik)
-- task.wait(10) -- Ganti angka ini buat durasi munculnya
-- ScreenGui:Destroy()
