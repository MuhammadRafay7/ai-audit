// Test Case 1: Missing Error Handling
// Known issue: Missing error handling on async operation

async function fetchUserData(userId) {
  const response = await fetch(`/api/users/${userId}`);
  const data = response.json();
  return data;
}

// Known issue: Missing error handling on promise
function loadConfig() {
  return fetch('/config.json')
    .then(r => r.json());
}
