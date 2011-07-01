local typeList = {"Byte", "Char", "Short", "Int", "Long", "Float", "Double"}

for _,type in pairs(typeList) do
   
   local Storage = torch.getmetatable("torch." .. type .. "Storage")

   Storage.__copy = {}
   for _,type in pairs(typeList) do
      Storage.__copy[torch.typename2id("torch." .. type .. "Storage")] = Storage["copy" .. type]
      Storage["copy" .. type] = nil -- we hide this one into __copy
   end

   function Storage:copy(src)
      local func = self.__copy[torch.id(src)]
      assert(func, "unable to copy Storage type " .. torch.typename(src))
      return func(self, src)
   end

end
