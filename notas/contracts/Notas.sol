// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;


//------------------------------------
// ALUMNO  /  ID  /  NOTA
//------------------------------------
// JUAN / 77755N / 8
// MARIA / 88855N / 10
// LUISA / 44455N / 3

contract notas {

    // Dirección del profesor
    address public professor;

    // Constructor
    constructor () {
        professor = msg.sender;
    }

    // Mapping para relacionar el has de la identidad del alumno con su nota del examen
    mapping (bytes32 => uint) Ratings;

    // Array de los alumnos que pidan revisiones de examen
    string [] reviews;

    // Eventos
    event alumn_evaluated(bytes32);
    event event_revision(string);

    // Función para evaluar a alumnos
    function evaluate(string memory _idAlumn, uint _nota) public UniquetlyProfessor(msg.sender) {
        // Hash de la identificación del alumno
        bytes32 hash_idAlumn = keccak256(abi.encodePacked(_idAlumn));
        // Relación entre el hash de la identificación del alumno y su nota
        Ratings[hash_idAlumn] = _nota;
        // Emision del evento
        emit alumn_evaluated(hash_idAlumn);
    }

    modifier UniquetlyProfessor(address _direction) {
        // Requiere que la dirección introducida por parametro sea igual al owner del contrato
        require(_direction == professor, "Not have permissions for execute this function.");
        _;
    }

    // Funcion para ver las notas de un alumno
    function verNotas(string memory _idAlumn) public view returns(uint) {
        // Hash de la identificación del alumno
        bytes32 hash_idAlumn = keccak256(abi.encodePacked(_idAlumn));
        // Nota asociada al hash del alumno
        uint rating_alumn = Ratings[hash_idAlumn];
        //Visualizar la nota;
        return rating_alumn;
    }

    // Función para pedir revisión del examen
    function revision(string memory _idAlumn) public {
        // Almacenamiento de la identidad del alumno en un array
        reviews.push(_idAlumn);
        // Emision del evento
        emit event_revision(_idAlumn);
    }

    // Función para ver los alumnos que han solicitado revisión de examen
    function verRevisiones() public view UniquetlyProfessor(msg.sender) returns (string [] memory) {
        // Devolver las identidades de los alumnos
        return reviews;
    }


}