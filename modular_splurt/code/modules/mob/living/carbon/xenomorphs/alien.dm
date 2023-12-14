///Handles modular code for Xenomorph features///
/mob/living/carbon/alien/verb/toggle_gender()
	set name = "Set Mob Gender"
	set desc = "Allows you to set your gender."
	set category = "IC"
	change_gender()

/mob/living/carbon/alien/ComponentInitialize() //SPLURT ADD: Xenomorph Flavortext by default
	AddElement(/datum/element/flavor_text/carbon, _name = "Flavor Text", _save_key = "flavor_text")
	AddElement(/datum/element/flavor_text/carbon/temporary, "", "Set Pose (Temporary Flavor Text)", "This should be used only for things pertaining to the current round!", _save_key = null)
	AddElement(/datum/element/flavor_text, _name = "OOC Notes", _addendum = "Put information on ERP/vore/lewd-related preferences here. THIS SHOULD NOT CONTAIN REGULAR FLAVORTEXT!!", _save_key = "ooc_notes", _examine_no_preview = TRUE)
	. = ..()
