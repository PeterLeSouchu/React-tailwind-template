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

# Ask if Axios is needed
echo "Souhaitez-vous utiliser Axios dans votre projet ? (y/n)"
read -p "> " USE_AXIOS
USE_AXIOS=$(echo "$USE_AXIOS" | tr -d '[:space:]' | tr '[:upper:]' '[:lower:]')

if [[ "$USE_AXIOS" != "y" && "$USE_AXIOS" != "n" ]]; then
  print_error "❌ Réponse invalide. Veuillez répondre par 'y' ou 'n'."
  rm -rf "$TARGET_DIRECTORY"
  exit 1
fi

# Ask if TanStack React Query is needed (only if Axios is yes)
USE_REACT_QUERY="n"
if [[ "$USE_AXIOS" == "y" ]]; then
  echo "Souhaitez-vous utiliser TanStack React Query dans votre projet ? (y/n)"
  read -p "> " USE_REACT_QUERY
  USE_REACT_QUERY=$(echo "$USE_REACT_QUERY" | tr -d '[:space:]' | tr '[:upper:]' '[:lower:]')
  
  if [[ "$USE_REACT_QUERY" != "y" && "$USE_REACT_QUERY" != "n" ]]; then
    print_error "❌ Réponse invalide. Veuillez répondre par 'y' ou 'n'."
    rm -rf "$TARGET_DIRECTORY"
    exit 1
  fi
fi

print_info "→ Copie des dossiers et des fichiers du template"
shopt -s extglob
rsync -av --quiet --exclude ".git" --exclude "node_modules" --exclude "src/utils" \
  React-tailwind-template/ "$TARGET_DIRECTORY"

if [ $? -eq 0 ]; then
  print_success "✓ Le modèle a été copié"
else
  print_error "❌ Impossible de copier."
  exit 1
fi

# Configure main.tsx based on React Router choice
if [[ "$USE_REACT_ROUTER" == "y" ]]; then
  print_info "→ React Router activée"
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
import Home from './pages/Home';

const root = ReactDOM.createRoot(
  document.getElementById('root') as HTMLElement
);

const router = createBrowserRouter(
  createRoutesFromElements(
    <Route path="/" element={<Home />} errorElement={<NotFound />} />
  )
);

root.render(
  <React.StrictMode>
    <RouterProvider router={router} />
  </React.StrictMode>
);
EOF
else
  print_info "→ React Router désactivée"
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

  # Move Home.tsx to components/ and rename to App.tsx, also rename the component
  if [ -f "$TARGET_DIRECTORY/src/pages/Home.tsx" ]; then
    mv "$TARGET_DIRECTORY/src/pages/Home.tsx" "$TARGET_DIRECTORY/src/components/App.tsx"
    # Rename the component from Home to App
    sed -i '' 's/function Home()/function App()/g' "$TARGET_DIRECTORY/src/components/App.tsx"
    sed -i '' 's/export default Home;/export default App;/g' "$TARGET_DIRECTORY/src/components/App.tsx"
    print_success "✓ Composant 'Home' déplacé et renommé en 'App.tsx'"
    rm -rf "$TARGET_DIRECTORY/src/pages/"
  else
    print_error "❌ Le fichier 'src/pages/Home.tsx' n'existe pas, impossible de le déplacer."
    exit 1
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

# Install and configure Axios if needed
if [[ "$USE_AXIOS" == "y" ]]; then
  print_info "→ Installation d'Axios"
  cd "$TARGET_DIRECTORY"
  pnpm add axios
  if [ $? -eq 0 ]; then
    print_success "✓ Axios a été installé"
    
    # Create axios instance in utils
    print_info "→ Création de l'instance Axios"
    # Ensure the utils directory exists
    mkdir -p src/utils
    cat <<'EOF' > src/utils/axios.ts
import axios from 'axios';

const apiClient = axios.create({
  baseURL: import.meta.env.VITE_API_BASE_URL || 'http://localhost:3000/api',
  timeout: 10000,
  withCredentials: true,
  headers: {
    'Content-Type': 'application/json',
  },
});

// Request interceptor
apiClient.interceptors.request.use(
  (config) => {
    // Vous pouvez ajouter un token d'authentification ici
    // const token = localStorage.getItem('token');
    // if (token) {
    //   config.headers.Authorization = `Bearer ${token}`;
    // }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// Response interceptor
apiClient.interceptors.response.use(
  (response) => {
    return response;
  },
  (error) => {
    // Vous pouvez gérer les erreurs ici de manière centralisée
    // if (error.response?.status === 401) {
    //   // Rediriger vers la page de connexion
    // }
    return Promise.reject(error);
  }
);

export default apiClient;
EOF
    if [ -f "src/utils/axios.ts" ]; then
      print_success "✓ Instance Axios créée dans src/utils/axios.ts"
    else
      print_error "❌ Erreur lors de la création du fichier axios.ts"
    fi
  else
    print_error "❌ L'installation d'Axios a échoué."
  fi
fi

# Install and configure TanStack React Query if needed
if [[ "$USE_REACT_QUERY" == "y" ]]; then
  print_info "→ Installation de TanStack React Query"
  cd "$TARGET_DIRECTORY"
  pnpm add @tanstack/react-query
  if [ $? -eq 0 ]; then
    print_success "✓ TanStack React Query a été installé"
    
    # Configure QueryClientProvider in main.tsx
    print_info "→ Configuration du QueryClientProvider"
    cd "$TARGET_DIRECTORY"
    
    # Read current main.tsx and modify it
    if [[ "$USE_REACT_ROUTER" == "y" ]]; then
      # With React Router
      cat <<'EOF' > src/main.tsx
import React from 'react';
import ReactDOM from 'react-dom/client';
import './styles/index.css';
import {
  createBrowserRouter,
  createRoutesFromElements,
  Route,
  RouterProvider,
} from 'react-router-dom';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import NotFound from './pages/NotFound';
import Home from './pages/Home';

const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      refetchOnWindowFocus: false,
      retry: 1,
    },
  },
});

const root = ReactDOM.createRoot(
  document.getElementById('root') as HTMLElement
);

const router = createBrowserRouter(
  createRoutesFromElements(
    <Route path="/" element={<Home />} errorElement={<NotFound />} />
  )
);

root.render(
  <React.StrictMode>
    <QueryClientProvider client={queryClient}>
      <RouterProvider router={router} />
    </QueryClientProvider>
  </React.StrictMode>
);
EOF
    else
      # Without React Router
      cat <<'EOF' > src/main.tsx
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './components/App';
import './styles/index.css';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';

const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      refetchOnWindowFocus: false,
      retry: 1,
    },
  },
});

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <QueryClientProvider client={queryClient}>
      <App />
    </QueryClientProvider>
  </React.StrictMode>
);
EOF
    fi
    
    if [ -f "src/main.tsx" ]; then
      print_success "✓ QueryClientProvider configuré dans src/main.tsx"
    else
      print_error "❌ Erreur lors de la configuration du QueryClientProvider"
    fi
  else
    print_error "❌ L'installation de TanStack React Query a échoué."
  fi
fi

print_success "→ Votre projet '$TARGET_DIRECTORY' est prêt, vous le trouverez à la racine de ce dossier"
