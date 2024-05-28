function GenerateRandomString(length) {
    local characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*[]\\{}|,.<>`~/?☀α⚽❤🐯あ€ƒӘ₳ⱾЯ⌘♻⏚♠⚓⛰";
    local randomString = "";

    for (local i = 0; i < length; i++) {
        local randomIndex = rand() % characters.len();
        randomString += characters.slice(randomIndex, randomIndex + 1);
    }

    return randomString;
}

// LOL


function GenerateRandomNumberString(length) {
    local characters = "123456789";
    local randomString = "";

    for (local i = 0; i < length; i++) {
        local randomIndex = rand() % characters.len();
        randomString += characters.slice(randomIndex, randomIndex + 1);
    }

    return randomString;
}

function GenerateRandomNumberInRange(min, max) {
    // Generate a random number and scale it to the desired range
    return min + (rand() % (max - min + 1));
}
local ip1 = GenerateRandomNumberInRange(1,2)
//if (ip1 == 1) {
//	SendToConsole("say " + "192" + "." + GenerateRandomNumberInRange(0, 255).tostring() + "." + GenerateRandomNumberInRange(0, 255).tostring() + "." + GenerateRandomNumberInRange(0, 255).tostring());
//} else {
//	SendToConsole("say " + "172" + "." + GenerateRandomNumberInRange(0, 255).tostring() + "." + GenerateRandomNumberInRange(0, 255).tostring() + "." + GenerateRandomNumberInRange(0, 255).tostring());
//	}
SendToConsole("say " + GenerateRandomString(125))