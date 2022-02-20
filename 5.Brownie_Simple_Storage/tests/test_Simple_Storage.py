from brownie import SimpleStorage, accounts


def test_deploy():
    # Arrange
    account = accounts[0]
    simple_storage = SimpleStorage.deploy({"from": account})
    # Act
    starting_value = simple_storage.retrieve()
    expected = 0
    # Assert
    assert starting_value == expected


def test_updating_storage():
    # Arrange
    account = accounts[0]
    simple_storage = SimpleStorage.deploy({"from": account})

    # Act
    expected = 15
    simple_storage.store_id(expected, {"from": account})

    # Assert
    assert expected == simple_storage.retrieve()
