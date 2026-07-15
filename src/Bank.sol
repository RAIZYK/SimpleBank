// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Types.sol";
import "./Events.sol";
import "./Errors.sol";

/// @title Simple Bank
/// @notice Простой смарт-контракт банка с одним аккаунтом
contract Bank is Events, Errors {
    /// @notice Единственный аккаунт, обслуживаемый этим контрактом
    Account public account;

    /// @notice Активировать аккаунт. После активации становятся доступны
    /// операции пополнения и снятия средств.
    function activate() external {
        account.isActive = true;
    }

    /// @notice Пополнить баланс аккаунта
    /// @param amount сумма пополнения
    function deposit(uint256 amount) external {
        if (!account.isActive) revert AccountNotActive();

        account.balance += amount;

        emit Deposited(amount);
    }

    /// @notice Снять средства с аккаунта
    /// @param amount сумма снятия
    function withdraw(uint256 amount) external {
        if (!account.isActive) revert AccountNotActive();
        if (amount > account.balance) revert InsufficientFunds();

        account.balance -= amount;

        emit Withdrawn(amount);
    }

    /// @notice Получить текущий баланс аккаунта
    /// @return текущий баланс
    function getBalance() external view returns (uint256) {
        return account.balance;
    }
}
