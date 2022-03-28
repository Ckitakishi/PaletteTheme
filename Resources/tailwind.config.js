module.exports = {
  content: ['../Sources/**/*.swift'],
  theme: {
    extend: {
      screens: {
        'ssm': '386px',
      },
      typography: {
        DEFAULT: {
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
            a: {
              'text-underline-offset': '4px', 
            },
            pre: {
              backgroundColor: '#161613',
            },
            code: {
              fontWeight: '400',
            },
            'p code': {
              color: '#f92672',
            },
            'code::before': {
              content: '',
            },
            'code::after': {
              content: '',
            },
          },
        },
        invert: {
          css: {
            pre: {
              backgroundColor: '#2a2a2a',
            },
            'p code': {
              color: '#e6db74',
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
