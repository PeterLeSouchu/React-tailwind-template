function App() {
  return (
    <div className="bg-light-blue-green w-screen min-h-screen flex justify-center items-center flex-col gap-10">
      <div className="flex justify-center items-center gap-4 w-3/6">
        <img src="/react.svg" alt="react logo" className="w-1/6 min-w-20" />
        <img src="/vite.svg" alt="vite logo" className="w-1/6 min-w-20" />
        <img
          src="/tailwind.png"
          alt="tailwind logo"
          className="w-1/6 min-w-20"
        />
      </div>
      <section className="App-header">
        <h1 className="font-nunito text-4xl text-center font-extrabold text-gray-700">
          Bienvenue sur le <span className="text-blue-400">React</span>
          -Tailwind-Template
        </h1>
        <p className="w-4/6 text-center text-gray-500 mx-auto my-10 text-xl">
          Ce template React-Vite a pour but de vous faire gagner du temps et
          propose donc une configuration par défaut avec tailwind / eslint,
          vient s'ajouter à ça des fonctions/scripts utilitaires.
        </p>
        <p className="text-center font-bold text-blue-500 text-xl">
          Bon code :)
        </p>
      </section>
    </div>
  );
}

export default App;
