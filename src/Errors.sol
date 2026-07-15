// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @notice Контракт-контейнер с кастомными ошибками банка.
/// Bank.sol наследует его, чтобы использовать ошибки напрямую.
abstract contract Errors {
    /// @notice Недостаточно средств на счете для снятия
    error InsufficientFunds();

    /// @notice Операция запрещена, так как аккаунт не активирован
    error AccountNotActive();
}
