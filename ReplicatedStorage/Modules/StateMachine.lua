-- @ScriptType: ModuleScript
--[[
	Henry Baber 2025
	State Machine 
]]--


export type State = {
	name : string;
	Completed : () -> ();
	Enter : (string) -> (boolean);
}


local StateMachine = {}
StateMachine.__index = StateMachine


function StateMachine.New()
		
	local self = setmetatable({
		States = {};
		CurrentState = "";
	}, StateMachine)
	
	return self
		
end

function StateMachine:DefineStates(states : {State})
	
	for _, state in states do
		
		self.States[state.name] = state
		
	end 
	
	self.CurrentState = states[1].name
	
end

function StateMachine:SetState(state_name : string)
	
	local old_state_name = self.CurrentState
	local old_state : State = self.States[old_state_name]
	local next_state : State = self.States[state_name]
	
	if not next_state then return end -- guard clause
	
	-- check if transition is valid
	local valid = true
	if next_state.Enter then
		next_state.Enter(old_state_name)
	end
	
	-- perform transition
	if valid then
		self.CurrentState = state_name
		
		if old_state.Completed then
			
			old_state.Completed()
		end
	else
		
		self.CurrentState = old_state_name
	end
	
end

return StateMachine