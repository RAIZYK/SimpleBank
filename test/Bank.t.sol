// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Bank.sol";

contract BankTest is Test {
    Bank bank;

    event Deposited(uint256 amount);
    event Withdrawn(uint256 amount);

    function setUp() public {
        bank = new Bank();
    }

    // 1. Успешная активация аккаунта
    function testActivateAccount() public {
        bank.activate();
        (, bool isActive) = bank.account();
        assertTrue(isActive, "account should be active after activate()");
    }

    // 2. Успешное пополнение счета
    function testDepositSuccess() public {
        bank.activate();

        vm.expectEmit(false, false, false, true);
        emit Deposited(100);

        bank.deposit(100);

        assertEq(bank.getBalance(), 100, "balance should equal deposited amount");
    }

    // 3. Успешное снятие средств
    function testWithdrawSuccess() public {
        bank.activate();
        bank.deposit(100);

        vm.expectEmit(false, false, false, true);
        emit Withdrawn(40);

        bank.withdraw(40);

        assertEq(bank.getBalance(), 60, "balance should decrease by withdrawn amount");
    }

    // 4. Попытка пополнения неактивного аккаунта
    function testDepositRevertsIfNotActive() public {
        vm.expectRevert(Errors.AccountNotActive.selector);
        bank.deposit(50);
    }

    // 5. Попытка снятия средств с неактивного аккаунта
    function testWithdrawRevertsIfNotActive() public {
        vm.expectRevert(Errors.AccountNotActive.selector);
        bank.withdraw(50);
    }

    // 6. Попытка снять сумму, превышающую баланс
    function testWithdrawRevertsIfInsufficientFunds() public {
        bank.activate();
        bank.deposit(30);

        vm.expectRevert(Errors.InsufficientFunds.selector);
        bank.withdraw(31);
    }

    // 7. Корректное изменение баланса после каждой операции
    function testBalanceChangesCorrectlyAfterOperations() public {
        bank.activate();
        assertEq(bank.getBalance(), 0);

        bank.deposit(200);
        assertEq(bank.getBalance(), 200);

        bank.deposit(50);
        assertEq(bank.getBalance(), 250);

        bank.withdraw(100);
        assertEq(bank.getBalance(), 150);

        bank.withdraw(150);
        assertEq(bank.getBalance(), 0);
    }
}
