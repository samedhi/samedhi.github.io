---
layout: post
title:  Build a csv in clojure
categories: [code]
---

<link rel="stylesheet" type="text/css" href="http://app.klipse.tech/css/codemirror.css">

<script>
    window.klipse_settings = {
        selector: '.language-klipse'// css selector for the html elements you want to klipsify
    };
</script>
<script src="http://app.klipse.tech/plugin/js/klipse_plugin.js"></script>

<pre><code class="language-klipse">
(ns csv-example
  (:require 
    [clojure.string :as string]))

(def csv
  [["name" "age" "occupation" "gender"]
   ["Peter Pan" 312 "Lost Boy" "male"]
   ["Wendy Darling" 14 "Older Sister" "female"]
   ["Captain Hook" 330 "Pirate" "male"]
   ["Tinker Bell" nil "Fairy" "female"]])

(defn clean-str [s]
  (pr-str (string/replace s "\n" "")))

(defn build-csv [xs]
  (->> xs 
    (map (fn [xs] (map #(if (string? %) (clean-str %) %) xs))) ;; quote all strings
    (map (partial string/join ",")) ;; seq of seq -> seq of strings
    (string/join "\n"))) ;; seq of string -> string

(println (build-csv csv))
</code></pre>
