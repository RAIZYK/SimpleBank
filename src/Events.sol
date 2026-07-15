// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @notice Контракт-контейнер с событиями банка.
/// Bank.sol наследует его, чтобы использовать события напрямую.
abstract contract Events {
    /// @notice Возникает при успешном пополнении счета
    /// @param amount сумма пополнения
    event Deposited(uint256 amount);

    /// @notice Возникает при успешном снятии средств
    /// @param amount сумма снятия
    event Withdrawn(uint256 amount);
}
