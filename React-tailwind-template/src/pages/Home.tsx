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
      <header className="App-header">
        <h1 className="font-nunito text-4xl text-center font-extrabold text-gray-700">
          Bienvenue sur le <span className="text-blue-400">React</span>
          -Tailwind-Template
        </h1>
        <p className="w-4/6 text-center text-gray-500 mx-auto my-10 text-xl">
          Ce template a pour but de vous faire gagner du temps et propose donc
          une configuration par défaut avec tailwind et eslint, vient s'ajouter
          à ça des fonctions/script utilitaires.
        </p>
        <p className="w-4/6 text-center mx-auto my-10 text-lg text-gray-700">
          Vous trouverez sur ce dernier :
        </p>
        <div className="mx-auto w-3/5 min-w-96">
          <ul className="text-left px-4">
            <li>- Une configuration tailwind, avec des fonts par défaut</li>
            <li>
              - Une fonction "formatDate" qui permet de convertir un timestamp
              en date
            </li>
            <li> - Un composant Loader</li>
            <li>
              - Un composant ScrollToTop permettant de scroll a chaque debut de
              page lors du changement de page
            </li>
            <li>- Un script permettant d'effacer tous les console.log</li>
            <li>
              - Un script permettant de vérifier la présence du fichier .env
              (s'il y en a un) dans le fichier .gitignore lors du commit
            </li>
          </ul>
        </div>
      </header>
    </div>
  );
}

export default App;
