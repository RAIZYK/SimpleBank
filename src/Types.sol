// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @notice Структура, описывающая счёт пользователя банка
struct Account {
    uint256 balance;  // баланс пользователя
    bool isActive;     // статус активности аккаунта
}
