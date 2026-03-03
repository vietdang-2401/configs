;; ;; 1. Fold cho các Directive (ví dụ: @if ... @endif, @foreach ... @endforeach)
;; (directive
;;   (directive_start) @start
;;   (directive_end) @end.after
;;   (#set! role block))
;;
;; ;; 2. Fold cho các khối hiển thị dữ liệu (Interpotation: {{ ... }} hoặc {!! ... !!})
;; (interpolation
;;   "{{" @start
;;   "}}" @end
;;   (#set! role block))
;;
;; (interpolation
;;   "{!!" @start
;;   "!!}" @end
;;   (#set! role block))
;;
;; ;; 3. Fold cho Comment trong Blade {{-- ... --}}
;; (comment
;;   "{{--" @start
;;   "--}}" @end
;;   (#set! role block))
