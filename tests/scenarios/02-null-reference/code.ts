// Test Case 2: Null Reference
// Known issue: Missing null checks before property access

function getUserProfile(userId: string) {
  const user = fetchUser(userId);
  return user.profile.name;  // Error: user might be null, profile might be null
}

function getCompanyName(employee: Employee) {
  const company = employee.company;
  console.log(company.name);  // Error: company could be null
}

interface Employee {
  name: string;
  company?: Company;
}

interface Company {
  name: string;
}
