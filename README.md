# Avaliação Prática INDT
- Será possível salvar localmente os produtos fornecidos pela api, também deletar localmente. Foi desenvolvido em flutter,porém,  só  tem soporte para android, usando banco de dados com floor (sqlLite), todos os metodos tem sua própria documentação para melhor entendimento,  pode visualizar o seguinte exemplo de documentação aplicado: 
    /*
    * Resumo do que a funçao faz 
    * @author  inicial ou nome quen fez   - data 
    * @version 1.0   - 20230302 - initial release
    * @param   <tipo de variable> - nome da varivel    - o que esa variavel faz 
    * @return <tipo de retorno> resumo do retorno 
    */


## Organização 
    Padrão de arquitetura MVC para organização das pastas, mudando brevemente o contexto e respeitando a regra:
    - Models: entidades dos obj.

    - Controllers: controladores de cada obj e gerencionador de estados (provider).

    - Services: services(session, metodos genericos).

    - dao (Data Access Object): realiza a busca no banco de dados.

    - Screen: todas as telas com nomes que representam o que elas fazem ou mostram.

    - style: todos os estilos usados em todo o app (Theme)
    
    - Components: componentes reusados global com os nomes que representam ou fazem 

## Offline
Despois que for inicializado e chegando na tela HomeScreen fará uma request para pegar todos os productos da api, e mostrar para o usuario, caso desejar salvar localmente é possível, os produtos salvos localmente ficaram dentro de um banco de dados local feito con sql lite usando uma 'orm' chamado floor


## Outros
    - session: se tudo está certo ao inisializar o app criará uma session usando get it para não realizar request desnecessárias (a session será actualizada a cada request realizada. Exemplo: deletando o salvando algum produto ), pode encontrar os métodos em services/services_locator
    - gerencionamento de estados: usando provider para a parte de traduções
    - traduções: o app conta com 2 idiomas sendo esses (en, pt_br) desta forma mantendo todo o código e texto numa linguagem única, pode encontrar os métodos em controllers/translate_controller
  

 # Melhorias a ser realizadas   
    - Salvar localmente todos os producto retornados pela api, assim caso a pessoa fique sem internet pode ver os produtos mesmo assim e poder baixar eles 
    - background_fetch: caso o usuario encontra-se sem internet, consegue sincronizar em segundo plano com a api, atualizar os produtos; assim o usuario ao entrar no app conseguira ver sempre os produtos e ajuda a não fazer request desnecessária
  
# Requisitos do Sistema
    - Linguagem Dart
    - Floor (orm)
    - Realizar o comando "flutter pub get" ao fazer un clone para atualizar o projeto,
    - APK na raiz do projeto, app-release.apk
    - Versionamento de código com Git
    - caso altere os models, as querys ou database precisara rodar o comando :
        - flutter pub run build_runner build --delete-conflicting-outputs   ou    - flutter packages pub run build_runner build 
    - documentação a serem lídas :
        - background_fetch: https://pub.dev/packages/background_fetch
        - floor: https://pub.dev/packages/floor