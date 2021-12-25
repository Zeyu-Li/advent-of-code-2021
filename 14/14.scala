// run with `scalac 14.scala && scala Scala14 < 14.in`
/* **** this script requires scala version >= 2.13.1 which is a very bloated file ****
 * Here are some steps to install it: https://gist.github.com/Zeyu-Li/0a6c65e4b9e59865cc96ad93e8f0b29a
 */
object Scala14 {
    def main(args: Array[String]) {
        // val lines = scala.io.Source.fromFile("14.in").mkString
        // this code was stolen from https://github.com/ggzor/advent-of-code-2021/blob/main/day14/Day14.scala

        val lines = scala.io.Source.stdin.getLines().to(LazyList)
        // rules to create the hash table
        val rules = lines.drop(2).map{_.split(" -> ")}.map{
            case Array(k, v) => ((k(0), k(1)), v(0))}.toMap

        def countMut[A](l: Seq[A]) = l.groupMapReduce(identity)(_ => 1L)(_ + _).to(scala.collection.mutable.Map).withDefaultValue(0L)

        val cs = countMut(lines(0))
        // group into sliding window of 2
        var ps = countMut(lines(0).sliding(2).map{s => (s(0), s(1))}.to(LazyList))

        val top = 10
        // iterate 10 times
        for { _ <- 1 to top } {
            // init windows then iterate through windows
            val newPs = ps.empty
            ps.foreach{case (p@(p1, p2), v) =>
                        // println(v)
                        val mid = rules(p)
                        cs(mid) += v
                        newPs((p1, mid)) += v
                        newPs((mid, p2)) += v
                    }
            // save new windows to old
            // println(newPs)
            ps = newPs
        }

        // println(cs.values.max, cs.values.min)
        val answer = cs.values.max - cs.values.min
        println(s"Answer: $answer")
    }
}