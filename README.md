# Bitcoin-Backed Lending Platform Smart Contract

A decentralized platform for issuing and managing Bitcoin-backed loans built on Stacks blockchain. This smart contract enables users to deposit Bitcoin as collateral and receive loans while ensuring proper collateralization and automated liquidation management.

## Features

- **Collateralized Lending**: Users can deposit BTC as collateral and receive loans
- **Dynamic Interest Rates**: Configurable interest rates with automatic calculation
- **Automated Liquidations**: Built-in liquidation mechanism for under-collateralized positions
- **Flexible Parameters**: Adjustable collateral ratios and liquidation thresholds
- **Price Feed Integration**: Support for real-time price updates for supported assets
- **Multi-loan Management**: Users can manage multiple active loans

## Key Parameters

- Minimum Collateral Ratio: 150%
- Liquidation Threshold: 120%
- Platform Fee Rate: 1%
- Default Interest Rate: 5%
- Supported Assets: BTC, STX

## Functions

### User Functions

- `deposit-collateral`: Deposit BTC as collateral
- `request-loan`: Request a loan against deposited collateral
- `repay-loan`: Repay an active loan with interest
- `get-loan-details`: View details of a specific loan
- `get-user-loans`: View all loans associated with a user
- `get-platform-stats`: View platform-wide statistics

### Administrative Functions

- `initialize-platform`: Initialize the lending platform
- `update-collateral-ratio`: Modify the minimum collateral ratio
- `update-liquidation-threshold`: Adjust the liquidation threshold
- `update-price-feed`: Update asset prices

## Error Codes

- `ERR-NOT-AUTHORIZED (u100)`: Unauthorized access attempt
- `ERR-INSUFFICIENT-COLLATERAL (u101)`: Collateral below required ratio
- `ERR-BELOW-MINIMUM (u102)`: Amount below minimum threshold
- `ERR-INVALID-AMOUNT (u103)`: Invalid transaction amount
- `ERR-ALREADY-INITIALIZED (u104)`: Platform already initialized
- `ERR-NOT-INITIALIZED (u105)`: Platform not initialized
- `ERR-INVALID-LIQUIDATION (u106)`: Invalid liquidation attempt
- `ERR-LOAN-NOT-FOUND (u107)`: Loan ID not found
- `ERR-LOAN-NOT-ACTIVE (u108)`: Loan is not active
- `ERR-INVALID-LOAN-ID (u109)`: Invalid loan identifier
- `ERR-INVALID-PRICE (u110)`: Invalid price input
- `ERR-INVALID-ASSET (u111)`: Unsupported asset

## Usage Example

```clarity
;; Initialize the platform (contract owner only)
(contract-call? .bitcoin-lending initialize-platform)

;; Deposit collateral
(contract-call? .bitcoin-lending deposit-collateral u100000000) ;; 1 BTC

;; Request a loan
(contract-call? .bitcoin-lending request-loan u100000000 u50000000)

;; Repay a loan
(contract-call? .bitcoin-lending repay-loan u1 u52500000) ;; Including 5% interest
```

## Security Features

- Ownership validation for administrative functions
- Asset validation for supported cryptocurrencies
- Price feed validation with reasonable bounds
- Automatic collateral ratio monitoring
- Protected loan management functions

## Technical Details

The smart contract implements several safety mechanisms:

- Collateral ratio calculation using block height
- Interest calculation based on time elapsed
- Maximum loan list size of 10 per user
- Validation checks for all numerical inputs
- Protected state transitions for loan status

## Requirements

- Stacks blockchain compatibility
- Access to price feed oracle
- Sufficient BTC for collateral
- STX for transaction fees

## Contributing

When contributing to this contract, please ensure all new functions:

1. Include proper input validation
2. Maintain existing security standards
3. Add appropriate error codes
4. Update relevant maps and variables atomically

## License

This smart contract is released under the MIT License. See the LICENSE file for details.
