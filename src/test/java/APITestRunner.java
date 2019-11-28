import com.intuit.karate.KarateOptions;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.Assert;
import org.junit.Test;

@KarateOptions(tags = "@smoke-test")
public class APITestRunner {

    @Test
    public void runAllParallel() {
        Results results = Runner.parallel(getClass(), 1, "target/surefire-reports");
        Assert.assertEquals(results.getErrorMessages(), 0, results.getFailCount());
    }
}