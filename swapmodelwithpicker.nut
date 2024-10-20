local host = FindByEntIndex(1)
local hostmodel = host.GetModelName();
local pickermodel = GetPicker().GetModelName();
if (!pickermodel||!hostmodel) return;
GetPicker().SetModel(hostmodel.tostring());
host.SetModel(pickermodel.tostring());
