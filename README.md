# 💬 Flugo - Chat em Tempo Real

Aplicativo de chat em tempo real desenvolvido em Flutter com Firebase Realtime Database e Firebase Authentication.

## 📋 Sobre o Projeto

O Flugo é um aplicativo de mensagens instantâneas que permite comunicação em tempo real entre múltiplos usuários. O projeto foi desenvolvido seguindo boas práticas de arquitetura, com código organizado, modular e sustentável.

### ✨ Funcionalidades

- 🔐 **Autenticação de Usuários**
  - Cadastro com email, nome e senha
  - Login com email e senha
  - Validação de formulários
  - Mensagens de erro em português
  - Persistência de sessão

- 💬 **Chat em Tempo Real**
  - Envio e recebimento de mensagens instantâneas
  - Mensagens com texto, nome do usuário e horário
  - Ordenação cronológica das mensagens
  - Diferenciação visual entre mensagens próprias e de outros usuários
  - Scroll automático para a última mensagem
  - Atualização automática quando novas mensagens são adicionadas

- 🎨 **Design Moderno**
  - Interface limpa e intuitiva
  - Padrão de cores consistente (verde primário)
  - Cantos arredondados
  - Feedback visual (loading states, animações)
  - Responsivo e adaptável

## 🏗️ Estrutura de Pastas

```
flugo_app/
├── lib/
│   ├── core/
│   │   ├── constants/
│   │   │   └── app_colors.dart              # Cores do aplicativo
│   │   └── theme/
│   │       └── app_theme.dart                # Tema customizado
│   │
│   ├── features/
│   │   ├── auth/                             # Feature de Autenticação
│   │   │   └── presentation/
│   │   │       ├── providers/
│   │   │       │   └── auth_provider.dart    # Gerenciamento de estado (auth)
│   │   │       ├── screens/
│   │   │       │   ├── login_screen.dart     # Tela de login
│   │   │       │   └── register_screen.dart  # Tela de cadastro
│   │   │       └── widgets/
│   │   │           ├── auth_button.dart      # Botão reutilizável
│   │   │           └── auth_text_field.dart  # Campo de texto reutilizável
│   │   │
│   │   └── chat/                             # Feature de Chat
│   │       ├── data/
│   │       │   └── models/
│   │       │       └── message_model.dart    # Modelo de dados da mensagem
│   │       └── presentation/
│   │           ├── providers/
│   │           │   └── chat_provider.dart    # Gerenciamento de estado (chat)
│   │           ├── screens/
│   │           │   └── chat_screen.dart      # Tela principal do chat
│   │           └── widgets/
│   │               └── message_bubble.dart   # Widget da bolha de mensagem
│   │
│   ├── firebase_options.dart                 # Configurações do Firebase
│   └── main.dart                             # Ponto de entrada do app
│
├── android/                                  # Código nativo Android
├── ios/                                      # Código nativo iOS
├── web/                                      # Suporte web
├── pubspec.yaml                              # Dependências do projeto
└── README.md                                 # Este arquivo
```

### 📐 Arquitetura

O projeto segue uma arquitetura baseada em **features** (funcionalidades), onde cada feature é organizada em camadas:

- **`core/`**: Recursos compartilhados (tema, cores, utilitários)
- **`features/`**: Funcionalidades do app (auth, chat)
  - **`data/`**: Modelos e fontes de dados
  - **`presentation/`**: UI, providers (state management) e widgets

**Gerenciamento de Estado**: Provider (ChangeNotifier)

**Padrão de Design**: Separation of Concerns, Single Responsibility Principle

## 🚀 Como Executar o Projeto

### Pré-requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (versão 3.11.0 ou superior)
- [Android Studio](https://developer.android.com/studio) ou [Xcode](https://developer.apple.com/xcode/) (para iOS)
- Conta no [Firebase](https://firebase.google.com/)
- Git

### Passo a Passo

1. **Clone o repositório**
   ```bash
   git clone <URL_DO_REPOSITORIO>
   cd flugo_app
   ```

2. **Instale as dependências**
   ```bash
   flutter pub get
   ```

3. **Configuração do Firebase** (se necessário)
   
   O projeto já está configurado com Firebase, mas caso precise reconfigurar:
   
   ```bash
   # Instale o FlutterFire CLI
   dart pub global activate flutterfire_cli
   
   # Configure o Firebase
   flutterfire configure
   ```

4. **Execute o aplicativo**
   ```bash
   # Para Android
   flutter run
   
   # Para iOS (somente em macOS)
   flutter run -d ios
   
   # Para Web
   flutter run -d chrome
   ```

## 📱 Compilar e Gerar APK para Android

### Opção 1: APK para Teste (Debug)

Para gerar um APK de debug para testes:

```bash
flutter build apk --debug
```

O APK será gerado em: `build/app/outputs/flutter-apk/app-debug.apk`

### Opção 2: APK de Produção (Release)

Para gerar um APK otimizado para produção:

```bash
flutter build apk --release
```

O APK será gerado em: `build/app/outputs/flutter-apk/app-release.apk`

### Opção 3: APK Split por ABI (Tamanho Reduzido)

Para gerar APKs separados por arquitetura (arquivos menores):

```bash
flutter build apk --split-per-abi
```

Os APKs serão gerados em `build/app/outputs/flutter-apk/`:
- `app-armeabi-v7a-release.apk` (dispositivos ARM 32-bit)
- `app-arm64-v8a-release.apk` (dispositivos ARM 64-bit - mais comum)
- `app-x86_64-release.apk` (emuladores e alguns tablets)

### Opção 4: App Bundle (Recomendado para Google Play Store)

Para publicar na Play Store, use o App Bundle:

```bash
flutter build appbundle --release
```

O bundle será gerado em: `build/app/outputs/bundle/release/app-release.aab`

### 📲 Instalar o APK no Dispositivo

Após gerar o APK, você pode instalá-lo:

**Via USB:**
```bash
flutter install
```

**Manualmente:**
1. Copie o arquivo APK para o dispositivo Android
2. Abra o arquivo no dispositivo
3. Permita instalação de fontes desconhecidas (se necessário)
4. Instale o aplicativo

### ⚙️ Configurações Adicionais para Release

Antes de gerar o APK de produção, configure:

1. **Nome do App** em `android/app/src/main/AndroidManifest.xml`:
   ```xml
   <application
       android:label="Flugo"
       ...>
   ```

2. **Ícone do App**: Substitua os ícones em `android/app/src/main/res/mipmap-*/`

3. **Versão** no `pubspec.yaml`:
   ```yaml
   version: 1.0.0+1
   ```

4. **Assinatura** (para produção): Configure em `android/app/build.gradle`

## 🛠️ Tecnologias Utilizadas

- **Flutter** (3.11.0+) - Framework de desenvolvimento
- **Dart** - Linguagem de programação
- **Firebase Core** (3.15.2) - SDK base do Firebase
- **Firebase Authentication** (5.7.0) - Autenticação de usuários
- **Firebase Realtime Database** (11.3.10) - Banco de dados em tempo real
- **Provider** (6.1.5) - Gerenciamento de estado
- **Intl** (0.19.0) - Formatação de datas e internacionalização

## 🧪 Testes Automatizados

O projeto inclui testes automatizados para garantir qualidade e confiabilidade:

### Executar os Testes

```bash
# Todos os testes
flutter test

# Com cobertura de código
flutter test --coverage

# Teste específico
flutter test test/models/message_model_test.dart
```

### Cobertura de Testes

- ✅ **35 testes** implementados
- ✅ **Message Model**: Testes completos de serialização e lógica
- ✅ **MessageBubble Widget**: Testes de UI e comportamento
- ✅ **AuthButton Widget**: Testes de interação e estados
- ✅ **AuthTextField Widget**: Testes de validação e input
- ✅ **App Theme**: Testes de configuração e tema

Para mais detalhes, veja [test/README_TESTS.md](test/README_TESTS.md)

## 📊 Firebase Realtime Database - Estrutura de Dados

```json
{
  "messages": {
    "messageId1": {
      "text": "Olá, mundo!",
      "userId": "uid123",
      "userName": "João Silva",
      "timestamp": 1708123456789
    },
    "messageId2": {
      "text": "Tudo bem?",
      "userId": "uid456",
      "userName": "Maria Santos",
      "timestamp": 1708123457890
    }
  }
}
```

## 🔐 Segurança

### Firebase Security Rules

Configure as regras de segurança no Firebase Console:

**Realtime Database Rules:**
```json
{
  "rules": {
    "messages": {
      ".read": "auth != null",
      ".write": "auth != null",
      "$messageId": {
        ".validate": "newData.hasChildren(['text', 'userId', 'userName', 'timestamp'])"
      }
    }
  }
}
```

**Authentication:**
- Email/Senha habilitado
- Validação de email obrigatória (opcional)

## 🧪 Testando o Aplicativo

### Fluxo de Teste

1. **Cadastro de Usuário**
   - Abra o app
   - Clique em "Cadastre-se"
   - Preencha nome, email e senha
   - Clique em "Cadastrar"

2. **Login**
   - Na tela de login, insira email e senha
   - Clique em "Entrar"

3. **Envio de Mensagens**
   - Após login, você será direcionado ao chat
   - Digite uma mensagem no campo inferior
   - Clique no botão de enviar
   - A mensagem aparecerá instantaneamente

4. **Teste em Tempo Real**
   - Abra o app em outro dispositivo/emulador
   - Faça login com outra conta
   - Envie mensagens de ambos os dispositivos
   - As mensagens aparecerão em tempo real em todos os dispositivos

## 📝 Licença

Este projeto foi desenvolvido para fins educacionais.

## 👨‍💻 Autor

Desenvolvido por Lucas

## 📞 Suporte

Para dúvidas ou problemas, entre em contato através do repositório no GitHub.

---

**Nota**: Este projeto requer configuração do Firebase. Certifique-se de que os arquivos de configuração (`google-services.json` para Android e `GoogleService-Info.plist` para iOS) estejam devidamente configurados.
