;;; erc-twitt.el --- shows text of a twitt when an url is posted in erc buffers

;; Copyright (C) 2012  Raimon Grau

;; Author: Raimon Grau <raimonster@gmail.com>
;; Keywords: extensions

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

(require 'erc)
(require 'url-queue)

(defgroup erc-twitt nil
  "Enable twitt."
  :group 'erc)

(defcustom erc-twitt-regex "https?://twitter.com/.+/status/[0-9]+"
  "Regex to mach URLs to be downloaded"
  :group 'erc-twitt
  :type '(regexp :tag "Regex"))

(defun erc-twitt  (status marker)
  (goto-char (point-min))
  (search-forward "js-tweet-text tweet-text \">")
  (push-mark (point))
  (search-forward "

")
  (backward-char)
  (kill-region (mark) (point))

  (with-current-buffer (marker-buffer marker)
    (save-excursion
      (let ((inhibit-read-only t))
	(goto-char (marker-position marker))
	(insert-before-markers
	 (with-temp-buffer
	   (insert "[twit] - ")
	   (yank)
	   (buffer-string)))
	(put-text-property (point-min) (point-max) 'read-only t)))))

(defun erc-twitt-show-twitt ()
  (interactive)
  (goto-char (point-min))
  (search-forward "http" nil t)
  (let ((url (thing-at-point 'url)))
    (when (and url (string-match erc-twitt-regex url))
      (goto-char (point-max))
      (url-queue-retrieve url
			  'erc-twitt
			  (list
			   (point-marker))
			  t))))


(define-erc-module twitt nil
  "Display inlined twits in ERC buffer"
  ((add-hook 'erc-insert-modify-hook 'erc-twitt-show-twitt t)
   (add-hook 'erc-send-modify-hook 'erc-twitt-show-twitt t))
  ((remove-hook 'erc-insert-modify-hook 'erc-twitt-show-url-twitt)
   (remove-hook 'erc-send-modify-hook 'erc-twitt-show-url-twitt))
  t)


;;; Code:



(provide 'erc-twitt)
;;; erc-twitt.el ends here
