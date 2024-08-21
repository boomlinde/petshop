-- Lua 5.3 compatibility
if unpack == nil then unpack = table.unpack end

maxundo = 20
width = 40
height = 25

lctrl = false
rctrl = false
ctrl = false

bgcolor = 0x6
bordercolor = 0xe
prompt = 'save: '
oldfilename = 'blank.pet'
filename = 'blank.pet'
lowercase = false

palettepic = { chars = {}, colors = {}, }
promptpic = { chars = {}, colors = {} }
picture = { tip = 1, { chars = {} , colors = {}, }}
scratch = { tip = 1, { chars = {} , colors = {}, }}

flip_horizontal = {
	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b,
	0x0c, 0x0d, 0x0e, 0x0f, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
	0x18, 0x19, 0x1a, 0x1d, 0x1c, 0x1b, 0x1e, 0x1f, 0x20, 0x21, 0x22, 0x23,
	0x24, 0x25, 0x26, 0x27, 0x29, 0x28, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f,
	0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3a, 0x3b,
	0x3e, 0x3d, 0x3c, 0x3f, 0x43, 0x41, 0x5d, 0x43, 0x44, 0x45, 0x46, 0x48,
	0x47, 0x55, 0x4b, 0x4a, 0x7a, 0x4e, 0x4d, 0x50, 0x4f, 0x51, 0x52, 0x53,
	0x59, 0x49, 0x56, 0x57, 0x58, 0x54, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x69,
	0x60, 0xe1, 0x62, 0x63, 0x64, 0x6a, 0xe6, 0x74, 0x68, 0x5f, 0x74, 0x73,
	0x7b, 0x7d, 0x70, 0x6f, 0x6e, 0x71, 0x72, 0x6b, 0x6a, 0x76, 0x75, 0x77,
	0x78, 0x79, 0x4c, 0x6c, 0x7e, 0x6d, 0x7c, 0xff, 0x80, 0x81, 0x82, 0x83,
	0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f,
	0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98, 0x99, 0x9a, 0x9d,
	0x9c, 0x9b, 0x9e, 0x9f, 0xe0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7,
	0xa9, 0xa8, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf, 0xb0, 0xb1, 0xb2, 0xb3,
	0xb4, 0xb5, 0xb6, 0xb7, 0xb8, 0xb9, 0xba, 0xbb, 0xbe, 0xbd, 0xbc, 0xbf,
	0xc3, 0xc1, 0xdd, 0xc3, 0xc4, 0xc5, 0xc6, 0xc8, 0xc7, 0xd5, 0xcb, 0xca,
	0xfa, 0xce, 0xcd, 0xd0, 0xcf, 0xd1, 0xd2, 0xd3, 0xd9, 0xc9, 0xd6, 0xd7,
	0xd8, 0xd4, 0xda, 0xdb, 0xdc, 0xdd, 0xde, 0xe9, 0xe0, 0x61, 0xe2, 0xe3,
	0xe4, 0xea, 0x66, 0xf4, 0xe8, 0xdf, 0xf4, 0xf3, 0xfb, 0xfd, 0xf0, 0xef,
	0xee, 0xf1, 0xf2, 0xeb, 0xea, 0xf6, 0xf5, 0xf7, 0xf8, 0xf9, 0xcc, 0xec,
	0xfe, 0xed, 0xfc, 0x7f,
}

flip_vertical = {
	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b,
	0x0c, 0x0d, 0x0e, 0x0f, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
	0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f, 0x20, 0x21, 0x22, 0x23,
	0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f,
	0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3a, 0x3b,
	0x3c, 0x3d, 0x3e, 0x3f, 0x43, 0x41, 0x5d, 0x43, 0x46, 0x52, 0x44, 0x47,
	0x48, 0x4b, 0x55, 0x49, 0x4f, 0x4e, 0x4d, 0x4c, 0x7a, 0x51, 0x45, 0x53,
	0x54, 0x4a, 0x56, 0x57, 0x58, 0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0xe9,
	0x60, 0x61, 0xe2, 0x64, 0x63, 0x74, 0xe6, 0x6a, 0x68, 0xdf, 0x6a, 0x6b,
	0x7c, 0x70, 0x7d, 0x77, 0x6d, 0x72, 0x71, 0x73, 0x74, 0x75, 0x76, 0x6f,
	0x79, 0x78, 0x50, 0x7e, 0x6c, 0x6e, 0x7b, 0xff, 0x80, 0x81, 0x82, 0x83,
	0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f,
	0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98, 0x99, 0x9a, 0x9b,
	0x9c, 0x9d, 0x9e, 0x9f, 0xe0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7,
	0xa8, 0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf, 0xb0, 0xb1, 0xb2, 0xb3,
	0xb4, 0xb5, 0xb6, 0xb7, 0xb8, 0xb9, 0xba, 0xbb, 0xbc, 0xbd, 0xbe, 0xbf,
	0xc3, 0xc1, 0xdd, 0xc3, 0xc6, 0xd2, 0xc4, 0xc7, 0xc8, 0xcb, 0xd5, 0xc9,
	0xcf, 0xce, 0xcd, 0xcc, 0xfa, 0xd1, 0xc5, 0xd3, 0xd4, 0xca, 0xd6, 0xd7,
	0xd8, 0xd9, 0xda, 0xdb, 0xdc, 0xdd, 0xde, 0x69, 0xe0, 0xe1, 0x62, 0xe4,
	0xe3, 0xf4, 0x66, 0xea, 0xe8, 0x5f, 0xea, 0xeb, 0xfc, 0xf0, 0xfd, 0xf7,
	0xed, 0xf2, 0xf1, 0xf3, 0xf4, 0xf5, 0xf6, 0xef, 0xf9, 0xf8, 0xd0, 0xfe,
	0xec, 0xee, 0xfb, 0x7f,
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

function recolorpalette(c)
	for y = 1,16 do
		for x = 1,16 do
			palettepic.colors[x + y * width] = c
		end
	end
end

function redrawprompt()
	for x=0,(width - 1) do
		promptpic.chars[x + (height - 1) * width] = 0x20
		promptpic.colors[x + (height - 1) * width] = bgcolor + 11
	end
	local s = ascii2scr(prompt .. filename)
	for x=1,#s do
		promptpic.chars[(x-1) + (height - 1) * width] = s[x]
	end
	return #s, (height - 1)
end

function setbg(c) bgcolor = c % 16; ht.setbg(bgcolor) end
function setborder(c) bordercolor = c % 16; ht.setborder(bordercolor) end
function setcase(c) lowercase = c; ht.setlowercase(c) end

function drawpictures(pictures)
	for i = 1,#pictures do
		local picture = pictures[i]
		for y = 0,(height - 1) do
			for x = 0,(width - 1) do
				local char = picture.chars[x + y * width]
				local color = picture.colors[x + y * width]
				if char ~= nil then ht.setscreen(x, y, char) end
				if color ~= nil then ht.setcolor(x, y, color) end
			end
		end
	end
end

function getfrom(pictures, x, y)
	local ret = { color = nil, char = nil }
	for i = #pictures,1,-1 do
		local picture = pictures[i]
		if ret.color == nil then ret.color = picture.colors[x + y * width] end
		if ret.char == nil then ret.char = picture.chars[x + y * width] end
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

	return true
end

function saveproject(filename)
	local pic_char = {}
	local pic_col = {}
	local scr_char = {}
	local scr_col = {}
	local f, err = io.open(filename, 'wb')
	if f == nil then return false end

	for y = 0,(height - 1) do
		for x = 0,(width - 1) do
			local pic = getfrom(picture, x, y)
			table.insert(pic_char, pic.char)
			table.insert(pic_col, pic.color)
			local scr = getfrom(scratch, x, y)
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


function newframe()
	return { chars = {}, colors = {}, }
end

function merge(frames)
	local ret = newframe()
	for y = 0,(height - 1) do
		for x = 0,(width - 1) do
			local c = getfrom(frames, x, y)
			ret.chars[x + y * width] = c.char
			ret.colors[x + y * width] = c.color
		end
	end
	return ret
end

function addframe(stack, frame)
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

editor = {
	mw = 1, mh = 1, mx = 0, my = 0,
	tmp_x = 1, tmp_y = 11, tmp_w = 1, tmp_h = 1,
	brush = { w = 1, h = 1, chars = { [0] = 0xa0 }, colors = { [0] = 0xe } },
	palette = false,
	insert = false,
	prompting = false,
	afterprompt = nil,
	lshift = false,
	rshift = false,
	shift = false,
	oldshift = false,
	mouseenabled = true,
	currentholding = nil,
	drawchars = true,
	drawcolors = true,
	drawspaces = true,
	showflags = false,

	bindings = {
		{ ev.KEYDOWN, 'Q', function () if ctrl then ht.quit() end end },
		{ ev.KEYDOWN, 'Left Shift', function () editor.lshift = true; editor:onshift() end },
		{ ev.KEYUP, 'Left Shift', function () editor.lshift = false; editor:onshift() end },
		{ ev.KEYDOWN, 'Right Shift', function () editor.rshift = true; editor:onshift() end },
		{ ev.KEYUP, 'Right Shift', function () editor.rshift = false; editor:onshift() end },
		{ ev.KEYDOWN, 'Left Ctrl', function () lctrl = true; ctrl = lctrl or rctrl end },
		{ ev.KEYUP, 'Left Ctrl', function () lctrl = false; ctrl = lctrl or rctrl end },
		{ ev.KEYDOWN, 'Right Ctrl', function () rctrl = true; ctrl = lctrl or rctrl end },
		{ ev.KEYUP, 'Right Ctrl', function () rctrl = false; ctrl = lctrl or rctrl end },
		{ ev.KEYDOWN, 'Up', function () editor:cursor_up() end },
		{ ev.KEYDOWN, 'Down', function () editor:cursor_down() end },
		{ ev.KEYDOWN, 'Left', function () editor:cursor_left() end },
		{ ev.KEYDOWN, 'Right', function () editor:cursor_right() end },
		{ ev.KEYDOWN, 'K', function () editor:cursor_up() end },
		{ ev.KEYDOWN, 'J', function () editor:cursor_down() end },
		{ ev.KEYDOWN, 'H', function () editor:cursor_left() end },
		{ ev.KEYDOWN, 'L', function () editor:cursor_right() end },
		{ ev.KEYDOWN, 'Backspace', function () editor:reset_wh() end },
		{ ev.KEYDOWN, 'Y', function () editor:copy() end },
		{ ev.KEYDOWN, 'Space', function () editor:togglepalette() end },
		{ ev.KEYDOWN, 'Escape', function () editor:exitpalette() end },
		{ ev.KEYDOWN, 'Tab', function () editor:togglescratch() end },
		{ ev.KEYDOWN, 'U', function () if editor.shift then redo(picture) else undo(picture) end; editor:draw() end },

		{ ev.KEYDOWN, 'F', function () if editor.palette then editor:togglepalette() else editor:paintbrush(editor.shift, true, true) end end },
		{ ev.KEYDOWN, 'D', function () editor:paintbrush(editor.shift, true, false) end },
		{ ev.KEYDOWN, 'S', function () editor:paintbrush(editor.shift, false, true) end },
		{ ev.KEYUP, 'F', function () editor:enddraw() end },
		{ ev.KEYUP, 'D', function () editor:enddraw() end },
		{ ev.KEYUP, 'S', function () editor:enddraw() end },

		{ ev.KEYDOWN, 'X', function () editor:flip() end },
		{ ev.KEYDOWN, 'B', function () editor:setbgborder() end },
		{ ev.TEXT, 'I', function () editor:invert() end },
		{ ev.TEXT, 'i', function () editor:startinsert() end },
		{ ev.KEYDOWN, 'F1', function () editor:initsave() end },
		{ ev.KEYDOWN, 'F2', function () editor:initload() end },
		{ ev.KEYDOWN, 'C', function () if editor.shift then setcase(not lowercase) end end },
		{ ev.KEYDOWN, 'T', function () editor:fittobrush() end },
		{ ev.KEYDOWN, 'M', function () editor:togglemouse() end },


		{ ev.KEYDOWN, '1', function () editor.drawchars = not editor.drawchars; editor.showflags = true; editor:draw() end },
		{ ev.KEYDOWN, '2', function () editor.drawcolors = not editor.drawcolors; editor.showflags = true; editor:draw() end },
		{ ev.KEYDOWN, '3', function () editor.drawspaces = not editor.drawspaces; editor.showflags = true; editor:draw() end },
		{ ev.KEYUP, '1', function () editor.showflags = false; editor:draw() end },
		{ ev.KEYUP, '2', function () editor.showflags = false; editor:draw() end },
		{ ev.KEYUP, '3', function () editor.showflags = false; editor:draw() end },

		{ ev.KEYDOWN, '4', function () if editor.palette then editor:togglepalette() else editor:paintbrush(not editor.drawspaces, editor.drawchars, editor.drawcolors) end end },
		{ ev.KEYUP, '4', function () editor:enddraw() end },
	},

	togglemouse = function (self)
		self.mouseenabled = not self.mouseenabled
		if self.mouseenabled then
			ht.mousevisible(1)
			x, y = ht.getmouse()
		else
			ht.mousevisible(0)
		end
	end,

	onshift = function (self)
		self.shift = self.rshift or self.lshift
		if self.oldshift ~= self.shift then
			self.oldshift = self.shift
			if self.mouseenabled then
				if self.shift then
					ht.setmouse(4 + 8 * (3 + self.mx + self.mw - 1), 4 + 8 * (3 + self.my + self.mh - 1))
				else
					ht.setmouse(4 + 8 * (3 + self.mx), 4 + 8 * (3 + self.my))
				end
			end

		end
	end,

	draw = function (self)
		local pics = {unpack(tip(picture))}
		if self.palette then table.insert(pics, palettepic) end
		if self.prompting then table.insert(pics, promptpic) end
		if self.insert then table.insert(pics, self.editframe) end
		if self.showflags then table.insert(pics, self:flagpic()) end
		redrawprompt()
		drawpictures(pics)
	end,

	flagpic = function (self)
		local out = { chars = {}, colors = {} }

		local str = ""
		if self.drawchars then str = str.."chr(*) " else str = str.."chr( ) " end
		if self.drawcolors then str = str.."col(*) " else str = str.."col( ) " end
		if self.drawspaces then str = str.."spc(*) " else str = str.."spc( )" end

		local scr = ascii2scr(str)
		for i = 1,#scr do
			out.chars[40*24-1+i] = scr[i]
			out.colors[40*24-1+i] = (bgcolor+1) % 16
		end
		return out
	end,

	initsave = function (self)
		self.prompting = true
		prompt = "save: "
		mx, my = redrawprompt()
		ht.setmarker(mx, my, 1, 1)
		ht.setlowercase(true)
		self:draw()
		self.afterprompt = function () saveproject(filename) end
	end,

	initload = function (self)
		self.prompting = true
		prompt = "load: "
		mx, my = redrawprompt()
		ht.setmarker(mx, my, 1, 1)
		ht.setlowercase(true)
		self:draw()
		self.afterprompt = function () loadproject(filename) end
	end,

	flip = function (self)
		if self.palette then return end
		local pics = {unpack(tip(picture))}
		local frame = newframe()

		for y = self.my,self.my+self.mh-1 do
			local newy = self.my + self.mh - (y - self.my) - 1
			for x = self.mx,self.mx+self.mw-1 do
				local c = getfrom(pics, x, y)
				local newx = self.mx + self.mw - (x - self.mx) - 1
				if self.shift then
					frame.chars[x + newy * width] = flip_vertical[c.char + 1]
					frame.colors[x + newy * width] = c.color
				else
					frame.chars[newx + y * width] = flip_horizontal[c.char + 1]
					frame.colors[newx + y * width] = c.color
				end
			end
		end

		addframe(picture, frame)
		self:draw()
	end,

	setbgborder = function (self)
		local pics = {unpack(tip(picture))}
		if self.palette then table.insert(pics, palettepic) end
		local c = getfrom(pics, self.mx, self.my).color
		if self.shift then setborder(c) else setbg(c) end
	end,

	invert = function (self)
		if self.palette then return end
		local frame = newframe()
		local pics = {unpack(tip(picture))}
		for y = self.my,self.my+self.mh-1 do
			for x = self.mx,self.mx+self.mw-1 do
				local c = getfrom(pics, x, y).char
				local index = x + y * width
				if c < 0x80 then c = c + 0x80 else c = c - 0x80 end
				frame.chars[index] = c
			end
		end
		addframe(picture, frame)
		self:draw()
	end,

	togglescratch = function (self)
		picture, scratch = scratch, picture
		self:draw()
	end,

	enddraw = function(self)
		self.currentholding = nil
	end,

	handle = function (self, event)
		if event.t == ev.QUIT then ht.quit() return end

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
						ht.setmarker(self.mx, self.my, self.mw, self.mh)
						self:draw()
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
			elseif event.t == ev.MOUSEMOTION then
				self:handlemouse(event.x, event.y)
			end
			mx, my = redrawprompt()
			ht.setmarker(mx, my, 1, 1)
			self:draw()
		elseif self.insert then
			if event.t == ev.KEYDOWN and event.key == 'Backspace' then
				self:cursor_left()
				local char = ascii2scr(' ')[1]
				for y = self.my,self.my+self.mh-1 do
					for x = self.mx,self.mx+self.mw-1 do
						self.editframe.chars[x + width * y] = char
						self.editframe.colors[x + width * y] = self.brush.colors[0]
					end
				end
				self:draw()
			elseif event.t == ev.KEYDOWN and event.key == 'Up' then
				self:cursor_up()
			elseif event.t == ev.KEYDOWN and event.key == 'Down' then
				self:cursor_down()
			elseif event.t == ev.KEYDOWN and event.key == 'Left' then
				self:cursor_left()
			elseif event.t == ev.KEYDOWN and event.key == 'Right' then
				self:cursor_right()
			elseif event.t == ev.KEYDOWN and event.key == 'Return' then
				self:cursor_down()
				self.mx = self.startcolumn
			elseif event.t == ev.KEYDOWN and event.key == 'Escape' then
				addframe(picture, self.editframe)
				self.insert = false
				self.editframe = nil
				ht.setbordermod(0)
				self:draw()
			elseif event.t == ev.TEXT then
				local char = ascii2scr(event.key)[1]
				for y = self.my,self.my+self.mh-1 do
					for x = self.mx,self.mx+self.mw-1 do
						self.editframe.chars[x + width * y] = char
						self.editframe.colors[x + width * y] = self.brush.colors[0]
					end
				end
				self:draw()
				self:cursor_right()
			elseif event.t == ev.MOUSEMOTION then
				self:handlemouse(event.x, event.y)
			end
		elseif event.t == ev.MOUSEMOTION then
			self:handlemouse(event.x, event.y)
		else
			for i = 1,#self.bindings do
				local t, key, f
				t, key, f = unpack(self.bindings[i])
				if t == event.t and key == event.key then f() end
			end
		end
		if not self.prompting then
			ht.setmarker(self.mx, self.my, self.mw, self.mh)
		end
	end,

	togglepalette = function (self)
		if self.palette then
			self:copy()
		else
			recolorpalette(self.brush.colors[0])
		end
		self.tmp_x, self.mx = self.mx, self.tmp_x
		self.tmp_y, self.my = self.my, self.tmp_y
		self.tmp_w, self.mw = self.mw, self.tmp_w
		self.tmp_h, self.mh = self.mh, self.tmp_h
		if self.mouseenabled then
			ht.setmouse(4 + 8 * (3 + self.mx), 4 + 8 * (3 + self.my))
		end
		self.palette = not self.palette
		self:draw()
	end,

	exitpalette = function (self)
		if not self.palette then
			return
		end
		self.palette = false
		self.tmp_x, self.mx = self.mx, self.tmp_x
		self.tmp_y, self.my = self.my, self.tmp_y
		self.tmp_w, self.mw = self.mw, self.tmp_w
		self.tmp_h, self.mh = self.mh, self.tmp_h
		if self.mouseenabled then
			ht.setmouse(4 + 8 * (3 + self.mx), 4 + 8 * (3 + self.my))
		end
		self:draw()
	end,

	handlemouse = function (self, x, y)
		if not self.mouseenabled or self.insert then return end
		if not self.shift then
			local oldmx = self.mx
			local oldmy = self.my
			self.mx = x
			if self.mx + self.mw > (width - 1) then
				self.mx = width - self.mw
			end
			self.my = y
			if self.my + self.mh > (height - 1) then
				self.my = height - self.mh
			end
			if self.palette then self:clamp_selection(1, 1, 17, 18) end
			if self.currentholding ~= nil then
				if oldmx ~= self.mx or oldmy ~= my then
					local ch = self.currentholding
					self:paintbrush(ch.skipspace, ch.drawchar, ch.drawcolor)
				end
			end
		else
			self.mw = x + 1 - self.mx
			self.mh = y + 1 - self.my
			if self.mw < 1 then self.mw = 1 end
			if self.mh < 1 then self.mh = 1 end
			if self.palette then
				if self.mw + self.mx >= 17 then self.mw = 17 - self.mx end
				if self.mh + self.my >= 18 then self.mh = 18 - self.my end
			end
		end
	end,

	copy = function (self)
		self.brush.w = self.mw
		self.brush.h = self.mh
		self.brush.chars = {}
		self.brush.colors = {}
		local pics = {unpack(tip(picture))}
		if self.palette then table.insert(pics, palettepic) end
		for y = 0,self.mh-1 do
			for x = 0,self.mw-1 do
				local vx = x + self.mx
				local vy = y + self.my
				local c = getfrom(pics, vx, vy)
				self.brush.colors[x + y * self.brush.w] = c.color
				self.brush.chars[x + y * self.brush.w] = c.char
			end
		end
		if self.palette and self.my == 17 then
			recolorpalette(self.brush.colors[0])
			self:draw()
		end
	end,

	paintbrush = function (self, skipspace, drawchar, drawcolor)
		if self.palette then return end
		if self.currentholding == nil then
			self.currentholding = {
				skipspace = skipspace,
				drawchar = drawchar,
				drawcolor = drawcolor,
			}
			local frame = newframe()
			addframe(picture, frame)
		end
		local frame = picture[picture.tip]
		for y = 0,self.mh-1 do
			for x = 0,self.mw-1 do
				local index = (self.mx + x) + (self.my + y) * width
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
		self:draw()
	end,

	reset_wh = function (self)
		self.mw = 1
		self.mh = 1
	end,

	fittobrush = function (self)
		if self.palette then return end
		self.mw, self.mh = self.brush.w, self.brush.h
		local xoffset = self.mx + self.mw
		local yoffset = self.my + self.mh
		if xoffset > width then
			self.mx = self.mx - (xoffset - width)
		end
		if yoffset > height then
			self.my = self.my - (yoffset - height)
		end
	end,

	roll = function (self, xadd, yadd)
		if self.palette then return end
		local pics = {unpack(tip(picture))}
		local frame = newframe()
		for y = 0,self.mh-1 do
			for x = 0,self.mw-1 do
				local sx = ((x + xadd) % self.mw) + self.mx
				local sy = ((y + yadd) % self.mh) + self.my
				local c = getfrom(pics, sx, sy)
				local mx = x + self.mx
				local my = y + self.my
				frame.chars[mx + my * width] = c.char
				frame.colors[mx + my * width] = c.color
			end
		end
		addframe(picture, frame)
		self:draw()
	end,

	startinsert = function (self)
		if not self.palette then
			self.insert = true
			self.editframe = newframe()
			self.startcolumn = self.mx
			ht.setbordermod(0x55)
		end
	end,

	cursor_up = function (self)
		if ctrl then
			self:roll(0, 1)
		elseif self.shift then
			if self.mh > 1 then self.mh = self.mh - 1 end
		else
			if self.my > 0 then self.my = self.my - 1 end
			if self.palette then self:clamp_selection(1, 1, 17, 18) end
		end
	end,

	cursor_down = function (self)
		if ctrl then
			self:roll(0, -1)
		elseif self.shift then
			local clamp = height
			if self.palette then clamp = 18 end
			if self.mh + self.my < clamp then self.mh = self.mh + 1 end
		else
			if self.mh + self.my < height then self.my = self.my + 1 end
			if self.palette then self:clamp_selection(1, 1, 17, 18) end
		end
	end,

	cursor_left = function (self)
		if ctrl then
			self:roll(1, 0)
		elseif self.shift then
			if self.mw > 1 then self.mw = self.mw - 1 end
		else
			if self.mx > 0 then self.mx = self.mx - 1 end
			if self.palette then self:clamp_selection(1, 1, 17, 18) end
		end
	end,

	cursor_right = function (self)
		if ctrl then
			self:roll(-1, 0)
		elseif self.shift and not self.insert then
			local clamp = width
			if self.palette then clamp = 17 end
			if self.mw + self.mx < clamp then self.mw = self.mw + 1 end
		else
			if self.mw + self.mx < width then self.mx = self.mx + 1 end
			if self.palette then self:clamp_selection(1, 1, 17, 18) end
		end
	end,

	clamp_selection = function (self, lox, loy, hix, hiy)
		if self.mx < lox then self.mx = lox end
		if self.my < loy then self.my = loy end
		if self.mx + self.mw >= hix then self.mx = hix - self.mw end
		if self.my + self.mh >= hiy then self.my = hiy - self.mh end
	end
}

for i = 0,999 do
	picture[1].chars[i] = 32
	picture[1].colors[i] = 14
	scratch[1].chars[i] = 32
	scratch[1].colors[i] = 14
end

for y = 0,18 do
	for x = 0,17 do
		palettepic.chars[x + y * width] = 0x20
	end
end

for x = 0,15 do
	palettepic.colors[x + 1 + 17 * width] = x
	palettepic.chars[x + 1 + 17 * width] = 0xa0
end

recolorpalette()

for y = 0,15 do
	for x = 0,15 do
		palettepic.chars[x + 1 + (y + 1) * width] = x + y * 16
	end
end

if #args > 0 then
	filename = args[1]
	oldfilename = args[1]
	loadproject(filename)
end

drawpictures({unpack(tip(picture))})
ht.setmarker(editor.mx, editor.my, editor.mw, editor.mh)

function handle(event) editor:handle(event) end
