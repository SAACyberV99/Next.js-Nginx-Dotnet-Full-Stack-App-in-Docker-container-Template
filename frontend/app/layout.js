import './globals.css'

export const metadata = {
  title: 'Next.js + .NET Docker App',
  description: 'Hello World app with Next.js frontend and .NET backend',
}

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body>
        {children}
      </body>
    </html>
  )
}
