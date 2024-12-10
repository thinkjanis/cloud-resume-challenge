// Get system dark mode preference
const darkModeMediaQuery = window.matchMedia('(prefers-color-scheme: dark)');

// Check if user has a saved preference
let userPreference = localStorage.getItem('theme');

// Function to update theme
const updateTheme = (e) => {
    if (userPreference === 'dark' || (!userPreference && e.matches)) {
        document.documentElement.classList.add('dark');
    } else {
        document.documentElement.classList.remove('dark');
    }
};

// Initial check
updateTheme(darkModeMediaQuery);

// Listen for system changes (only if no user preference)
darkModeMediaQuery.addEventListener('change', (e) => {
    if (!userPreference) {
        updateTheme(e);
    }
});

// Toggle function
function toggleTheme() {
    const isDark = document.documentElement.classList.contains('dark');
    userPreference = isDark ? 'light' : 'dark';
    localStorage.setItem('theme', userPreference);
    updateTheme(darkModeMediaQuery);
}

// Function to fetch and update view count
async function updateViewCount() {
    try {
        const response = await fetch('<BACKEND_API_URL>');
        const data = await response.json();
        document.getElementById('ViewCount').textContent = data.views;
    } catch (error) {
        console.error('Error fetching view count:', error);
    }
}

// Call updateViewCount when page loads
document.addEventListener('DOMContentLoaded', updateViewCount);