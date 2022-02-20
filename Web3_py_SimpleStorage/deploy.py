import json
from web3 import Web3
import os
from dotenv import load_dotenv

load_dotenv()

# In the video, we forget to `install_solc`
# from solcx import compile_standard
from solcx import compile_standard, install_solc

with open("./SimpleStorage.sol", "r") as file:
    simple_storage_file = file.read()

# Solidity source code
compiled_sol = compile_standard(
    {
        "language": "Solidity",
        "sources": {"SimpleStorage.sol": {"content": simple_storage_file}},
        "settings": {
            "outputSelection": {
                "*": {
                    "*": ["abi", "metadata", "evm.bytecode", "evm.bytecode.sourceMap"]
                }
            }
        },
    },
    solc_version="0.6.0",
)

with open("compiled_code.json", "w") as file:
    json.dump(compiled_sol, file)

# get bytecode
bytecode = compiled_sol["contracts"]["SimpleStorage.sol"]["SimpleStorage"]["evm"][
    "bytecode"
]["object"]


# get abi
abi = compiled_sol["contracts"]["SimpleStorage.sol"]["SimpleStorage"]["abi"]

# for connecting to ganache

w3 = Web3(
    Web3.HTTPProvider("https://rinkeby.infura.io/v3/7ea829c3249f497297571a3380624a49")
)
chain_id = 4
my_address = "0x3B27273cB325C29F80FB8ab9BE957FA48424954E"
private_key = os.getenv("PRIVATE_KEY")

# Create the contract in python
SimpleStorage = w3.eth.contract(abi=abi, bytecode=bytecode)

# Get the latest transaction
nonce = w3.eth.getTransactionCount(my_address)
# 1. Build the contract deploy transaction
# 2. Sign the Transaction
# 3. Send the transaction

transaction = SimpleStorage.constructor().buildTransaction(
    {
        "gasPrice": w3.eth.gas_price,
        "chainId": chain_id,
        "from": my_address,
        "nonce": nonce,
    }
)
signed_txn = w3.eth.account.sign_transaction(transaction, private_key=private_key)

# send the signed transaction
print("Deploying Contract......")
tx_hash = w3.eth.send_raw_transaction(signed_txn.rawTransaction)

# this will have our code stop and wait for this transaction
tx_receipt = w3.eth.wait_for_transaction_receipt(tx_hash)
print("Deployed!")
# working with contract
# Contract Addresss
# Contract ABI
simple_storage = w3.eth.contract(address=tx_receipt.contractAddress, abi=abi)
# Two of interact
# Call -->simulate making the call and getting back a return value
# Transact--> Actually make a state

# Initial value of favorite number
print(simple_storage.functions.retrieve().call())
print("Updating Contract.....")
store_transaction = simple_storage.functions.store(15).buildTransaction(
    {
        "gasPrice": w3.eth.gas_price,
        "chainId": chain_id,
        "from": my_address,
        "nonce": nonce + 1,
    }
)

signed_store_txn = w3.eth.account.sign_transaction(
    store_transaction, private_key=private_key
)

send_store_txn = w3.eth.send_raw_transaction(signed_store_txn.rawTransaction)
tx_receipt = w3.eth.wait_for_transaction_receipt(send_store_txn)
print("Updated!")
print(simple_storage.functions.retrieve().call())