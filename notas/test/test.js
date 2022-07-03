// Llamada al contrato de sistem universitario
const notas = artifacts.require('Notas');

contract('notas', accounts => {
    it ('1. Función Evaluar(string memory _idAlumno, uint _nota)', async() => {
        // Smart Contract desplegado
        let instance = await notas.deployed();
        // Llamada al metodo de evaluación del Smart Contract
        const tx = await instance.evaluate('77755N', 9, {from: accounts[0]})
        // Imprimir valores:
        console.log(accounts[0]) //Dirección del profesor
        console.log(tx) // Transacción de la evaluación académica
        // Comprobación de la información de la Blockchain
        const nota_alumno = await instance.verNotas.call('77755N', {from: accounts[1]});
        // Condición para pasar el test: nota_alumno = 9
        console.log(nota_alumno);
        assert.equal(nota_alumno, 9);
    });

    it('2. Función: Revision(string memory _idAlumn)', async() => {
        // Smart Contract desplegado
        let instance = await notas.deployed();
        // Llamada al método de revisar exámenes
        const rev = await instance.revision('12345X', {from: accounts[1]});
        // Imprimir los valores recibidos de la revisión
        console.log(rev);
        // Verificación del test
        const id_alumno = await instance.verRevisiones.call({from: accounts[0]});
        console.log(id_alumno);
        // Comprobación de los datos de las revisiones
        assert.equal(id_alumno, '12345X');
    });
});

