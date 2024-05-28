// Set the seed for random number generation
srand(Time()); // Assuming 'time()' returns the current time to use as a seed

// Generate a random number between 0 and 24, then add 1 to make it 1 to 25
local random_number = (rand() % 25) + 1;

// Form the command string
local command = format("sayrandomfact" + random_number);

// Execute the command
// Replace 'ExecuteCommand' with the actual Portal 2 command execution function
if (random_number <= 9) {
	SendToConsole("exec " + "sayrandomfact" + "0" + random_number);
} else {
	SendToConsole("exec " + command);
}