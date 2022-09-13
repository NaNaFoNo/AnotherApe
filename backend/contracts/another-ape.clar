
(impl-trait .sip009.sip009)

(define-non-fungible-token another-ape uint)

(define-constant MINT_PRICE u50000000) ;; 50STX
(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_OWNER_ONLY (err 101))
(define-constant ERR_NOT_TOKEN_OWNER (err 102))

(define-data-var last-token-id uint u0)
(define-data-var base-uri (string-ascii 100) "link to metadata")  ;; ipfs//
