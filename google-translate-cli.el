;;; google-translate-cli.el --- A command-line interface for Google Translate  -*- lexical-binding: t; -*-

;; Copyright (C) 2026  Jen-Chieh Shen

;; Author: Jen-Chieh Shen <jcs090218@gmail.com>
;; Maintainer: Jen-Chieh Shen <jcs090218@gmail.com>
;; URL: https://github.com/emacs-eine/google-translate-cli
;; Version: 1.0.0
;; Package-Requires: ((emacs "26.1")
;;                    (google-translate "0.12.0")
;;                    (commander "0.7.0")
;;                    (msgu "0.1.0"))
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; A command-line interface for Google Translate
;;

;;; Code:

(require 'google-translate)
(require 'msgu)

(defgroup google-translate-cli nil
  "A command-line interface for Google Translate."
  :prefix "google-translate-cli-"
  :group 'tool
  :link '(url-link :tag "Repository" "https://github.com/emacs-eine/google-translate-cli"))

(defcustom google-translate-cli-source-language "auto"
  "The default source language you wish to translate from."
  :type 'string
  :group 'google-translate-cli)

(defcustom google-translate-cli-target-language "en"
  "The default target language you wish to translate to."
  :type 'string
  :group 'google-translate-cli)

;; internal use
(defvar google-translate-cli--text nil)

;;;###autoload
(defun google-translate-cli (source-language target-language text)
  "Translate text and output to standard output."
  (let ((old-kill-ring kill-ring))
    (msgu-silent
      (google-translate-translate source-language
                                  target-language
                                  text
                                  'kill-ring)
      ;; Wait until the result came in.
      (while (equal old-kill-ring kill-ring)
        (sit-for 0.2)))
    (when-let* ((result (car kill-ring)))
      (princ result))))

(provide 'google-translate-cli)
;;; google-translate-cli.el ends here
