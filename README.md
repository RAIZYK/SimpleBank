# SimpleBank

Учебный смарт-контракт банка, разбитый на несколько файлов, оформлен как
полноценный Foundry-проект.

## Структура

```
SimpleBank/
├── .github/            — CI workflow (forge build/test на пуш)
├── lib/
│   └── forge-std/       — библиотека для тестов (зависимость)
├── script/
│   └── DeployBank.s.sol — скрипт деплоя контракта
├── src/
│   ├── Bank.sol          — основной контракт (activate, deposit, withdraw, getBalance)
│   ├── Types.sol         — struct Account { balance, isActive }
│   ├── Events.sol        — события Deposited, Withdrawn
│   └── Errors.sol        — кастомные ошибки InsufficientFunds, AccountNotActive
├── test/
│   └── Bank.t.sol        — 7 тестов на Foundry (forge-std)
├── foundry.toml
├── foundry.lock
├── .gitignore
├── .gitmodules
└── README.md
```

## Установка Foundry

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

## Запуск проекта

Зависимость `forge-std` уже включена в проект (папка `lib/forge-std`),
переустанавливать её не обязательно. Если нужно поставить заново:

```bash
forge install foundry-rs/forge-std --no-commit
```

Собрать контракты:

```bash
forge build
```

Прогнать тесты:

```bash
forge test -vv
```

Ожидаемый результат:

```
Ran 7 tests for test/Bank.t.sol:BankTest
[PASS] testActivateAccount() (gas: 31259)
[PASS] testBalanceChangesCorrectlyAfterOperations() (gas: 49845)
[PASS] testDepositRevertsIfNotActive() (gas: 11159)
[PASS] testDepositSuccess() (gas: 58312)
[PASS] testWithdrawRevertsIfInsufficientFunds() (gas: 56976)
[PASS] testWithdrawRevertsIfNotActive() (gas: 11160)
[PASS] testWithdrawSuccess() (gas: 61376)
Suite result: ok. 7 passed; 0 failed; 0 skipped; finished in ... ms
```

Подробные трейсы для отладки:

```bash
forge test -vvvv
```

Задеплоить контракт (пример, для локальной сети anvil):

```bash
anvil            # в отдельном терминале
forge script script/DeployBank.s.sol --rpc-url http://127.0.0.1:8545 --broadcast --private-key <ключ>
```
