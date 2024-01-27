/datum/symptom/nano_boost
	name = "Nano-symbiosis"
	desc = "The virus reacts to nanites in the host's bloodstream by enhancing their replication cycle."
	stealth = 0
	resistance = 2
	stage_speed = 2
	transmittable = -1
	level = 6 //SPLURT EDIT: -1 to value: Makes this more common!
	severity = 0
	symptom_delay_min = 1
	symptom_delay_max = 1
	var/reverse_boost = FALSE
	threshold_desc = list(
		"Transmission 3" = "Increases the virus' growth rate while nanites are present.",
		"Stage Speed 5" = "Doubles the replication boost."
	)

/datum/symptom/nano_boost/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.properties["transmittable"] >= 3) //reverse boost //SPLURT EDIT: -2 to value
		reverse_boost = TRUE
	if(A.properties["stage_rate"] >= 5) //more nanites //SPLURT EDIT: -2 to value
		power = 2

/datum/symptom/nano_boost/Activate(datum/disease/advance/A)
	if(!..())
		return
	var/mob/living/carbon/M = A.affected_mob
	SEND_SIGNAL(M, COMSIG_NANITE_ADJUST_VOLUME, power)
	if(reverse_boost && SEND_SIGNAL(M, COMSIG_HAS_NANITES))
		if(prob(A.stage_prob))
			A.stage = min(A.stage + 1,A.max_stages)

/datum/symptom/nano_destroy
	name = "Silicolysis"
	desc = "The virus reacts to nanites in the host's bloodstream by attacking and consuming them."
	stealth = 0
	resistance = 4
	stage_speed = 5 //SPLURT EDIT: +6 to value (makes it so you cant use nanites!)
	transmittable = 3 //SPLURT EDIT: +2 to value (Makes it more worthwhile for thresholding reasons)
	level = 7
	severity = 0
	symptom_delay_min = 1
	symptom_delay_max = 1
	var/reverse_boost = FALSE
	threshold_desc = list(
		"Stage Speed 5" = "Increases the virus' growth rate while nanites are present.",
		"Resistance 7" = "Severely increases the rate at which the nanites are destroyed."
	)

/datum/symptom/nano_destroy/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.properties["stage_rate"] >= 5) //reverse boost
		reverse_boost = TRUE
	if(A.properties["resistance"] >= 7) //more nanites
		power = 3

/datum/symptom/nano_destroy/Activate(datum/disease/advance/A)
	if(!..())
		return
	var/mob/living/carbon/M = A.affected_mob
	SEND_SIGNAL(M, COMSIG_NANITE_ADJUST_VOLUME, -0.4 * power)
	if(reverse_boost && SEND_SIGNAL(M, COMSIG_HAS_NANITES))
		if(prob(A.stage_prob))
			A.stage = min(A.stage + 1,A.max_stages)
