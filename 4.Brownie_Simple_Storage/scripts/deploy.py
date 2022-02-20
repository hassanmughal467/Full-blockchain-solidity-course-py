from brownie import accounts, config, SimpleStorage, network

from eth_account import Account


def deploy_simple_storage():
    # local accounts
    # only works when we work with ganache cli
    account = get_account()
    simple_storage = SimpleStorage.deploy({"from": account})
    store_value = simple_storage.retrieve()
    print(store_value)
    transaction = simple_storage.store_id(15, {"from": account})
    transaction.wait(1)
    updated_stored_value = simple_storage.retrieve()
    print(updated_stored_value)


# TO CHECK WE ARE WORKNG WITH DEVELOPMENT CHAIN OR NOT


def get_account():
    if network.show_active() == "development":
        return accounts[0]
    else:
        return accounts.add(config["wallets"]["from_key"])


def main():
    deploy_simple_storage()
