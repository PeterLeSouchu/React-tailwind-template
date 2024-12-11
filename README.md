# 📦 REACT-TAILWIND-TEMPLATE

### 🎉 Bienvenue, vous trouverez ici un template react-vite préconfiguré avec tailwind, eslint et quelques fonctions/scripts utiles.

#### L'objectif ici va être de copié tout ce qui se trouve dans le template "React-tailwind-template" afin de le coller dans un dossier, dossier qui vous servira à démarer un nouveau projet. Ce template a donc pour but de vous faire gagner du temps et de vous evitez à devoir configurer eslint/tailwind...

_Pour cela il comporte :_

- ✍️ Une configuration Tailwind CSS avec 3 fonts par défaut.
- 📅 Une fonction "FormDate" qui permet de convertir un timestamp en date.
- 🔄 Un composant Loader par défaut (spinner).
- ⬆️ Une fonction "ScrollToTop" permettant de scroll en haut de page (utile quand on utilise react-router).
- 🧹 Un script permettant d'effacer tous les console.log
- ✅ Un script permettant de vérifier la présence du fichier .env
  (s'il y en a un) dans le fichier .gitignore avant le commit, ce pour éviter de rendre public des donnés privées (car un oubli arrive très vite et ça peut être compliqué d'effacer un fichier .env de tous nos commit sur github).

Pour créez un template, il vous faudra d'abord installer pnpm si ce n'est pas déja fait car il fonctionne avec ce gestionnaire de paquets :

```bash
npm i -g pnpm
```

Une fois cela fait, clonez ce repos :

```bash
git clone git@github.com:PeterLeSouchu/React-tailwind-template.git
```

Puis ouvrez le sur votre ordinateur.

Mettez vous à la racine du projet, c'est à dire au dossier contenant le dossier intitulé "Reac-tailwind-template". C'est tès important de se mettre à la racine et non pas dans le dossier précédemment cité, sinon le clonage ne fonctionnera pas.

Pour en être sur faite cette commande :

```bash
ls
```

Si vous voyez "React-tailwind-template" alors vous êtes bien positionné.
Après cela lancez la commande :

```bash
 ./React-tailwind-template/bin/install.sh
```

Cela permettra de lancer le script situé dans le template.
Il vous sera demandé deux choses :

- Le nom que vous souhaitez donner à votre projet
- Si vous souhaitez utiliser react-router

Après avoir répondu à ces deux questions, votre projet sera créé à la racine du dossier principal, il ne vous restera plus qu'a le déplacer si vous le souhaitez, afin de mieux vous organiser, et vous pourrez commencerà travailler dessus.
