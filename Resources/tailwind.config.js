module.exports = {
  content: ['../Sources/**/*.swift'],
  theme: {
    extend: {
      typography: {
        DEFAULT: {
          css: {
            code: {
              fontWeight: '400',
            },
            'code::before': {
              content: '',
            },
            'code::after': {
              content: '',
            },
          },
        },
    },
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
  ],
}
