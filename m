From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH v2 3/3] pwm: stm32: add power management support
Date: Wed, 16 Oct 2019 12:08:54 +0200
Message-ID: <15371530-a932-08b7-dd78-a7e20d213203@st.com>
References: <1570193633-6600-1-git-send-email-fabrice.gasnier@st.com>
 <1570193633-6600-4-git-send-email-fabrice.gasnier@st.com>
 <20191016070635.GC1296874@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191016070635.GC1296874@ulmo>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.torgue@st.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, mcoquelin.stm32@gmail.com, u.kleine-koenig@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, benjamin.gaignard@st.com
List-Id: linux-pwm@vger.kernel.org

On 10/16/19 9:06 AM, Thierry Reding wrote:
> On Fri, Oct 04, 2019 at 02:53:53PM +0200, Fabrice Gasnier wrote:
>> Add suspend/resume PM sleep ops. When going to low power, enforce the PWM
>> channel isn't active. Let the PWM consumers disable it during their own
>> suspend sequence, see [1]. So, perform a check here, and handle the
>> pinctrl states. Also restore the break inputs upon resume, as registers
>> content may be lost when going to low power mode.
>>
>> [1] https://lkml.org/lkml/2019/2/5/770
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> ---
>> Changes in v2:
>> Follow Uwe suggestions/remarks:
>> - Add a precursor patch to ease reviewing
>> - Use registers read instead of pwm_get_state
>> - Add a comment to mention registers content may be lost in low power mode
>> ---
>>  drivers/pwm/pwm-stm32.c | 38 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 38 insertions(+)
> 
> Applied, thanks. I made two minor changes, though, see below.
> 
>>
>> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
>> index cf8658c..546b661 100644
>> --- a/drivers/pwm/pwm-stm32.c
>> +++ b/drivers/pwm/pwm-stm32.c
>> @@ -12,6 +12,7 @@
>>  #include <linux/mfd/stm32-timers.h>
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>> +#include <linux/pinctrl/consumer.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/pwm.h>
>>  
>> @@ -655,6 +656,42 @@ static int stm32_pwm_remove(struct platform_device *pdev)
>>  	return 0;
>>  }
>>  
>> +static int __maybe_unused stm32_pwm_suspend(struct device *dev)
>> +{
>> +	struct stm32_pwm *priv = dev_get_drvdata(dev);
>> +	unsigned int ch;
> 
> I renamed this to just "i", which is more idiomatic for loop variables.
> The function is small enough not to need to differentiate between loop
> variables.
> 
>> +	u32 ccer, mask;
>> +
>> +	/* Look for active channels */
>> +	ccer = active_channels(priv);
>> +
>> +	for (ch = 0; ch < priv->chip.npwm; ch++) {
>> +		mask = TIM_CCER_CC1E << (ch * 4);
>> +		if (ccer & mask) {
>> +			dev_err(dev, "The consumer didn't stop us (%s)\n",
>> +				priv->chip.pwms[ch].label);
> 
> Changed this to:
> 
> 	"PWM %u still in use by consumer %s\n", i, priv->chip.pwms[i].label
> 
> I think that might help clarify which PWM is still enabled in case the
> consumers don't set a label.

Hi Thierry,

Many thanks for all the improvements on this series!

Best Regards,
Fabrice

> 
> Thierry
> 
>> +			return -EBUSY;
>> +		}
>> +	}
>> +
>> +	return pinctrl_pm_select_sleep_state(dev);
>> +}
>> +
>> +static int __maybe_unused stm32_pwm_resume(struct device *dev)
>> +{
>> +	struct stm32_pwm *priv = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	ret = pinctrl_pm_select_default_state(dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* restore breakinput registers that may have been lost in low power */
>> +	return stm32_pwm_apply_breakinputs(priv);
>> +}
>> +
>> +static SIMPLE_DEV_PM_OPS(stm32_pwm_pm_ops, stm32_pwm_suspend, stm32_pwm_resume);
>> +
>>  static const struct of_device_id stm32_pwm_of_match[] = {
>>  	{ .compatible = "st,stm32-pwm",	},
>>  	{ /* end node */ },
>> @@ -667,6 +704,7 @@ static struct platform_driver stm32_pwm_driver = {
>>  	.driver	= {
>>  		.name = "stm32-pwm",
>>  		.of_match_table = stm32_pwm_of_match,
>> +		.pm = &stm32_pwm_pm_ops,
>>  	},
>>  };
>>  module_platform_driver(stm32_pwm_driver);
>> -- 
>> 2.7.4
>>
