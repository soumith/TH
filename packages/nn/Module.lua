local Module = torch.class('nn.Module')

function Module:__init()
   self.gradInput = torch.Tensor()
   self.output = torch.Tensor()
end

function Module:forward(input)
   return self.output
end

function Module:backward(input, gradOutput)
   return self.gradInput
end

function Module:zeroGradParameters()
end

function Module:updateParameters(learningRate)
end

function Module:write(file)
   file:writeObject(self.gradInput)
   file:writeObject(self.output)
end

function Module:read(file)
   self.gradInput = file:readObject()
   self.output = file:readObject()
end

function Module:share(mlp, ...)
   for i,v in ipairs(arg) do
      if self[v] ~=nil then self[v]:set(mlp[v]) end
   end
end

function Module:clone(...)
   local f = torch.MemoryFile("rw"):binary()
   f:writeObject(self)
   f:seek(1)
   local clone = f:readObject()
   f:close()
   if select('#',...) > 0 then
      clone:share(self,...)
   end
   return clone
end

function Module:__call__(...)
   local args = {...}
   local module
   if select('#',...) == 1 then -- sequential
      module = nn.Sequential()
      if torch.typename(args[1]) == 'nn.Sequential' then
         module = args[1]
         module:add(self)
      else
         module:add(args[1])
         module:add(self)
      end
   elseif select('#',...) > 1 then -- parallel
      module = nn.Sequential()
      local par = nn.ParallelTable()
      for i = 1,select('#',...) do
         par:add(args[i])
      end
      module:add(par)
      module:add(nn.JoinTable(1))
      module:add(self)
   end
   return module
end

function Module:__index__(key)
   if type(key)=='number' then
      local module
      if torch.typename(self) == 'nn.Sequential' then
         module = self
      else
         module = nn.Sequential()
         module:add(self)
      end
      module:add(nn.Narrow(1,key,1))
      return module, true
   end
   return rawget(self,key)
end
