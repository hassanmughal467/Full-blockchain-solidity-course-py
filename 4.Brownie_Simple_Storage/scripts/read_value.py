# this function is going to be read directly  from the rinkeby blockcahin and it's going to read from
# a contract that we have already deployed
from brownie import SimpleStorage, accounts, config


def read_contract():
    simple_storage = SimpleStorage[-1]
    # go take the index that one less than the length
    # ABI
    # Address
    print(simple_storage.retrieve())


def main():
    read_contract()
