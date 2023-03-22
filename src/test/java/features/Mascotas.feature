Feature: Mascotas

  Background:
    * url baseURL = 'https://petstore.swagger.io/v2'
    * def createUser = read('../inputFiles/createUser.json')
    * def getUser = read('../inputFiles/getUser.json')
    * def listPetsInfo = read('../schemas/listPetsInfo.json')
    * def category = read('../schemas/category.json')
    * def tags = read('../schemas/tags.json')

  @Mascotas
  Scenario: Crear usuario
    Given path "user"
    Then request createUser
    When method post
    Then status 200

  @Mascotas
  Scenario: Recuperar datos usuario
    Given path "user/diego.dejuan"
    When method get
    Then match response == read('../schemas/getUserResponse.json')
    Then status 200

  @Mascotas
  Scenario: Buscar mascotas
    Given path "/pet/findByStatus"
    And param status = 'sold'
    When method get
    Then match response[*] contains listPetsInfo
    * def resp =
      """
        function resp(response){
          let mapa = new Map();
          let clave, valor;
          response.forEach (function(value, key) {
            clave = value.id;
            valor = value.name;

            //mapa.set(clave, valor);
            console.log({clave: valor});
            //console.log("NAME " + value.name);
          })
          //return {clave, valor};
          }

      """
    And def x = resp(response)
    * print x
