/** @type {import('tailwindcss').Config} */
module.exports = {
    content: [
        "./frontend/**/*.{html,js}",
    ],
    theme: {
        extend: {
            screens: {
                'xs': '475px',
            },
            container: {
                center: true,
                padding: {
                    DEFAULT: '1rem',
                    sm: '2rem',
                    lg: '4rem',
                    xl: '5rem',
                    '2xl': '6rem',
                },
            },
        },
    },
    plugins: [require("daisyui")],
    daisyui: {
        themes: ["light", "cupcake"],
        darkTheme: "light",
        base: true,
        styled: true,
        utils: true,
        prefix: "",
        logs: false,
    },
} 