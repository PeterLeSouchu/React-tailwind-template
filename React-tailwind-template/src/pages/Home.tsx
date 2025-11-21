function Home() {
  return (
    <div className="w-screen min-h-screen bg-linear-to-br from-indigo-50 via-white to-blue-50 flex flex-col justify-center items-center px-6 py-16">
      <div className="max-w-5xl w-full space-y-16">
        {/* Logos Section */}
        <div className="flex justify-center items-center gap-8 md:gap-12 flex-wrap">
          <div className="flex flex-col items-center gap-3 group">
            <div className="p-4 rounded-2xl bg-white shadow-lg group-hover:shadow-xl transition-shadow duration-300">
              <img
                src="/react.svg"
                alt="react logo"
                className="w-16 h-16 md:w-20 md:h-20"
              />
            </div>
          </div>
          <div className="flex flex-col items-center gap-3 group">
            <div className="p-4 rounded-2xl bg-white shadow-lg group-hover:shadow-xl transition-shadow duration-300">
              <img
                src="/vite.svg"
                alt="vite logo"
                className="w-16 h-16 md:w-20 md:h-20"
              />
            </div>
          </div>
          <div className="flex flex-col items-center gap-3 group">
            <div className="p-4 rounded-2xl bg-white shadow-lg group-hover:shadow-xl transition-shadow duration-300">
              <img
                src="/tailwind.png"
                alt="tailwind logo"
                className="w-16 h-16 md:w-20 md:h-20 object-contain"
              />
            </div>
          </div>
        </div>

        {/* Content Section */}
        <section className="space-y-8 text-center">
          <div className="space-y-4">
            <h1 className="font-nunito text-4xl md:text-5xl lg:text-6xl font-extrabold text-gray-800 leading-tight">
              Bienvenue sur le{' '}
              <span className="bg-linear-to-r from-blue-500 to-indigo-600 bg-clip-text text-transparent">
                React
              </span>
              -Tailwind-Template
            </h1>
            <div className="w-32 h-1 bg-linear-to-r from-transparent via-blue-400 to-transparent mx-auto"></div>
          </div>

          <div className="max-w-3xl mx-auto space-y-6">
            <p className="text-lg md:text-xl text-gray-600 leading-relaxed">
              Ce template React-Vite a pour but de vous faire gagner du temps en
              évitant de configurer vous-même votre projet. Il propose une
              configuration par défaut avec Tailwind / ESLint et vient s'ajouter
              à cela des fonctions et scripts utilitaires.
            </p>
          </div>

          <div className="pt-4">
            <p className="text-xl md:text-2xl font-bold bg-linear-to-r from-blue-500 to-indigo-600 bg-clip-text text-transparent">
              Bon code :)
            </p>
          </div>
        </section>
      </div>
    </div>
  );
}

export default Home;
