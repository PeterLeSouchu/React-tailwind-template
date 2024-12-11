# 📦 REACT-TAILWIND-TEMPLATE

### 🎉 Bienvenue, vous trouverez ici un template react-vite préconfiguré avec tailwind, eslint et quelques fonctions/scripts utiles.

#### L'objectif ici va être de copié tout ce qui se trouve dans le template préconfiguré "React-tailwind-template" afin de le coller dans un dossier, dossier qui vous servira à démarer un nouveau projet. Ce template a donc pour but de vous faire gagner du temps et de vous evitez à devoir configurer eslint/tailwind... dans votre nouveau projet.

_Pour cela il comporte :_

- ✍️ Une configuration Tailwind CSS avec 3 fonts par défaut.
- 📅 Une fonction "FormDate" qui permet de convertir un timestamp en date.
- 🔄 Un composant Loader par défaut (spinner).
- ⬆️ Une fonction "ScrollToTop" permettant de scroll en haut de page (utile quand on utilise react-router).
- 🧹 Un script permettant d'effacer tous les console.log
- ✅ Un script permettant de vérifier la présence du fichier .env
  (s'il y en a un) dans le fichier .gitignore avant le commit, ce pour éviter de rendre public des donnés privées (car un oubli arrive très vite et ça peut être compliqué d'effacer un fichier .env de tous nos commit sur github).
- 📏 Une configuration ES-Lint.

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

Après avoir répondu à ces deux questions, votre projet sera créé à la racine du dossier principal, il ne vous restera plus qu'a le déplacer si vous le souhaitez, afin de mieux vous organiser, et vous pourrez commencer à travailler dessus.

⚠️ Attention lors de la création du dossier, le script initialise le projet avec un "git init" pour mettre en place une configuration qui permet de valider la présence du fichier '.env' dans le fichier '.gitignore' ! Ainsi si vous souahitez rattacher votre projet à un repo Github inutile faire un git init, il est déjà fait pour vous. ⚠️

Voici la configuration mise en place pour vérifier la présence du fichier '.env' :

```bash
# Configure Git hook
print_info "→ Configuration du hook pre-commit"
cat <<EOF > .git/hooks/pre-commit
#!/bin/bash
if ! grep -qxF '.env' .gitignore; then
 echo "❌ Le fichier '.env' n'est pas dans .gitignore !"
  echo "→ ⚠⚠⚠⚠ Ajoutez '.env' dans le fichier '.gitignore' pour éviter de rendre public des informations sensibles. ⚠⚠⚠⚠"
  echo "→ ⚠⚠⚠⚠ Puis faites la commande suivante : 'git rm --cached .env' sinon le .env sera push ⚠⚠⚠⚠"
  echo "→ ⚠⚠⚠⚠ Ensuite vous pouvez de nouveau commit ⚠⚠⚠⚠"
  exit 1
fi
exit 0
EOF
chmod +x .git/hooks/pre-commit
print_success "✓ Hook pre-commit configuré"
```

Ce dernier se situe dans '.git/hooks/pre-commit' et intervient avant chaque commit.
