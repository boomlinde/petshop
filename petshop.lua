maxundo = 20

lshift = false
rshift = false
shift = false

lctrl = false
rctrl = false
ctrl = false

fgcolor = 0xe
bgcolor = 0x6
bordercolor = 0xe
prompt = 'save: '
oldfilename = 'blank.pet'
filename = 'blank.pet'
message = nil
lowercase = false

flip_horizontal = {
	[0x00] = 0x00, [0x01] = 0x01, [0x02] = 0x02, [0x03] = 0x03,
	[0x04] = 0x04, [0x05] = 0x05, [0x06] = 0x06, [0x07] = 0x07,
	[0x08] = 0x08, [0x09] = 0x09, [0x0a] = 0x0a, [0x0b] = 0x0b,
	[0x0c] = 0x0c, [0x0d] = 0x0d, [0x0e] = 0x0e, [0x0f] = 0x0f,
	[0x10] = 0x10, [0x11] = 0x11, [0x12] = 0x12, [0x13] = 0x13,
	[0x14] = 0x14, [0x15] = 0x15, [0x16] = 0x16, [0x17] = 0x17,
	[0x18] = 0x18, [0x19] = 0x19, [0x1a] = 0x1a, [0x1b] = 0x1d,
	[0x1c] = 0x1c, [0x1d] = 0x1b, [0x1e] = 0x1e, [0x1f] = 0x1f,
	[0x20] = 0x20, [0x21] = 0x21, [0x22] = 0x22, [0x23] = 0x23,
	[0x24] = 0x24, [0x25] = 0x25, [0x26] = 0x26, [0x27] = 0x27,
	[0x28] = 0x29, [0x29] = 0x28, [0x2a] = 0x2a, [0x2b] = 0x2b,
	[0x2c] = 0x2c, [0x2d] = 0x2d, [0x2e] = 0x2e, [0x2f] = 0x2f,
	[0x30] = 0x30, [0x31] = 0x31, [0x32] = 0x32, [0x33] = 0x33,
	[0x34] = 0x34, [0x35] = 0x35, [0x36] = 0x36, [0x37] = 0x37,
	[0x38] = 0x38, [0x39] = 0x39, [0x3a] = 0x3a, [0x3b] = 0x3b,
	[0x3c] = 0x3e, [0x3d] = 0x3d, [0x3e] = 0x3c, [0x3f] = 0x3f,
	[0x40] = 0x43, [0x41] = 0x41, [0x42] = 0x5d, [0x43] = 0x43,
	[0x44] = 0x44, [0x45] = 0x45, [0x46] = 0x46, [0x47] = 0x48,
	[0x48] = 0x47, [0x49] = 0x55, [0x4a] = 0x4b, [0x4b] = 0x4a,
	[0x4c] = 0x7a, [0x4d] = 0x4e, [0x4e] = 0x4d, [0x4f] = 0x50,
	[0x50] = 0x4f, [0x51] = 0x51, [0x52] = 0x52, [0x53] = 0x53,
	[0x54] = 0x59, [0x55] = 0x49, [0x56] = 0x56, [0x57] = 0x57,
	[0x58] = 0x58, [0x59] = 0x54, [0x5a] = 0x5a, [0x5b] = 0x5b,
	[0x5c] = 0x5c, [0x5d] = 0x5d, [0x5e] = 0x5e, [0x5f] = 0x69,
	[0x60] = 0x60, [0x61] = 0xe1, [0x62] = 0x62, [0x63] = 0x63,
	[0x64] = 0x64, [0x65] = 0x6a, [0x66] = 0xe6, [0x67] = 0x74,
	[0x68] = 0x68, [0x69] = 0x5f, [0x6a] = 0x74, [0x6b] = 0x73,
	[0x6c] = 0x7b, [0x6d] = 0x7d, [0x6e] = 0x70, [0x6f] = 0x6f,
	[0x70] = 0x6e, [0x71] = 0x71, [0x72] = 0x72, [0x73] = 0x6b,
	[0x74] = 0x6a, [0x75] = 0x76, [0x76] = 0x75, [0x77] = 0x77,
	[0x78] = 0x78, [0x79] = 0x79, [0x7a] = 0x4c, [0x7b] = 0x6c,
	[0x7c] = 0x7e, [0x7d] = 0x6d, [0x7e] = 0x7c, [0x7f] = 0xff,
	[0x80] = 0x80, [0x81] = 0x81, [0x82] = 0x82, [0x83] = 0x83,
	[0x84] = 0x84, [0x85] = 0x85, [0x86] = 0x86, [0x87] = 0x87,
	[0x88] = 0x88, [0x89] = 0x89, [0x8a] = 0x8a, [0x8b] = 0x8b,
	[0x8c] = 0x8c, [0x8d] = 0x8d, [0x8e] = 0x8e, [0x8f] = 0x8f,
	[0x90] = 0x90, [0x91] = 0x91, [0x92] = 0x92, [0x93] = 0x93,
	[0x94] = 0x94, [0x95] = 0x95, [0x96] = 0x96, [0x97] = 0x97,
	[0x98] = 0x98, [0x99] = 0x99, [0x9a] = 0x9a, [0x9b] = 0x9d,
	[0x9c] = 0x9c, [0x9d] = 0x9b, [0x9e] = 0x9e, [0x9f] = 0x9f,
	[0xa0] = 0xe0, [0xa1] = 0xa1, [0xa2] = 0xa2, [0xa3] = 0xa3,
	[0xa4] = 0xa4, [0xa5] = 0xa5, [0xa6] = 0xa6, [0xa7] = 0xa7,
	[0xa8] = 0xa9, [0xa9] = 0xa8, [0xaa] = 0xaa, [0xab] = 0xab,
	[0xac] = 0xac, [0xad] = 0xad, [0xae] = 0xae, [0xaf] = 0xaf,
	[0xb0] = 0xb0, [0xb1] = 0xb1, [0xb2] = 0xb2, [0xb3] = 0xb3,
	[0xb4] = 0xb4, [0xb5] = 0xb5, [0xb6] = 0xb6, [0xb7] = 0xb7,
	[0xb8] = 0xb8, [0xb9] = 0xb9, [0xba] = 0xba, [0xbb] = 0xbb,
	[0xbc] = 0xbe, [0xbd] = 0xbd, [0xbe] = 0xbc, [0xbf] = 0xbf,
	[0xc0] = 0xc3, [0xc1] = 0xc1, [0xc2] = 0xdd, [0xc3] = 0xc3,
	[0xc4] = 0xc4, [0xc5] = 0xc5, [0xc6] = 0xc6, [0xc7] = 0xc8,
	[0xc8] = 0xc7, [0xc9] = 0xd5, [0xca] = 0xcb, [0xcb] = 0xca,
	[0xcc] = 0xfa, [0xcd] = 0xce, [0xce] = 0xcd, [0xcf] = 0xd0,
	[0xd0] = 0xcf, [0xd1] = 0xd1, [0xd2] = 0xd2, [0xd3] = 0xd3,
	[0xd4] = 0xd9, [0xd5] = 0xc9, [0xd6] = 0xd6, [0xd7] = 0xd7,
	[0xd8] = 0xd8, [0xd9] = 0xd4, [0xda] = 0xda, [0xdb] = 0xdb,
	[0xdc] = 0xdc, [0xdd] = 0xdd, [0xde] = 0xde, [0xdf] = 0xe9,
	[0xe0] = 0xe0, [0xe1] = 0x61, [0xe2] = 0xe2, [0xe3] = 0xe3,
	[0xe4] = 0xe4, [0xe5] = 0xea, [0xe6] = 0x66, [0xe7] = 0xf4,
	[0xe8] = 0xe8, [0xe9] = 0xdf, [0xea] = 0xf4, [0xeb] = 0xf3,
	[0xec] = 0xfb, [0xed] = 0xfd, [0xee] = 0xf0, [0xef] = 0xef,
	[0xf0] = 0xee, [0xf1] = 0xf1, [0xf2] = 0xf2, [0xf3] = 0xeb,
	[0xf4] = 0xea, [0xf5] = 0xf6, [0xf6] = 0xf5, [0xf7] = 0xf7,
	[0xf8] = 0xf8, [0xf9] = 0xf9, [0xfa] = 0xcc, [0xfb] = 0xec,
	[0xfc] = 0xfe, [0xfd] = 0xed, [0xfe] = 0xfc, [0xff] = 0x7f,
}

flip_vertical = {
	[0x00] = 0x00, [0x01] = 0x01, [0x02] = 0x02, [0x03] = 0x03,
	[0x04] = 0x04, [0x05] = 0x05, [0x06] = 0x06, [0x07] = 0x07,
	[0x08] = 0x08, [0x09] = 0x09, [0x0a] = 0x0a, [0x0b] = 0x0b,
	[0x0c] = 0x0c, [0x0d] = 0x0d, [0x0e] = 0x0e, [0x0f] = 0x0f,
	[0x10] = 0x10, [0x11] = 0x11, [0x12] = 0x12, [0x13] = 0x13,
	[0x14] = 0x14, [0x15] = 0x15, [0x16] = 0x16, [0x17] = 0x17,
	[0x18] = 0x18, [0x19] = 0x19, [0x1a] = 0x1a, [0x1b] = 0x1b,
	[0x1c] = 0x1c, [0x1d] = 0x1d, [0x1e] = 0x1e, [0x1f] = 0x1f,
	[0x20] = 0x20, [0x21] = 0x21, [0x22] = 0x22, [0x23] = 0x23,
	[0x24] = 0x24, [0x25] = 0x25, [0x26] = 0x26, [0x27] = 0x27,
	[0x28] = 0x28, [0x29] = 0x29, [0x2a] = 0x2a, [0x2b] = 0x2b,
	[0x2c] = 0x2c, [0x2d] = 0x2d, [0x2e] = 0x2e, [0x2f] = 0x2f,
	[0x30] = 0x30, [0x31] = 0x31, [0x32] = 0x32, [0x33] = 0x33,
	[0x34] = 0x34, [0x35] = 0x35, [0x36] = 0x36, [0x37] = 0x37,
	[0x38] = 0x38, [0x39] = 0x39, [0x3a] = 0x3a, [0x3b] = 0x3b,
	[0x3c] = 0x3c, [0x3d] = 0x3d, [0x3e] = 0x3e, [0x3f] = 0x3f,
	[0x40] = 0x43, [0x41] = 0x41, [0x42] = 0x5d, [0x43] = 0x43,
	[0x44] = 0x46, [0x45] = 0x52, [0x46] = 0x44, [0x47] = 0x47,
	[0x48] = 0x48, [0x49] = 0x4b, [0x4a] = 0x55, [0x4b] = 0x49,
	[0x4c] = 0x4f, [0x4d] = 0x4e, [0x4e] = 0x4d, [0x4f] = 0x4c,
	[0x50] = 0x7a, [0x51] = 0x51, [0x52] = 0x45, [0x53] = 0x53,
	[0x54] = 0x54, [0x55] = 0x4a, [0x56] = 0x56, [0x57] = 0x57,
	[0x58] = 0x58, [0x59] = 0x59, [0x5a] = 0x5a, [0x5b] = 0x5b,
	[0x5c] = 0x5c, [0x5d] = 0x5d, [0x5e] = 0x5e, [0x5f] = 0xe9,
	[0x60] = 0x60, [0x61] = 0x61, [0x62] = 0xe2, [0x63] = 0x64,
	[0x64] = 0x63, [0x65] = 0x74, [0x66] = 0xe6, [0x67] = 0x6a,
	[0x68] = 0x68, [0x69] = 0xdf, [0x6a] = 0x6a, [0x6b] = 0x6b,
	[0x6c] = 0x7c, [0x6d] = 0x70, [0x6e] = 0x7d, [0x6f] = 0x77,
	[0x70] = 0x6d, [0x71] = 0x72, [0x72] = 0x71, [0x73] = 0x73,
	[0x74] = 0x74, [0x75] = 0x75, [0x76] = 0x76, [0x77] = 0x6f,
	[0x78] = 0x79, [0x79] = 0x78, [0x7a] = 0x50, [0x7b] = 0x7e,
	[0x7c] = 0x6c, [0x7d] = 0x6e, [0x7e] = 0x7b, [0x7f] = 0xff,
	[0x80] = 0x80, [0x81] = 0x81, [0x82] = 0x82, [0x83] = 0x83,
	[0x84] = 0x84, [0x85] = 0x85, [0x86] = 0x86, [0x87] = 0x87,
	[0x88] = 0x88, [0x89] = 0x89, [0x8a] = 0x8a, [0x8b] = 0x8b,
	[0x8c] = 0x8c, [0x8d] = 0x8d, [0x8e] = 0x8e, [0x8f] = 0x8f,
	[0x90] = 0x90, [0x91] = 0x91, [0x92] = 0x92, [0x93] = 0x93,
	[0x94] = 0x94, [0x95] = 0x95, [0x96] = 0x96, [0x97] = 0x97,
	[0x98] = 0x98, [0x99] = 0x99, [0x9a] = 0x9a, [0x9b] = 0x9b,
	[0x9c] = 0x9c, [0x9d] = 0x9d, [0x9e] = 0x9e, [0x9f] = 0x9f,
	[0xa0] = 0xe0, [0xa1] = 0xa1, [0xa2] = 0xa2, [0xa3] = 0xa3,
	[0xa4] = 0xa4, [0xa5] = 0xa5, [0xa6] = 0xa6, [0xa7] = 0xa7,
	[0xa8] = 0xa8, [0xa9] = 0xa9, [0xaa] = 0xaa, [0xab] = 0xab,
	[0xac] = 0xac, [0xad] = 0xad, [0xae] = 0xae, [0xaf] = 0xaf,
	[0xb0] = 0xb0, [0xb1] = 0xb1, [0xb2] = 0xb2, [0xb3] = 0xb3,
	[0xb4] = 0xb4, [0xb5] = 0xb5, [0xb6] = 0xb6, [0xb7] = 0xb7,
	[0xb8] = 0xb8, [0xb9] = 0xb9, [0xba] = 0xba, [0xbb] = 0xbb,
	[0xbc] = 0xbc, [0xbd] = 0xbd, [0xbe] = 0xbe, [0xbf] = 0xbf,
	[0xc0] = 0xc3, [0xc1] = 0xc1, [0xc2] = 0xdd, [0xc3] = 0xc3,
	[0xc4] = 0xc6, [0xc5] = 0xd2, [0xc6] = 0xc4, [0xc7] = 0xc7,
	[0xc8] = 0xc8, [0xc9] = 0xcb, [0xca] = 0xd5, [0xcb] = 0xc9,
	[0xcc] = 0xcf, [0xcd] = 0xce, [0xce] = 0xcd, [0xcf] = 0xcc,
	[0xd0] = 0xfa, [0xd1] = 0xd1, [0xd2] = 0xc5, [0xd3] = 0xd3,
	[0xd4] = 0xd4, [0xd5] = 0xca, [0xd6] = 0xd6, [0xd7] = 0xd7,
	[0xd8] = 0xd8, [0xd9] = 0xd9, [0xda] = 0xda, [0xdb] = 0xdb,
	[0xdc] = 0xdc, [0xdd] = 0xdd, [0xde] = 0xde, [0xdf] = 0x69,
	[0xe0] = 0xe0, [0xe1] = 0xe1, [0xe2] = 0x62, [0xe3] = 0xe4,
	[0xe4] = 0xe3, [0xe5] = 0xf4, [0xe6] = 0x66, [0xe7] = 0xea,
	[0xe8] = 0xe8, [0xe9] = 0x5f, [0xea] = 0xea, [0xeb] = 0xeb,
	[0xec] = 0xfc, [0xed] = 0xf0, [0xee] = 0xfd, [0xef] = 0xf7,
	[0xf0] = 0xed, [0xf1] = 0xf2, [0xf2] = 0xf1, [0xf3] = 0xf3,
	[0xf4] = 0xf4, [0xf5] = 0xf5, [0xf6] = 0xf6, [0xf7] = 0xef,
	[0xf8] = 0xf9, [0xf9] = 0xf8, [0xfa] = 0xd0, [0xfb] = 0xfe,
	[0xfc] = 0xec, [0xfd] = 0xee, [0xfe] = 0xfb, [0xff] = 0x7f,
}

function ascii2scr(ascii)
	local scr = {}
	local b = string.byte
	for i = 1,#ascii do
		local byte = b(ascii, i)
		if byte >= b("a") and byte <= b("z") then
			table.insert(scr, byte - 96)
		elseif byte >= b("[") and byte <= b("_") then
			table.insert(scr, byte - 64)
		elseif byte == b("`") then
			table.insert(scr, 64)
		elseif byte == b("@") then
			table.insert(scr, 0)
		else
			table.insert(scr, byte)
		end
	end
	return scr
end
                                  
picture = { tip = 1, { chars = {} , colors = {}, }}
scratch = { tip = 1, { chars = {} , colors = {}, }}

for i = 0,999 do                  
	picture[1].chars[i] = 32
	picture[1].colors[i] = 14
	scratch[1].chars[i] = 32
	scratch[1].colors[i] = 14
end

-- local s = ascii2scr("hello there!")
-- for x = 1,#s do
-- 	picture[1].chars[x - 1] = s[x]
-- end

palettepic = { chars = {}, colors = {}, }
for y = 0,18 do
	for x = 0,17 do
		palettepic.chars[x + y * 40] = 0x20
	end
end
for x = 1,16 do
	palettepic.colors[x + 17 * 40] = x - 1
	palettepic.chars[x + 17 * 40] = 0xa0
end
function recolor_palette()
	for y = 1,16 do
		for x = 1,16 do
			palettepic.colors[x + y * 40] = fgcolor
		end
	end
end
recolor_palette()
for y = 0,15 do
	for x = 0,15 do
		palettepic.chars[x + 1 + (y + 1) * 40] = x + y * 16
	end
end

promptpic = { chars = {}, colors = {} }
function redraw_prompt()
	for x=0,39 do
		promptpic.chars[x + 24 * 40] = 0x20
		promptpic.colors[x + 24 * 40] = bgcolor + 11
	end
	local s = ascii2scr(prompt .. filename)
	for x=1,#s do
		promptpic.chars[(x-1) + 24 * 40] = s[x]
	end
	return #s, 24
end

function setbg(c) bgcolor = c % 16; ht.setbg(bgcolor) end
function setborder(c) bordercolor = c % 16; ht.setborder(bordercolor) end
function setcase(c) lowercase = c; ht.setlowercase(c) end


function drawpictures(pictures)
	for i = 1,#pictures do
		local picture = pictures[i]
		for y = 0,24 do
			for x = 0,39 do
				local char = picture.chars[x + y * 40]
				local color = picture.colors[x + y * 40]
				if char ~= nil then ht.setscreen(x, y, char) end
				if color ~= nil then ht.setcolor(x, y, color) end
			end
		end
	end
end

function getpictures(pictures, x, y)
	local ret = { color = nil, char = nil }
	for i = #pictures,1,-1 do
		local picture = pictures[i]
		if ret.color == nil then ret.color = picture.colors[x + y * 40] end
		if ret.char == nil then ret.char = picture.chars[x + y * 40] end
	end
	return ret
end

function loadproject(filename)
	local pic = { tip = 1, { chars = {} , colors = {}, }}
	local scr = { tip = 1, { chars = {} , colors = {}, }}
	local f, err = io.open(filename, 'rb')
	if f == nil then return false end

	local bgcolor = f:read(1)
	if #bgcolor ~= 1 then f:close(); return false end

	local bordercolor = f:read(1)
	if #bordercolor ~= 1 then f:close(); return false end

	local case = f:read(1)
	if #case ~= 1 then f:close(); return false end

	local pic_char = f:read(1000)
	if #pic_char ~= 1000 then f:close(); return false end

	local pic_color = f:read(1000)
	if #pic_color ~= 1000 then f:close(); return false end

	local scr_char = f:read(1000)
	if #scr_char ~= 1000 then f:close(); return false end

	local scr_color = f:read(1000)
	if #scr_color ~= 1000 then f:close(); return false end

	f:close()

	for i = 1,1000 do
		pic[1].chars[i - 1] = pic_char:byte(i)
		pic[1].colors[i - 1] = pic_color:byte(i)
		scr[1].chars[i - 1] = scr_char:byte(i)
		scr[1].colors[i - 1] = scr_color:byte(i)
	end

	setcase(case:byte() == 1)
	setbg(bgcolor:byte())
	setborder(bordercolor:byte())
	picture = pic
	scratch = scr
	current_picture = picture

	return true
end

if #args > 0 then
	filename = args[1]
	oldfilename = args[1]
	loadproject(filename)
end

function saveproject(filename)
	local pic_char = {}
	local pic_col = {}
	local scr_char = {}
	local scr_col = {}
	local f, err = io.open(filename, 'wb')
	if f == nil then return false end

	for y = 0,24 do
		for x = 0,39 do
			local pic = getpictures(picture, x, y)
			table.insert(pic_char, pic.char)
			table.insert(pic_col, pic.color)
			local scr = getpictures(scratch, x, y)
			table.insert(scr_char, scr.char)
			table.insert(scr_col, scr.color)
		end
	end

	f:write(string.char(bgcolor))
	f:write(string.char(bordercolor))
	f:write(string.char(lowercase and 1 or 0))
	f:write(string.char(unpack(pic_char)))
	f:write(string.char(unpack(pic_col)))
	f:write(string.char(unpack(scr_char)))
	f:write(string.char(unpack(scr_col)))
	f:close()
end


function new_frame()
	return { chars = {}, colors = {}, }
end

function merge(frames)
	local ret = new_frame()
	for y = 0,24 do
		for x = 0,39 do
			local c = getpictures(frames, x, y)
			ret.chars[x + y * 40] = c.char
			ret.colors[x + y * 40] = c.color
		end
	end
	return ret
end

function add_frame(stack, frame)
	stack.tip = stack.tip + 1
	stack[stack.tip] = frame
	while stack.tip < #stack do
		table.remove(stack)
	end

	if #stack > maxundo then
		local merged = merge({stack[1], stack[2]})
		table.remove(stack, 1)
		table.remove(stack, 1)
		table.insert(stack, 1, merged)
		stack.tip = stack.tip - 1
	end
end

function undo(stack)
	if stack.tip == 1 then return end
	stack.tip = stack.tip - 1
end

function redo(stack)
	if stack.tip == #stack then return end
	stack.tip = stack.tip + 1
end

function tip(stack)
	local ret = {}
	for i = 1,stack.tip do ret[i] = stack[i] end
	return ret
end


-- TODO display error messages
if message ~= nil then message = nil end
global_bindings = {
	{ ev.KEYDOWN, 'Q', function () if ctrl then ht.quit() end end },

	{ ev.KEYDOWN, 'Left Shift', function () lshift = true; shift = lshift or rshift end },
	{ ev.KEYUP, 'Left Shift', function () lshift = false; shift = lshift or rshift end },
	{ ev.KEYDOWN, 'Right Shift', function () rshift = true; shift = lshift or rshift end },
	{ ev.KEYUP, 'Right Shift', function () rshift = false; shift = lshift or rshift end },

	{ ev.KEYDOWN, 'Left Ctrl', function () lctrl = true; ctrl = lctrl or rctrl end },
	{ ev.KEYUP, 'Left Ctrl', function () lctrl = false; ctrl = lctrl or rctrl end },
	{ ev.KEYDOWN, 'Right Ctrl', function () rctrl = true; ctrl = lctrl or rctrl end },
	{ ev.KEYUP, 'Right Ctrl', function () rctrl = false; ctrl = lctrl or rctrl end },
}

function expect(bindings, event)
	for i = 1,#bindings do
		local t, key, f
		t, key, f = unpack(bindings[i])
		if t == event.t and key == event.key then f() end
	end
end

editmode = {
	marker_w = 1,
	marker_h = 1,
	marker_x = 0,
	marker_y = 0,
	tmp_x = 1,
	tmp_y = 1,
	tmp_w = 1,
	tmp_h = 1,
	brush = { w = 1, h = 1, chars = { [0] = 0xa0 }, colors = { [0] = 0x1 } },
	palette = false,
	insert = false,
	prompting = false,
	afterprompt = nil,

	bindings = {
		{ ev.KEYDOWN, 'Up', function () editmode:cursor_up() end },
		{ ev.KEYDOWN, 'Down', function () editmode:cursor_down() end },
		{ ev.KEYDOWN, 'Left', function () editmode:cursor_left() end },
		{ ev.KEYDOWN, 'Right', function () editmode:cursor_right() end },
		{ ev.KEYDOWN, 'K', function () editmode:cursor_up() end },
		{ ev.KEYDOWN, 'J', function () editmode:cursor_down() end },
		{ ev.KEYDOWN, 'H', function () editmode:cursor_left() end },
		{ ev.KEYDOWN, 'L', function () editmode:cursor_right() end },
		{ ev.KEYDOWN, 'Backspace', function () editmode:reset_wh() end },
		{ ev.KEYDOWN, 'Y', function () editmode:copy() end },
		{ ev.KEYDOWN, 'Space', function () editmode:copy() end },
		{ ev.KEYDOWN, 'Return', function () editmode:togglepalette() end },
		{ ev.KEYDOWN, 'Tab', function () editmode:togglescratch() end },
		{ ev.TEXT, 'u', function () undo(current_picture); editmode:draw() end },
		{ ev.TEXT, 'U', function () redo(current_picture); editmode:draw() end },
		{ ev.TEXT, 'f', function () editmode:paintbrush(false, true, true) end },
		{ ev.TEXT, 'F', function () editmode:paintbrush(true, true, true) end },
		{ ev.TEXT, 'd', function () editmode:paintbrush(false, true, false) end },
		{ ev.TEXT, 'D', function () editmode:paintbrush(true, true, false) end },
		{ ev.TEXT, 's', function () editmode:paintbrush(false, false, true) end },
		{ ev.TEXT, 'S', function () editmode:paintbrush(true, false, true) end },
		{ ev.TEXT, 'I', function () editmode:invert() end },
		{ ev.KEYDOWN, 'X', function () editmode:flip() end },
		{ ev.KEYDOWN, 'B', function () editmode:setbgborder() end },
		{ ev.TEXT, 'i', function () if not editmode.palette then editmode.insert = true end end },
		{ ev.KEYDOWN, 'F1', function () editmode:initsave() end },
		{ ev.KEYDOWN, 'F2', function () editmode:initload() end },
		{ ev.TEXT, 'C', function () setcase(not lowercase); end },
		{ ev.TEXT, 't', function ()  editmode:fittobrush() end },
	},

	draw = function (self)
		local pics = {unpack(tip(current_picture))}
		if self.palette then table.insert(pics, palettepic) end
		if self.prompting then table.insert(pics, promptpic) end
		redraw_prompt()
		drawpictures(pics)
	end,

	initsave = function (self)
		editmode.prompting = true
		prompt = "save: "
		self.afterprompt = function ()
			saveproject(filename)
		end
	end,
	initload = function (self)
		editmode.prompting = true
		prompt = "load: "
		self.afterprompt = function ()
			loadproject(filename)
			self:draw()
		end
	end,

	flip = function (self)
		if self.palette then return end
		local pics = {unpack(tip(current_picture))}
		local frame = new_frame()

		for y = self.marker_y,self.marker_y+self.marker_h-1 do
			local newy = self.marker_y + self.marker_h - (y - self.marker_y) - 1
			for x = self.marker_x,self.marker_x+self.marker_w-1 do
				local c = getpictures(pics, x, y)
				local newx = self.marker_x + self.marker_w - (x - self.marker_x) - 1
				if shift then
					frame.chars[x + newy * 40] = flip_vertical[c.char]
					frame.colors[x + newy * 40] = c.color
				else
					frame.chars[newx + y * 40] = flip_horizontal[c.char]
					frame.colors[newx + y * 40] = c.color
				end
			end
		end

		add_frame(current_picture, frame)
		self:draw()
	end,

	setbgborder = function (self)
		local pics = {unpack(tip(current_picture))}
		if self.palette then table.insert(pics, palettepic) end
		local c = getpictures(pics, self.marker_x, self.marker_y).color
		if shift then
			setborder(c)
		else
			setbg(c)
		end
	end,

	invert = function (self)
		if self.palette then return end
		local frame = new_frame()
		local pics = {unpack(tip(current_picture))}
		for y = self.marker_y,self.marker_y+self.marker_h-1 do
			for x = self.marker_x,self.marker_x+self.marker_w-1 do
				local c = getpictures(pics, x, y).char
				local index = x + y * 40
				if c < 0x80 then
					c = c + 0x80
				else
					c = c - 0x80
				end
				frame.chars[index] = c
			end
		end
		add_frame(current_picture, frame)
		self:draw()
	end,

	togglescratch = function (self)
		if current_picture == picture then
			current_picture = scratch
		else
			current_picture = picture
		end
		self:draw()
	end,

	handle = function (self, event)
		if self.prompting then
			local mx, my
			self:draw()
			ht.setlowercase(true)

			if event.t == ev.KEYDOWN then
				if event.key == 'Return' then
					ht.setlowercase(lowercase)
					self.prompting = false
					oldfilename = filename
					if self.afterprompt ~= nil then
						self:afterprompt()
					end
				elseif event.key == 'Backspace' then
					filename = string.sub(filename, 1, #filename - 1)
				elseif event.key == 'Escape' then
					ht.setlowercase(lowercase)
					filename = oldfilename
					self.prompting = false
				end
			elseif event.t == ev.TEXT then
				filename = filename .. event.key
			end
			mx, my = redraw_prompt()
			ht.setmarker(mx, my, 1, 1)
			self:draw()
			if self.prompting then return end
		elseif self.insert then
			if event.t == ev.TEXT then
				local char = ascii2scr(event.key)[1]
				local frame = new_frame()
				for y = self.marker_y,self.marker_y+self.marker_h-1 do
					for x = self.marker_x,self.marker_x+self.marker_w-1 do
						frame.chars[x + 40 * y] = char
						frame.colors[x + 40 * y] = fgcolor
					end
				end
				add_frame(current_picture, frame)
				self:draw()
				self:cursor_right()
				self.insert = false
			end
		else
			expect(self.bindings, event)
		end
		ht.setmarker(self.marker_x, self.marker_y, self.marker_w, self.marker_h)
	end,

	togglepalette = function (self)
		if self.palette then
			local pics = {unpack(tip(current_picture))}
			table.insert(pics, palettepic)
			local c = getpictures(pics, self.marker_x, self.marker_y).color
			fgcolor = c
			recolor_palette()
			self:copy()
		end
		self.palette = not self.palette
		self.tmp_x, self.marker_x = self.marker_x, self.tmp_x
		self.tmp_y, self.marker_y = self.marker_y, self.tmp_y
		self.tmp_w, self.marker_w = self.marker_w, self.tmp_w
		self.tmp_h, self.marker_h = self.marker_h, self.tmp_h
		self:draw()
	end,

	copy = function (self)
		self.brush.w = self.marker_w
		self.brush.h = self.marker_h
		self.brush.chars = {}
		self.brush.colors = {}
		local pics = {unpack(tip(current_picture))}
		if self.palette then table.insert(pics, palettepic) end
		for y = 0,self.marker_h-1 do
			for x = 0,self.marker_w-1 do
				local vx = x + self.marker_x
				local vy = y + self.marker_y
				local c = getpictures(pics, vx, vy)
				self.brush.colors[x + y * self.brush.w] = c.color
				self.brush.chars[x + y * self.brush.w] = c.char
			end
		end
	end,

	paintbrush = function (self, skipspace, drawchar, drawcolor)
		if self.palette then return end
		local frame = new_frame()
		for y = 0,self.marker_h-1 do
			for x = 0,self.marker_w-1 do
				local index = (self.marker_x + x) + (self.marker_y + y) * 40
				local bindex = (x % self.brush.w) + (y % self.brush.h) * self.brush.w
				if self.brush.chars[bindex] ~= 0x20 or not skipspace then
					if drawchar then
						frame.chars[index] = self.brush.chars[bindex]
					end
					if drawcolor then
						frame.colors[index] = self.brush.colors[bindex]
					end
				end
			end
		end
		add_frame(current_picture, frame)
		self:draw()
	end,

	reset_wh = function (self)
		self.marker_w = 1
		self.marker_h = 1
	end,

	fittobrush = function (self)
		if self.palette then return end
		self.marker_w = self.brush.w
		self.marker_h = self.brush.h
		local xoffset = self.marker_x + self.marker_w
		local yoffset = self.marker_y + self.marker_h
		if xoffset > 40 then
			self.marker_x = self.marker_x - (xoffset - 40)
		end
		if yoffset > 25 then
			self.marker_y = self.marker_y - (yoffset - 25)
		end
	end,

	roll = function (self, xadd, yadd)
			if self.palette then return end
			local pics = {unpack(tip(current_picture))}
			local frame = new_frame()
			for y = 0,self.marker_h-1 do
				for x = 0,self.marker_w-1 do
					local sx = ((x + xadd) % self.marker_w) + self.marker_x
					local sy = ((y + yadd) % self.marker_h) + self.marker_y
					local c = getpictures(pics, sx, sy)
					local mx = x + self.marker_x
					local my = y + self.marker_y
					frame.chars[mx + my * 40] = c.char
					frame.colors[mx + my * 40] = c.color
				end
			end
			add_frame(current_picture, frame)
			self:draw()
	end,

	cursor_up = function (self)
		local min
		if self.palette then min = 1 else min = 0 end
		if ctrl then
			self:roll(0, 1)
		elseif shift then
			if self.marker_h > 1 then self.marker_h = self.marker_h - 1 end
		else
			if self.marker_y > min then self.marker_y = self.marker_y - 1 end
		end
	end,

	cursor_down = function (self)
		local max
		if self.palette then max = 18 else max = 25 end
		if ctrl then
			self:roll(0, -1)
		elseif shift then
			if self.marker_h + self.marker_y < max then self.marker_h = self.marker_h + 1 end
		else
			if self.marker_h + self.marker_y < max then self.marker_y = self.marker_y + 1 end
		end
	end,

	cursor_left = function (self)
		local min
		if self.palette then min = 1 else min = 0 end
		if ctrl then
			self:roll(1, 0)
		elseif shift then
			if self.marker_w > 1 then self.marker_w = self.marker_w - 1 end
		else
			if self.marker_x > min then self.marker_x = self.marker_x - 1 end
		end
	end,

	cursor_right = function (self)
		local max
		if self.palette then max = 17 else max = 40 end
		if ctrl then
			self:roll(-1, 0)
		elseif shift and not self.insert then
			if self.marker_w + self.marker_x < max then self.marker_w = self.marker_w + 1 end
		else
			if self.marker_w + self.marker_x < max then self.marker_x = self.marker_x + 1 end
		end
	end,
}

current_picture = picture
drawpictures({unpack(tip(current_picture))})
ht.setmarker(editmode.marker_x, editmode.marker_y, editmode.marker_w, editmode.marker_h)

local current_mode = editmode
function handle(event)
	if event.t == ev.TEXT or event.t == ev.KEYDOWN or event.t == ev.KEYUP then
		expect(global_bindings, event)
		current_mode:handle(event)
	end
end
