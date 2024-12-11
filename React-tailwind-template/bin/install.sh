#!/bin/bash

# Colors for messages
YELLOW="\033[38;5;226m"
BLUE="\033[38;5;87m"
GREEN="\033[0;32m"
RED="\033[38;5;167m"
NC="\033[0m" # Default color (to reset color)

# Functions for messages
print_info() {
  if [ -z $2 ]; then
    echo
  fi
  echo -e "${YELLOW}$1${NC} \c"
}

print_success() {
  if [ -z $2 ]; then
    echo
  fi
  echo -e "${GREEN}$1${NC}"
}

print_error() {
  if [ -z $2 ]; then
    echo
  fi
  echo -e "${RED}$1${NC}"
}

print_title() {
  if [ -z $2 ]; then
    echo
  fi
  echo -e "${BLUE}$1${NC}"
}

print_title "                                                                                                    "
print_title "    %%%%%%%%%%   %%%%%%   %% %     % %%   %%%%%%%%     %%         %%%%%%%%%%    %%%%%%%%%%   %%%%%% " 0            
print_title "        %%       %%       %% % % % % %%   %%      %%   %%         %%      %%        %%       %%     " 0
print_title "        %%       %%%%     %%   % %   %%   %%%%%%%%%    %%         %%%%%%%%%%        %%       %%%%   " 0
print_title "        %%       %%       %%         %%   %%           %%         %%      %%        %%       %%     " 0
print_title "        %%       %%%%%%   %%         %%   %%           %%%%%%%%   %%      %%        %%       %%%%%% " 0    
print_title "                                                                                                    "

echo
print_info "👐 Bienvenue dans le React-Tailwind-Template 👐"
echo

# Ask for project name
echo "Pour commencer, veuillez entrer le nom de votre projet :"
ASK=$(print_success ">" 0)
read -p "$ASK " TITLE_VALUE

if [ -z "$TITLE_VALUE" ]; then
  print_error "❌ Le nom de votre projet ne peut pas être vide."
  exit 1
fi

TARGET_DIRECTORY="$TITLE_VALUE"
mkdir "$TARGET_DIRECTORY"

# Ask if React Router is needed
echo "Souhaitez-vous utiliser React Router dans votre projet ? (y/n)"
read -p "> " USE_REACT_ROUTER
USE_REACT_ROUTER=$(echo "$USE_REACT_ROUTER" | tr -d '[:space:]' | tr '[:upper:]' '[:lower:]')

if [[ "$USE_REACT_ROUTER" != "y" && "$USE_REACT_ROUTER" != "n" ]]; then
  print_error "❌ Réponse invalide. Veuillez répondre par 'y' ou 'n'."
  rm -rf "$TARGET_DIRECTORY"
  exit 1
fi

print_info "→ Copie des dossiers et des fichiers du template"
shopt -s extglob
rsync -av --quiet --exclude "bin" --exclude ".git" --exclude "node_modules" \
  ./React-tailwind-template/ "$TARGET_DIRECTORY"

if [ $? -eq 0 ]; then
  print_success "✓ Le modèle a été copié"
else
  print_error "❌ Impossible de copier."
  exit 1
fi

# Configure main.tsx based on React Router choice
if [[ "$USE_REACT_ROUTER" == "y" ]]; then
  print_info "→ Utilisation de React Router activée"
  cat <<EOF > "$TARGET_DIRECTORY/src/main.tsx"
import React from 'react';
import ReactDOM from 'react-dom/client';
import './styles/index.css';
import {
  createBrowserRouter,
  createRoutesFromElements,
  Route,
  RouterProvider,
} from 'react-router-dom';
import NotFound from './pages/NotFound';
import App from './pages/App';

const root = ReactDOM.createRoot(
  document.getElementById('root') as HTMLElement
);

const router = createBrowserRouter(
  createRoutesFromElements(
    <Route path="/" element={<App />} errorElement={<NotFound />} />
  )
);

root.render(
  <React.StrictMode>
    <RouterProvider router={router} />
  </React.StrictMode>
);
EOF
else
  print_info "→ Utilisation de React Router désactivée"
  cat <<EOF > "$TARGET_DIRECTORY/src/main.tsx"
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './components/App';
import './styles/index.css';

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
EOF

  # Move Home.tsx to components/ and rename to App.tsx
  if [ -f "$TARGET_DIRECTORY/src/pages/Home.tsx" ]; then
    mv "$TARGET_DIRECTORY/src/pages/Home.tsx" "$TARGET_DIRECTORY/src/components/App.tsx"
    print_success "✓ Composant 'Home' déplacé et renommé en 'App.tsx'"
    rm -rf "$TARGET_DIRECTORY/src/pages/"
  else
    print_error "❌ Le fichier 'src/pages/Home.tsx' n'existe pas, impossible de le déplacer."
    exit 1
  fi

  # Remove ScrollToTop.tsx (reserve for react router)
  FILE="ScrollToTop.tsx"
  if [ -f "$TARGET_DIRECTORY/src/components/$FILE" ]; then
    rm "$TARGET_DIRECTORY/src/components/$FILE"
    print_success "✓ Fichier '$FILE' supprimé"
  else
    print_error "❌ Fichier '$FILE' introuvable"
  fi

  # Remove the react-router-dom package if not needed
  print_info "→ Désinstallation de 'react-router-dom'"
  cd "$TARGET_DIRECTORY"
  pnpm remove react-router-dom
  print_success "✓ 'react-router-dom' désinstallé"
fi

# Initialize Git
cd "$TARGET_DIRECTORY"
print_info "→ Initialisation du dépôt Git"
git init
print_success "✓ Dépôt Git initialisé"

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

# Install dependencies with PNPM
print_info "→ Installation des dépendances avec PNPM"
pnpm install
if [ $? -eq 0 ]; then
  print_success "✓ Les dépendances ont été installées"
else
  print_error "❌ L'installation des dépendances a échoué."
  exit 1
fi

print_success "→ Votre projet '$TARGET_DIRECTORY' est prêt, vous le trouverez à la racine de ce dossier"
