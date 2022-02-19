module.exports = {
  content: ['../Sources/**/*.swift'],
  theme: {
    extend: {
      typography: {
        DEFAULT: {
          css: {
            a: {
              'text-underline-offset': '4px', 
            },
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
        base: {
          css: {
            h1: {
              fontSize: '1.875rem',
            },
            h2: {
              fontSize: '1.5rem',
            },
            h3: {
              fontSize: '1.25rem',
            },
            h4: {
              fontSize: '1.125rem',
            },
            h5: {
              fontSize: '1rem',
              fontWeight: '600',
            },
            h6: {
              fontSize: '0.875rem',
              fontWeight: '600',
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
