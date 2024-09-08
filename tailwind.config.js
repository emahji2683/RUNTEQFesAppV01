module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      colors: {
        'custom-green-body': '#4C878',
        'custom-green': '#82D9C4',
      },
      fontFamily: {
        'roboto': ['Roboto', 'sans-serif',"M PLUS Rounded 1c"],
        'mkpop': ['mkpop', 'sans-serif'],
        'ymg': ['ymg', 'sans-serif'],
        'ysi': ['ysi', 'sans-serif']
      },
    },
  },
}
