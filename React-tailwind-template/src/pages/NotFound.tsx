function NotFound() {
  return (
    <div className="flex flex-col items-center justify-center min-h-screen bg-gradient-to-br from-slate-50 via-blue-50 to-indigo-50">
      <div className="text-center px-6 py-16 space-y-8 max-w-2xl">
        <div className="space-y-4">
          <h1 className="text-8xl md:text-9xl font-montserrat font-bold bg-gradient-to-r from-gray-700 via-gray-600 to-gray-700 bg-clip-text text-transparent">
            404
          </h1>
          <div className="w-24 h-1 bg-gradient-to-r from-transparent via-blue-400 to-transparent mx-auto"></div>
        </div>

        <p className="text-xl md:text-2xl font-montserrat text-gray-700 leading-relaxed">
          Oops, vous vous êtes perdu
        </p>
        <p className="text-base md:text-lg font-montserrat text-gray-500 max-w-md mx-auto">
          La page que vous recherchez n'existe pas ou a été déplacée.
        </p>

        <div className="pt-6">
          <a
            href="/"
            className="inline-block px-8 py-4 bg-gradient-to-r from-blue-500 to-indigo-600 text-white font-semibold rounded-full shadow-lg shadow-blue-500/30 transition-all duration-300 hover:scale-105 hover:shadow-xl hover:shadow-blue-500/40"
          >
            Retour à l&apos;accueil
          </a>
        </div>
      </div>
    </div>
  );
}

export default NotFound;
