//// Setup functions

// No setup required.

//// This is the entire script lmao


ppmod.fire("!picker","runscriptcode","::scns_picker <- self")
    local host = FindByEntIndex(1)
    
    local hostmodel = host.GetModelName();
    local pickermodel = scns_picker.GetModelName();
    if (!pickermodel||!hostmodel) return;
    scns_picker.SetModel(hostmodel.tostring());
    host.SetModel(pickermodel.tostring());
    ppmod.wait(function() {
      scns_picker <- null;
    })
    
    





//// Leftover Stuff

// local picker = Entities.FindByTarget(null, "scns_smwp 1")
    //local picker = TempFindByKeyValue("scns_smwp","1")
// local randomstring = UniqueString("scns_smwp")
    
// local TempFindByKeyValue = function(key,val) {
//     print(key)
//     print(val)
//     local ent = Entities.First()
//     while (ent != null) // Continue until there are no more entities
//     {
//       if (ent.GetKeyValue("scns_smwp") != val) {
//         ent = Entities.Next(ent); // Proceed to the next entity
//         print(ent.GetKeyString(key))
//       } else {
//         print(ent.GetClassname())
//         return ent
//       }
//     }    
// }
