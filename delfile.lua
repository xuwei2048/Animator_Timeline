require "lfs"
local srcDir ="E:/old/E/Digia/ss/effect_wdf"
function getpathes(rootpath , callback)
    for entry in lfs.dir(rootpath) do
        if entry ~= '.' and entry ~= '..' then
            local path = rootpath .. '\\' .. entry
            local attr = lfs.attributes(path)
            assert(type(attr) == 'table') 	    
            if attr.mode == 'directory' then
                getpathes(path, callback)
            else
				callback(rootpath,entry )		
            end
        end
    end
end
getpathes(srcDir, function(rootpath,entry ) 
	local path  = rootpath.."/"..entry
	local w_path = string.gsub(path , "/","\\")
	local w_dir = string.gsub(rootpath , "/","\\")
	local _,_,dirname = string.find(entry , "(.*)%.was")
	if dirname ==nil then
		print(entry)
	else
		local mkdir_cmd= "mkdir "..w_dir.."\\"..dirname
		os.execute(mkdir_cmd)
		local sprit_cmd= "Sprite.exe "..w_path
		os.execute(sprit_cmd)
		local move_cmd ="move "..w_dir.."\\*.tga "..w_dir.."\\"..dirname
		os.execute(move_cmd)
	end
end)