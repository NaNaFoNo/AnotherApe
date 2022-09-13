(impl-trait .sip009.sip009)

(define-non-fungible-token another-ape uint)

(define-constant MINT_PRICE u50000000) ;; 50STX
(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_OWNER_ONLY (err u101))
(define-constant ERR_NOT_TOKEN_OWNER (err u102))

(define-data-var last-token-id uint u0)
(define-data-var base-uri (string-ascii 100) "link to metadata")  ;; ipfs//


(define-read-only (get-last-token-id)
  (ok (var-get last-token-id))
)

(define-read-only (get-token-uri (id uint)) 
  ;; (concat (concat (var-get base-uri) "{id}") "".json")
  ;; client side where you handle swapping id's based on input
  (ok (some (var-get base-uri)))
)

(define-read-only (get-owner (id uint)) 
  (ok (nft-get-owner? another-ape id))
)

(define-public (transfer (id uint) (sender principal) (recipient principal)) 
  (begin
    (asserts! (is-eq tx-sender sender) ERR_NOT_TOKEN_OWNER)  ;;  ??? Not get-owner(id) instead of sender  ????
    ;; #[filter(id, recipient)]
    (nft-transfer? another-ape id sender recipient)
  )
)

(define-public (mint (recipient principal)) 
  (let
    (
      (id (+ (var-get last-token-id) u1))
    )
    ;; #[filter(recipient)]
    (asserts! (is-eq tx-sender recipient) ERR_OWNER_ONLY)
    (try! (stx-transfer? MINT_PRICE recipient CONTRACT_OWNER))
    (try! (nft-mint? another-ape id recipient))
    (var-set last-token-id id)
    (ok id)
  )
  
)