;; Bitcoin-Backed Lending Platform
;; summary: A decentralized platform for issuing and managing Bitcoin-backed loans.
;; description: This smart contract allows users to deposit Bitcoin as collateral and request loans in a decentralized manner. It includes functionalities for initializing the platform, depositing collateral, requesting loans, repaying loans, and updating platform parameters. The contract ensures proper collateralization and handles liquidation of under-collateralized loans.

;; Constants
(define-constant CONTRACT-OWNER tx-sender)
(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-INSUFFICIENT-COLLATERAL (err u101))
(define-constant ERR-BELOW-MINIMUM (err u102))
(define-constant ERR-INVALID-AMOUNT (err u103))
(define-constant ERR-ALREADY-INITIALIZED (err u104))
(define-constant ERR-NOT-INITIALIZED (err u105))
(define-constant ERR-INVALID-LIQUIDATION (err u106))
(define-constant ERR-LOAN-NOT-FOUND (err u107))
(define-constant ERR-LOAN-NOT-ACTIVE (err u108))