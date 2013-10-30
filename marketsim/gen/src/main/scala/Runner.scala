import java.io.PrintWriter
import resource._
import sext._

object Runner extends Parser {

    def main(args: Array[String]) {

        ExprTest.run()

        for (input <- managed(io.Source.fromFile("defs/random.sc"));
             raw_output <- managed(new PrintWriter("defs/random.raw"));
             pp_output <- managed(new PrintWriter("defs/random.pp")))
        {
            val in = input.mkString
            raw_output.println(s"$in ->")
            pp_output.println(s"$in ->")

            val (raw, pp) = parseAll(definitions, in) match {
                case Success(result , _) => {
                    val pp = result.toString
                    parseAll(definitions, pp) match {
                        case Success(result2, _) => {
                            if (result != result2) {
                                println(s"input: in")
                                println(s"parsed: $result")
                                println(s"re-parsed: $result2")
                            }
                        }
                        case x => println(x)
                    }
                    (result.treeString, pp)
                }
                case x => (x.toString, x.toString)
            }

            raw_output.println(raw)
            pp_output.println(pp)
        }
    }

}
