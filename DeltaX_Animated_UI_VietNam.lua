--========================================================--
-- DELTA X // GIAO DIỆN ANIMATED
-- UI ONLY - GIAO DIỆN MẪU
--========================================================--

local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Xóa giao diện cũ
pcall(function()
    local old = PlayerGui:FindFirstChild("DeltaXAnimatedUI")
    if old then old:Destroy() end
end)

--========================================================--
-- CẤU HÌNH
--========================================================--

local CONFIG = {
    TieuDe = "DELTA X",
    PhuDe = "GIAO DIỆN HOẠT HÌNH",

    KichThuoc = Vector2.new(620, 390),
    KichThuocMobile = Vector2.new(350, 440),

    MauChinh = Color3.fromRGB(165, 85, 255),
    MauPhu = Color3.fromRGB(90, 180, 255),

    Nen = Color3.fromRGB(13, 14, 20),
    Bang = Color3.fromRGB(19, 20, 29),
    BangPhu = Color3.fromRGB(24, 25, 36),

    Chu = Color3.fromRGB(240, 240, 248),
    ChuPhu = Color3.fromRGB(145, 148, 165),

    TocDoHoatAnh = 0.28
}

--========================================================--
-- HÀM HỖ TRỢ
--========================================================--

local function Tween(object, info, properties)
    local tween = TweenService:Create(object, info, properties)
    tween:Play()
    return tween
end

local Nhanh = TweenInfo.new(
    CONFIG.TocDoHoatAnh,
    Enum.EasingStyle.Quart,
    Enum.EasingDirection.Out
)

local Muot = TweenInfo.new(
    0.45,
    Enum.EasingStyle.Quint,
    Enum.EasingDirection.Out
)

local function TaoGoc(object, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = object
    return corner
end

local function TaoVien(object, color, thickness, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = thickness or 1
    stroke.Transparency = transparency or 0
    stroke.Parent = object
    return stroke
end

local function TaoKhoang(object, amount)
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, amount)
    padding.PaddingRight = UDim.new(0, amount)
    padding.PaddingTop = UDim.new(0, amount)
    padding.PaddingBottom = UDim.new(0, amount)
    padding.Parent = object
    return padding
end

--========================================================--
-- GUI GỐC
--========================================================--

local Gui = Instance.new("ScreenGui")
Gui.Name = "DeltaXAnimatedUI"
Gui.IgnoreGuiInset = true
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = PlayerGui

--========================================================--
-- HẠT NỀN
--========================================================--

local LopHat = Instance.new("Frame")
LopHat.Name = "HatNen"
LopHat.Size = UDim2.fromScale(1, 1)
LopHat.BackgroundTransparency = 1
LopHat.Parent = Gui

local DanhSachHat = {}

for i = 1, 22 do
    local hat = Instance.new("Frame")

    hat.Size = UDim2.fromOffset(
        math.random(2, 5),
        math.random(2, 5)
    )

    hat.Position = UDim2.fromScale(
        math.random(),
        math.random()
    )

    hat.BackgroundColor3 =
        (i % 2 == 0)
        and CONFIG.MauChinh
        or CONFIG.MauPhu

    hat.BackgroundTransparency = math.random(55, 85) / 100
    hat.BorderSizePixel = 0
    hat.Parent = LopHat

    TaoGoc(hat, 20)

    table.insert(DanhSachHat, {
        doiTuong = hat,
        tocDo = math.random(8, 20) / 1000
    })
end

task.spawn(function()
    while Gui.Parent do
        for _, duLieu in ipairs(DanhSachHat) do
            local hat = duLieu.doiTuong
            local viTri = hat.Position
            local y = viTri.Y.Scale - duLieu.tocDo

            if y < -0.05 then
                y = 1.05
                hat.Position = UDim2.fromScale(math.random(), y)
            else
                hat.Position = UDim2.fromScale(
                    viTri.X.Scale,
                    y
                )
            end
        end

        task.wait(0.03)
    end
end)

--========================================================--
-- CỬA SỔ CHÍNH
--========================================================--

local KhungChinh = Instance.new("Frame")
KhungChinh.Name = "KhungChinh"
KhungChinh.AnchorPoint = Vector2.new(0.5, 0.5)
KhungChinh.Position = UDim2.fromScale(0.5, 0.53)
KhungChinh.Size = UDim2.fromOffset(10, 10)
KhungChinh.BackgroundColor3 = CONFIG.Nen
KhungChinh.BackgroundTransparency = 0.04
KhungChinh.BorderSizePixel = 0
KhungChinh.ClipsDescendants = true
KhungChinh.Parent = Gui

TaoGoc(KhungChinh, 18)

local VienChinh = TaoVien(
    KhungChinh,
    CONFIG.MauChinh,
    1.4,
    0.35
)

local TyLe = Instance.new("UIScale")
TyLe.Scale = 0.82
TyLe.Parent = KhungChinh

Tween(
    TyLe,
    TweenInfo.new(
        0.55,
        Enum.EasingStyle.Back,
        Enum.EasingDirection.Out
    ),
    {Scale = 1}
)

Tween(
    KhungChinh,
    TweenInfo.new(
        0.55,
        Enum.EasingStyle.Back,
        Enum.EasingDirection.Out
    ),
    {
        Size = UDim2.fromOffset(
            CONFIG.KichThuoc.X,
            CONFIG.KichThuoc.Y
        )
    }
)

--========================================================--
-- THANH SÁNG
--========================================================--

local ThanhSang = Instance.new("Frame")
ThanhSang.Name = "ThanhSang"
ThanhSang.Size = UDim2.new(1, 0, 0, 4)
ThanhSang.BackgroundColor3 = CONFIG.MauChinh
ThanhSang.BackgroundTransparency = 0.15
ThanhSang.BorderSizePixel = 0
ThanhSang.Parent = KhungChinh

local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, CONFIG.MauChinh),
    ColorSequenceKeypoint.new(0.5, CONFIG.MauPhu),
    ColorSequenceKeypoint.new(1, CONFIG.MauChinh)
})
Gradient.Parent = ThanhSang

--========================================================--
-- TIÊU ĐỀ
--========================================================--

local DauTrang = Instance.new("Frame")
DauTrang.Size = UDim2.new(1, 0, 0, 72)
DauTrang.BackgroundTransparency = 1
DauTrang.Parent = KhungChinh

local LinhVat = Instance.new("Frame")
LinhVat.Position = UDim2.fromOffset(16, 14)
LinhVat.Size = UDim2.fromOffset(44, 44)
LinhVat.BackgroundColor3 = CONFIG.BangPhu
LinhVat.BorderSizePixel = 0
LinhVat.Parent = DauTrang

TaoGoc(LinhVat, 14)
TaoVien(LinhVat, CONFIG.MauChinh, 1, 0.35)

-- Linh vật hoạt hình dạng biểu tượng, không dùng ảnh ngoài.
local Mat = Instance.new("TextLabel")
Mat.BackgroundTransparency = 1
Mat.Size = UDim2.fromScale(1, 1)
Mat.Font = Enum.Font.GothamBold
Mat.Text = "🐱"
Mat.TextSize = 25
Mat.Parent = LinhVat

local TieuDe = Instance.new("TextLabel")
TieuDe.Position = UDim2.fromOffset(72, 13)
TieuDe.Size = UDim2.new(1, -150, 0, 26)
TieuDe.BackgroundTransparency = 1
TieuDe.Font = Enum.Font.GothamBlack
TieuDe.Text = CONFIG.TieuDe
TieuDe.TextSize = 20
TieuDe.TextColor3 = CONFIG.Chu
TieuDe.TextXAlignment = Enum.TextXAlignment.Left
TieuDe.Parent = DauTrang

local PhuDe = Instance.new("TextLabel")
PhuDe.Position = UDim2.fromOffset(73, 39)
PhuDe.Size = UDim2.new(1, -150, 0, 18)
PhuDe.BackgroundTransparency = 1
PhuDe.Font = Enum.Font.GothamMedium
PhuDe.Text = CONFIG.PhuDe
PhuDe.TextSize = 9
PhuDe.TextColor3 = CONFIG.ChuPhu
PhuDe.TextXAlignment = Enum.TextXAlignment.Left
PhuDe.Parent = DauTrang

--========================================================--
-- NÚT ĐÓNG
--========================================================--

local NutDong = Instance.new("TextButton")
NutDong.AnchorPoint = Vector2.new(1, 0)
NutDong.Position = UDim2.new(1, -14, 0, 14)
NutDong.Size = UDim2.fromOffset(32, 32)
NutDong.BackgroundColor3 = CONFIG.BangPhu
NutDong.Text = "×"
NutDong.TextSize = 20
NutDong.Font = Enum.Font.GothamBold
NutDong.TextColor3 = CONFIG.ChuPhu
NutDong.AutoButtonColor = false
NutDong.Parent = DauTrang

TaoGoc(NutDong, 10)

NutDong.MouseEnter:Connect(function()
    Tween(NutDong, Nhanh, {
        BackgroundColor3 = Color3.fromRGB(180, 65, 95),
        TextColor3 = Color3.fromRGB(255, 255, 255)
    })
end)

NutDong.MouseLeave:Connect(function()
    Tween(NutDong, Nhanh, {
        BackgroundColor3 = CONFIG.BangPhu,
        TextColor3 = CONFIG.ChuPhu
    })
end)

--========================================================--
-- NỘI DUNG
--========================================================--

local NoiDung = Instance.new("Frame")
NoiDung.Position = UDim2.fromOffset(12, 72)
NoiDung.Size = UDim2.new(1, -24, 1, -84)
NoiDung.BackgroundTransparency = 1
NoiDung.Parent = KhungChinh

--========================================================--
-- THANH BÊN
--========================================================--

local ThanhBen = Instance.new("Frame")
ThanhBen.Size = UDim2.new(0, 135, 1, 0)
ThanhBen.BackgroundColor3 = CONFIG.Bang
ThanhBen.BorderSizePixel = 0
ThanhBen.Parent = NoiDung

TaoGoc(ThanhBen, 14)

--========================================================--
-- VÙNG TRANG
--========================================================--

local VungTrang = Instance.new("Frame")
VungTrang.Position = UDim2.fromOffset(147, 0)
VungTrang.Size = UDim2.new(1, -147, 1, 0)
VungTrang.BackgroundTransparency = 1
VungTrang.ClipsDescendants = true
VungTrang.Parent = NoiDung

--========================================================--
-- HỆ THỐNG TAB
--========================================================--

local CacTrang = {}
local CacNut = {}
local TabHienTai = nil

local function TaoTrang(ten)
    local trang = Instance.new("ScrollingFrame")
    trang.Name = ten
    trang.Size = UDim2.fromScale(1, 1)
    trang.BackgroundTransparency = 1
    trang.BorderSizePixel = 0
    trang.ScrollBarThickness = 2
    trang.ScrollBarImageColor3 = CONFIG.MauChinh
    trang.CanvasSize = UDim2.new(0, 0, 0, 0)
    trang.Visible = false
    trang.Parent = VungTrang

    local boCuc = Instance.new("UIListLayout")
    boCuc.Padding = UDim.new(0, 8)
    boCuc.SortOrder = Enum.SortOrder.LayoutOrder
    boCuc.Parent = trang

    TaoKhoang(trang, 4)

    boCuc:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        trang.CanvasSize = UDim2.fromOffset(
            0,
            boCuc.AbsoluteContentSize.Y + 12
        )
    end)

    CacTrang[ten] = trang
    return trang
end

local function TaoTab(ten, bieuTuong)

    local nut = Instance.new("TextButton")
    nut.Size = UDim2.new(1, -16, 0, 40)
    nut.Position = UDim2.fromOffset(8, 0)
    nut.BackgroundColor3 = CONFIG.BangPhu
    nut.BackgroundTransparency = 1
    nut.BorderSizePixel = 0
    nut.AutoButtonColor = false
    nut.Text = ""
    nut.Parent = ThanhBen

    TaoGoc(nut, 11)

    local icon = Instance.new("TextLabel")
    icon.Position = UDim2.fromOffset(11, 0)
    icon.Size = UDim2.fromOffset(24, 40)
    icon.BackgroundTransparency = 1
    icon.Text = bieuTuong
    icon.TextSize = 17
    icon.Parent = nut

    local nhan = Instance.new("TextLabel")
    nhan.Position = UDim2.fromOffset(40, 0)
    nhan.Size = UDim2.new(1, -48, 1, 0)
    nhan.BackgroundTransparency = 1
    nhan.Text = ten
    nhan.Font = Enum.Font.GothamBold
    nhan.TextSize = 10
    nhan.TextColor3 = CONFIG.ChuPhu
    nhan.TextXAlignment = Enum.TextXAlignment.Left
    nhan.Parent = nut

    table.insert(CacNut, nut)

    local trang = TaoTrang(ten)

    nut.MouseEnter:Connect(function()
        if TabHienTai ~= ten then
            Tween(nut, Nhanh, {
                BackgroundTransparency = 0.45
            })
            Tween(nhan, Nhanh, {
                TextColor3 = CONFIG.Chu
            })
        end
    end)

    nut.MouseLeave:Connect(function()
        if TabHienTai ~= ten then
            Tween(nut, Nhanh, {
                BackgroundTransparency = 1
            })
            Tween(nhan, Nhanh, {
                TextColor3 = CONFIG.ChuPhu
            })
        end
    end)

    nut.MouseButton1Click:Connect(function()

        if TabHienTai == ten then
            return
        end

        for _, page in pairs(CacTrang) do
            page.Visible = false
        end

        for _, other in ipairs(CacNut) do
            Tween(other, Nhanh, {
                BackgroundTransparency = 1
            })
        end

        trang.Visible = true
        nut.BackgroundTransparency = 0
        nut.BackgroundColor3 = CONFIG.MauChinh
        TabHienTai = ten

        trang.Position = UDim2.fromOffset(20, 0)

        Tween(
            trang,
            TweenInfo.new(
                0.28,
                Enum.EasingStyle.Quart,
                Enum.EasingDirection.Out
            ),
            {
                Position = UDim2.fromOffset(0, 0)
            }
        )
    end)

    return trang
end

--========================================================--
-- CÁC TAB
--========================================================--

local Combat = TaoTab("Chiến đấu", "⚔")
local HienThi = TaoTab("Hiển thị", "◉")
local NguoiChoi = TaoTab("Người chơi", "◆")
local CaiDat = TaoTab("Cài đặt", "⚙")

--========================================================--
-- THÀNH PHẦN GIAO DIỆN
--========================================================--

local function TaoTieuMuc(parent, text)

    local muc = Instance.new("TextLabel")
    muc.Size = UDim2.new(1, -8, 0, 25)
    muc.BackgroundTransparency = 1
    muc.Font = Enum.Font.GothamBlack
    muc.Text = text
    muc.TextSize = 12
    muc.TextColor3 = CONFIG.Chu
    muc.TextXAlignment = Enum.TextXAlignment.Left
    muc.Parent = parent

    return muc
end

local function TaoCongTac(parent, text, callback)

    local nut = Instance.new("TextButton")
    nut.Size = UDim2.new(1, -8, 0, 48)
    nut.BackgroundColor3 = CONFIG.Bang
    nut.BorderSizePixel = 0
    nut.AutoButtonColor = false
    nut.Text = ""
    nut.Parent = parent

    TaoGoc(nut, 12)

    local nhan = Instance.new("TextLabel")
    nhan.Position = UDim2.fromOffset(14, 0)
    nhan.Size = UDim2.new(1, -75, 1, 0)
    nhan.BackgroundTransparency = 1
    nhan.Font = Enum.Font.GothamMedium
    nhan.Text = text
    nhan.TextSize = 10
    nhan.TextColor3 = CONFIG.Chu
    nhan.TextXAlignment = Enum.TextXAlignment.Left
    nhan.Parent = nut

    local congTac = Instance.new("Frame")
    congTac.AnchorPoint = Vector2.new(1, 0.5)
    congTac.Position = UDim2.new(1, -13, 0.5, 0)
    congTac.Size = UDim2.fromOffset(42, 22)
    congTac.BackgroundColor3 = Color3.fromRGB(43, 44, 55)
    congTac.BorderSizePixel = 0
    congTac.Parent = nut

    TaoGoc(congTac, 20)

    local cham = Instance.new("Frame")
    cham.Size = UDim2.fromOffset(16, 16)
    cham.Position = UDim2.fromOffset(3, 3)
    cham.BackgroundColor3 = CONFIG.ChuPhu
    cham.BorderSizePixel = 0
    cham.Parent = congTac

    TaoGoc(cham, 20)

    local bat = false

    local function CapNhat()

        if bat then
            Tween(congTac, Nhanh, {
                BackgroundColor3 = CONFIG.MauChinh
            })

            Tween(cham, Nhanh, {
                Position = UDim2.new(1, -19, 0, 3),
                BackgroundColor3 = Color3.new(1, 1, 1)
            })
        else
            Tween(congTac, Nhanh, {
                BackgroundColor3 = Color3.fromRGB(43, 44, 55)
            })

            Tween(cham, Nhanh, {
                Position = UDim2.fromOffset(3, 3),
                BackgroundColor3 = CONFIG.ChuPhu
            })
        end
    end

    nut.MouseEnter:Connect(function()
        Tween(nut, Nhanh, {
            BackgroundColor3 = CONFIG.BangPhu
        })
    end)

    nut.MouseLeave:Connect(function()
        Tween(nut, Nhanh, {
            BackgroundColor3 = CONFIG.Bang
        })
    end)

    nut.MouseButton1Click:Connect(function()

        bat = not bat
        CapNhat()

        if callback then
            callback(bat)
        end
    end)

    return nut
end

local function TaoNut(parent, text, callback)

    local nut = Instance.new("TextButton")
    nut.Size = UDim2.new(1, -8, 0, 44)
    nut.BackgroundColor3 = CONFIG.Bang
    nut.BorderSizePixel = 0
    nut.AutoButtonColor = false
    nut.Text = text
    nut.Font = Enum.Font.GothamBold
    nut.TextSize = 10
    nut.TextColor3 = CONFIG.Chu
    nut.Parent = parent

    TaoGoc(nut, 11)

    nut.MouseEnter:Connect(function()
        Tween(nut, Nhanh, {
            BackgroundColor3 = CONFIG.MauChinh
        })
    end)

    nut.MouseLeave:Connect(function()
        Tween(nut, Nhanh, {
            BackgroundColor3 = CONFIG.Bang
        })
    end)

    nut.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)

    return nut
end

--========================================================--
-- NỘI DUNG MẪU
--========================================================--

TaoTieuMuc(Combat, "CHIẾN ĐẤU")

TaoCongTac(Combat, "Hỗ trợ mục tiêu", function(bat)
    print("Hỗ trợ mục tiêu:", bat)
end)

TaoCongTac(Combat, "Hiển thị vòng FOV", function(bat)
    print("FOV:", bat)
end)

TaoCongTac(Combat, "Kiểm tra đồng đội", function(bat)
    print("Kiểm tra đồng đội:", bat)
end)

TaoTieuMuc(HienThi, "HIỂN THỊ")

TaoCongTac(HienThi, "Đánh dấu người chơi", function(bat)
    print("Đánh dấu:", bat)
end)

TaoCongTac(HienThi, "Khoảng cách", function(bat)
    print("Khoảng cách:", bat)
end)

TaoCongTac(HienThi, "Thanh máu", function(bat)
    print("Thanh máu:", bat)
end)

TaoTieuMuc(NguoiChoi, "NGƯỜI CHƠI")

TaoNut(NguoiChoi, "Đưa giao diện về giữa màn hình", function()
    Tween(
        KhungChinh,
        Muot,
        {
            Position = UDim2.fromScale(0.5, 0.53)
        }
    )
end)

TaoNut(NguoiChoi, "Tải lại giao diện", function()
    print("Đã yêu cầu tải lại giao diện")
end)

TaoTieuMuc(CaiDat, "GIAO DIỆN")

TaoCongTac(CaiDat, "Hạt nền", function(bat)
    LopHat.Visible = bat
end)

TaoCongTac(CaiDat, "Viền phát sáng", function(bat)
    VienChinh.Transparency = bat and 0.25 or 1
end)

--========================================================--
-- TAB MẶC ĐỊNH
--========================================================--

task.defer(function()
    for _, page in pairs(CacTrang) do
        page.Visible = false
    end

    if CacNut[1] then
        CacNut[1]:Activate()
    end
end)

--========================================================--
-- KÉO GIAO DIỆN
--========================================================--

local DangKeo = false
local ViTriBatDau
local ViTriKhung

DauTrang.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        DangKeo = true
        ViTriBatDau = input.Position
        ViTriKhung = KhungChinh.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)

    if not DangKeo then
        return
    end

    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then

        local delta = input.Position - ViTriBatDau

        KhungChinh.Position = UDim2.new(
            ViTriKhung.X.Scale,
            ViTriKhung.X.Offset + delta.X,
            ViTriKhung.Y.Scale,
            ViTriKhung.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        DangKeo = false
    end
end)

--========================================================--
-- HOẠT ẢNH LINH VẬT
--========================================================--

task.spawn(function()

    local thoiGian = 0

    while Gui.Parent do

        thoiGian += 0.04

        LinhVat.Rotation = math.sin(thoiGian) * 3

        LinhVat.Position = UDim2.fromOffset(
            16,
            14 + math.sin(thoiGian * 1.4) * 2
        )

        task.wait()
    end
end)

--========================================================--
-- RESPONSIVE MOBILE
--========================================================--

local function CapNhatMobile()

    local camera = workspace.CurrentCamera

    if not camera then
        return
    end

    local viewport = camera.ViewportSize

    if viewport.X < 600 then

        KhungChinh.Size = UDim2.fromOffset(
            CONFIG.KichThuocMobile.X,
            CONFIG.KichThuocMobile.Y
        )

        ThanhBen.Size = UDim2.new(
            0,
            88,
            1,
            0
        )

        VungTrang.Position =
            UDim2.fromOffset(98, 0)

        VungTrang.Size =
            UDim2.new(1, -98, 1, 0)

    else

        KhungChinh.Size = UDim2.fromOffset(
            CONFIG.KichThuoc.X,
            CONFIG.KichThuoc.Y
        )

        ThanhBen.Size =
            UDim2.new(0, 135, 1, 0)

        VungTrang.Position =
            UDim2.fromOffset(147, 0)

        VungTrang.Size =
            UDim2.new(1, -147, 1, 0)
    end
end

workspace.CurrentCamera:GetPropertyChangedSignal(
    "ViewportSize"
):Connect(CapNhatMobile)

CapNhatMobile()

--========================================================--
-- KẾT THÚC
--========================================================--

print("[DELTA X] Đã tải giao diện tiếng Việt.")
