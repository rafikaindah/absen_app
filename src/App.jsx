import { useEffect, useState } from 'react'

function App() {
  const [msg, setMsg] = useState('');

  useEffect(() => {
    fetch('http://localhost:4000/')
      .then(res => res.text())
      .then(setMsg)
  }, []);

  return (
    <h1>{msg || "Menunggu respon server..."}</h1>
  )
}

export default App;
