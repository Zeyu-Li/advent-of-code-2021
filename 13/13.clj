;; run with `clj 13.clj`
(require '[clojure.string :as str])

;; get file and read it
(def file "13.in")
(def ^:const MARKED 1)

(defn readFile [file]
    (str/split (slurp file) #"\n\n"))

(defn str->int
    [string]
    (Integer/parseInt string))

(defn pair->coord
    [[_ x y]]
    {:x (str->int x) :y (str->int y)})

(defn fold->step
    [[_ axis v]]
    [(keyword axis) (str->int v)])

(defn extract-matches
    [pattern coordList func]
    (mapv func (re-seq pattern coordList)))

(defn testPrint "Debug testing print for every line" [file]
    (mapv println (readFile file)))

(defn parse []
    (let [[coordList, foldList] (readFile file) 
        coords (extract-matches #"(\d+),(\d+)" coordList pair->coord)
        folds (extract-matches #"(x|y)=(\d+)" foldList fold->step)]
        {:coords (zipmap coords (repeat MARKED)) :folds folds}))

;; ideally copy dots from one side to the other and then 
;; remove the dots that are not on the same side
(defn convert
    [[point _] [axis v]]
    (let [p (axis point)]
        (if (> p v) 
        (assoc point axis (- (* v 2) p))
        point)))

(defn fold
    [coords fold]
    (reduce #(assoc %1 (convert %2 fold) MARKED) {} coords))

(defn fold-manual
    [& {:keys [p-step] :or {p-step identity}}]
    (let [{coords :coords folds :folds} (parse)]
        (reduce #(fold %1 %2) coords (p-step folds))))

;; main function
(defn -main "Main function" []
    (println "Count =" (count (fold-manual :p-step #(take 1 %)))))

(-main)
