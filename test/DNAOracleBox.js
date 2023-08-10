const LootboxNFT = artifacts.require("DNAOracleBox");
const truffleAssert = require('truffle-assertions'); // to handle specific assertions like revert

contract("DNAOracleBox", (accounts) => {
    const owner = accounts[0];
    const buyer = accounts[1];
    const oracle = accounts[2];
    const newOracle = accounts[3];
    
    beforeEach(async () => {
        this.DNAOracleBox = await DNAOracleBox.new(oracle, { from: owner });
    });

    it("should deploy with correct name and symbol", async () => {
        const name = await this.DNAOracleBox.name();
        const symbol = await this.DNAOracleBox.symbol();

        assert.equal(name, "DNAOracleBox");
        assert.equal(symbol, "DNALB");
    });

    it("should let a user purchase a lootbox", async () => {
        await this.DNAOracleBox.purchaseLootBox({ from: buyer, value: web3.utils.toWei('0.01', 'ether') });
        
        const ownerOfToken = await this.DNAOracleBox.ownerOf(1); // Since the first token minted will have ID 1
        assert.equal(ownerOfToken, buyer);
    });

    it("should not let a user purchase for incorrect ether amount", async () => {
        await truffleAssert.reverts(
            this.DNAOracleBox.purchaseLootBox({ from: buyer, value: web3.utils.toWei('0.02', 'ether') }),
            "Incorrect Ether sent"
        );
    });

    it("should allow the owner to change the lootbox price", async () => {
        const newPrice = web3.utils.toWei('0.05', 'ether');
        await this.DNAOracleBox.setLootBoxPrice(newPrice, { from: owner });
        
        const currentPrice = await this.DNAOracleBox.lootBoxPrice();
        assert.equal(currentPrice.toString(), newPrice);
    });

    it("should not allow non-owner to change the lootbox price", async () => {
        const newPrice = web3.utils.toWei('0.05', 'ether');
        await truffleAssert.reverts(
            this.DNAOracleBox.setLootBoxPrice(newPrice, { from: buyer }),
            "Ownable: caller is not the owner"
        );
    });

    it("should let the owner withdraw the contract balance", async () => {
        await this.DNAOracleBox.purchaseLootBox({ from: buyer, value: web3.utils.toWei('0.01', 'ether') });

        const initialBalance = await web3.eth.getBalance(owner);
        
        await this.DNAOracleBox.withdraw({ from: owner });

        const finalBalance = await web3.eth.getBalance(owner);
        assert.isTrue(new web3.utils.BN(finalBalance).gt(new web3.utils.BN(initialBalance)));
    });

    it("should not let a non-owner withdraw the contract balance", async () => {
        await truffleAssert.reverts(
            this.DNAOracleBox.withdraw({ from: buyer }),
            "Ownable: caller is not the owner"
        );
    });

    it("should allow owner to set a new oracle address", async () => {
        await this.DNAOracleBox.setOracleAddress(newOracle, { from: owner });
        const currentOracle = await this.DNAOracleBox.oracleAddress();

        assert.equal(currentOracle, newOracle);
    });

    it("should not allow non-owner to set a new oracle address", async () => {
        await truffleAssert.reverts(
            this.DNAOracleBox.setOracleAddress(newOracle, { from: buyer }),
            "Ownable: caller is not the owner"
        );
    });

});

