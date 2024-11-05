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

;; Data Variables
(define-data-var platform-initialized bool false)
(define-data-var minimum-collateral-ratio uint u150) ;; 150% collateral ratio
(define-data-var liquidation-threshold uint u120) ;; 120% triggers liquidation
(define-data-var platform-fee-rate uint u1) ;; 1% platform fee
(define-data-var total-btc-locked uint u0)
(define-data-var total-loans-issued uint u0)

;; Data Maps
(define-map loans
    { loan-id: uint }
    {
        borrower: principal,
        collateral-amount: uint,
        loan-amount: uint,
        interest-rate: uint,
        start-height: uint,
        last-interest-calc: uint,
        status: (string-ascii 20)
    }
)

(define-map user-loans
    { user: principal }
    { active-loans: (list 10 uint) }
)

(define-map collateral-prices
    { asset: (string-ascii 10) }
    { price: uint }
)

;; Private Functions
(define-private (calculate-collateral-ratio (collateral uint) (loan uint) (btc-price uint))
    (let
        (
            (collateral-value (* collateral btc-price))
            (ratio (* (/ collateral-value loan) u100))
        )
        ratio
    )
)

(define-private (calculate-interest (principal uint) (rate uint) (blocks uint))
    (let
        (
            (interest-per-block (/ (* principal rate) (* u100 u144))) ;; Daily interest divided by blocks per day
            (total-interest (* interest-per-block blocks))
        )
        total-interest
    )
)


(define-private (check-liquidation (loan-id uint))
    (let
        (
            (loan (unwrap! (map-get? loans {loan-id: loan-id}) ERR-LOAN-NOT-FOUND))
            (btc-price (unwrap! (get price (map-get? collateral-prices {asset: "BTC"})) ERR-NOT-INITIALIZED))
            (current-ratio (calculate-collateral-ratio (get collateral-amount loan) (get loan-amount loan) btc-price))
        )
        (if (<= current-ratio (var-get liquidation-threshold))
            (liquidate-position loan-id)
            (ok true)
        )
    )
)