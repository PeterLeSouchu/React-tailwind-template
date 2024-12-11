/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{js,ts,jsx,tsx}'],
  theme: {
    extend: {
      fontFamily: {
        montserrat: ['Montserrat', 'sans-serif'],
        roboto: ['Roboto', 'sans-serif'],
        nunito: ['Nunito', 'sans-serif'],
      },
      backgroundImage: {
        'light-blue-green':
          'radial-gradient(circle at center, rgba(173, 216, 230, 0.4) 0%, rgba(34, 35, 37, 0) 30%), ' +
          'radial-gradient(circle at center, rgba(144, 238, 144, 0.3) 0%, rgba(34, 35, 37, 0) 40%), ' +
          'radial-gradient(circle at center, rgba(173, 216, 230, 0.2) 0%, rgba(34, 35, 37, 0) 50%)',
      },
    },
  },
  plugins: [],
};
