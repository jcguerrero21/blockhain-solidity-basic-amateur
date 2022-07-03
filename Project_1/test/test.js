const Hello = artifacts.require("Hello");

contract ('Hello', accounts => {
    it('Obtener mensaje', async () => {
        let instance = await Hello.deployed();
        const message = await instance.getMessage.call({from: accounts[0]});
        assert.equal(message, 'Hola mundo');
    });

    it('Cambiar mensaje', async() => {
        let instance = await Hello.deployed();
        const tx = await instance.setMessage('Juan', {from: accounts[2]});
        console.log(accounts);
        console.log(accounts[2]);
        console.log(tx);
        const msg = await instance.getMessage.call();
        assert.equal(msg, 'Juan');
    });

    

});