from brownie import accounts, config, SimpleStorage, network

from eth_account import Account


def deploy_simple_storage():
    # local accounts
    account = accounts[0]
    simple_storage = SimpleStorage.deploy({"from": account})
    store_value = simple_storage.retrieve()
    print(store_value)

    # Trans
    # call
    print(simple_storage)
    # print(account)
    ##############################3
    # if want to connect with testnet cli command brownie accounts new freecodecamp-account
    ###############################
    # account = accounts.load("beginer-account")
    # print(account)

    # if we want to use environment variable
    # account = accounts.add(config["wallets"]["from_key"])
    # print(account)


def main():
    deploy_simple_storage()
