From: m18063 <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 1/2] drivers: pwm: pwm-atmel: switch to atomic PWM
Date: Wed, 1 Mar 2017 16:37:08 +0200
Message-ID: <88104c6d-e9f2-c830-3f4d-f8f9d7eacff3@microchip.com>
References: <1488278415-2786-1-git-send-email-claudiu.beznea@microchip.com>
 <1488278415-2786-2-git-send-email-claudiu.beznea@microchip.com>
 <20170228220756.3e29b62e@bbrezillon>
 <4b72b07c-22c6-8224-3a21-5ed052f004a3@microchip.com>
 <20170301151320.1d3ebc0e@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170301151320.1d3ebc0e@bbrezillon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org, thierry.reding@gmail.com, alexandre.belloni@free-electrons.com, galak@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hi Boris,


On 01.03.2017 16:13, Boris Brezillon wrote:
> Hi Claudiu,
>
> On Wed, 1 Mar 2017 15:56:26 +0200
> m18063 <Claudiu.Beznea@microchip.com> wrote:
>
>> Hi Boris,
>>
>> Thank you for the closer review. Please see my answers
>> inline.
>>
>> Thank you,
>> Claudiu
>>
>>
>> On 28.02.2017 23:07, Boris Brezillon wrote:
>>> Hi Claudiu,
>>>
>>> On Tue, 28 Feb 2017 12:40:14 +0200
>>> Claudiu Beznea <claudiu.beznea@microchip.com> wrote:
>>>  
>>>> The currently Atmel PWM controllers supported by this driver
>>>> could change period and duty factor without channel disable
>>>> (sama5d3 supports this by using period and duty factor update
>>>> registers, sam9rl support this by writing channel update
>>>> register and select the corresponding update: period or duty
>>>> factor).  
>>> Hm, I had a closer a look at the datasheet, and I'm not sure this is
>>> possible in a safe way. AFAICT (I might be wrong), there's no way to
>>> atomically update both the period and duty cycles. So, imagine you're
>>> just at the end of the current period and you update one of the 2 params
>>> (either the period or the duty cycle) before the end of the period, but
>>> the other one is updated just after the beginning of a new period.
>>> During one cycle you'll have a bad config.  
>> I was also think at this scenario. I thought that this should be
>> good for most of the cases.
> Unlikely, but not impossible.
>
>>> While this should be acceptable in most cases, there are a few cases
>>> where glitches are not permitted (when the PWM drives a critical
>>> device). Also, I don't know what happens if we have duty > period.  
>> duty > period is checked by the PWM core before calling apply method.
> No, I meant that, if you update the period then the duty (or the other
> way around), one update might make it in one period-cycle, and the
> other one might be delayed until the next period. In this case you
> might end up with inconsistent values and possibly duty > period.
I see what you're saying. Yes, you're right.
>
>>>  
>>>> The chip doesn't support run time changings of signal
>>>> polarity. This has been adapted by first disabling the channel,
>>>> update registers and the enabling the channel.  
>>> Yep. I agree with that one.
>>>  
>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>>>> ---
>>>>  drivers/pwm/pwm-atmel.c | 217 ++++++++++++++++++++++++++----------------------
>>>>  1 file changed, 118 insertions(+), 99 deletions(-)
>>>>
>>>> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
>>>> index 67a7023..014b86c 100644
>>>> --- a/drivers/pwm/pwm-atmel.c
>>>> +++ b/drivers/pwm/pwm-atmel.c
>>>> @@ -68,7 +68,7 @@ struct atmel_pwm_chip {
>>>>  	struct mutex isr_lock;
>>>>  
>>>>  	void (*config)(struct pwm_chip *chip, struct pwm_device *pwm,
>>>> -		       unsigned long dty, unsigned long prd);
>>>> +		       unsigned long dty, unsigned long prd, bool enabled);
>>>>  };
>>>>  
>>>>  static inline struct atmel_pwm_chip *to_atmel_pwm_chip(struct pwm_chip *chip)
>>>> @@ -105,99 +105,120 @@ static inline void atmel_pwm_ch_writel(struct atmel_pwm_chip *chip,
>>>>  	writel_relaxed(val, chip->base + base + offset);
>>>>  }
>>>>  
>>>> -static int atmel_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>>>> -			    int duty_ns, int period_ns)
>>>> +static int atmel_pwm_config_prepare(struct pwm_chip *chip,
>>>> +				    struct pwm_state *state, unsigned long *prd,
>>>> +				    unsigned long *dty, unsigned int *pres)  
>>> I'd rename the function atmel_pwm_calculate_params(). Also, when the
>>> period does not change we don't have to calculate prd and pres, so
>>> maybe we should have one function to calculate prd+pres and another one
>>> to calculate dty:
>> I agree. I didn't want to change the current implementation from
>> this point of view.
> Well, I think this is preferable to have a one-time rework than keeping
> things for historical reasons.
I will change it in v2.
>
>
> [...]
>
>>>  
>>>>  {
>>>>  	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
>>>> -	unsigned long prd, dty;
>>>>  	unsigned long long div;
>>>> -	unsigned int pres = 0;
>>>> -	u32 val;
>>>> -	int ret;
>>>> -
>>>> -	if (pwm_is_enabled(pwm) && (period_ns != pwm_get_period(pwm))) {
>>>> -		dev_err(chip->dev, "cannot change PWM period while enabled\n");
>>>> -		return -EBUSY;
>>>> -	}
>>>>  
>>>>  	/* Calculate the period cycles and prescale value */
>>>> -	div = (unsigned long long)clk_get_rate(atmel_pwm->clk) * period_ns;
>>>> +	div = (unsigned long long)clk_get_rate(atmel_pwm->clk) * state->period;
>>>>  	do_div(div, NSEC_PER_SEC);
>>>>  
>>>> +	*pres = 0;
>>>>  	while (div > PWM_MAX_PRD) {
>>>>  		div >>= 1;
>>>> -		pres++;
>>>> +		(*pres)++;
>>>>  	}
>>>>  
>>>> -	if (pres > PRD_MAX_PRES) {
>>>> +	if (*pres > PRD_MAX_PRES) {
>>>>  		dev_err(chip->dev, "pres exceeds the maximum value\n");
>>>>  		return -EINVAL;
>>>>  	}
>>>>  
>>>>  	/* Calculate the duty cycles */
>>>> -	prd = div;
>>>> -	div *= duty_ns;
>>>> -	do_div(div, period_ns);
>>>> -	dty = prd - div;
>>>> +	*prd = div;
>>>> +	div *= state->duty_cycle;
>>>> +	do_div(div, state->period);
>>>> +	*dty = *prd - div;  
>>> Not sure this subtraction is needed, you just need to revert the
>>> polarity selection (if polarity == NORMAL => set CPOL, otherwise, clear
>>> it).  
>> I didn't want to change the existing implementation.
> Again, if it simplifies the whole logic, I think it's preferable to do
> it now, since we're anyway refactoring the driver for the atomic
> transition.
I'll do it in v2.
>
> [...]
>
>>>>  static void atmel_pwm_config_v1(struct pwm_chip *chip, struct pwm_device *pwm,
>>>> -				unsigned long dty, unsigned long prd)
>>>> +				unsigned long dty, unsigned long prd,
>>>> +				bool enabled)
>>>>  {
>>>>  	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
>>>>  	unsigned int val;
>>>> +	unsigned long timeout;
>>>>  
>>>> +	if (pwm_is_enabled(pwm) && enabled) {
>>>> +		/* Update duty factor. */
>>>> +		val = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
>>>> +		val &= ~PWM_CMR_UPD_CDTY;
>>>> +		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
>>>> +		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CUPD, dty);
>>>>  
>>>> -	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CUPD, dty);
>>>> -
>>>> -	val = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
>>>> -	val &= ~PWM_CMR_UPD_CDTY;
>>>> -	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
>>>> -
>>>> -	/*
>>>> -	 * If the PWM channel is enabled, only update CDTY by using the update
>>>> -	 * register, it needs to set bit 10 of CMR to 0
>>>> -	 */
>>>> -	if (pwm_is_enabled(pwm))
>>>> -		return;
>>>> -	/*
>>>> -	 * If the PWM channel is disabled, write value to duty and period
>>>> -	 * registers directly.
>>>> -	 */
>>>> -	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CDTY, dty);
>>>> -	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CPRD, prd);
>>>> +		/*
>>>> +		 * Wait for the duty factor update.
>>>> +		 */
>>>> +		mutex_lock(&atmel_pwm->isr_lock);
>>>> +		atmel_pwm->updated_pwms |= atmel_pwm_readl(atmel_pwm, PWM_ISR) &
>>>> +				~(1 << pwm->hwpwm);
>>>> +
>>>> +		timeout = jiffies + 2 * HZ;
>>>> +		while (!(atmel_pwm->updated_pwms & (1 << pwm->hwpwm)) &&
>>>> +		       time_before(jiffies, timeout)) {
>>>> +			usleep_range(10, 100);
>>>> +			atmel_pwm->updated_pwms |=
>>>> +					atmel_pwm_readl(atmel_pwm, PWM_ISR);
>>>> +		}
>>>> +
>>>> +		mutex_unlock(&atmel_pwm->isr_lock);
>>>> +
>>>> +		/* Update period. */
>>>> +		val = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
>>>> +		val |= PWM_CMR_UPD_CDTY;
>>>> +		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
>>>> +		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV1_CUPD, prd);  
>>> As I said above, I'm almost sure it's not 100% safe to update both
>>> parameters. We'd better stick to the existing implementation and see if
>>> new IPs provide an atomic period+duty update feature.  
>> There is such approach only for synchronous channels, which I didn't cover
>> in this implementation.
> Yep, that's what I understood. So let's stick to "update duty only" for
> now.
Ok.
>
> [...]
>
>>>>  static void atmel_pwm_config_v2(struct pwm_chip *chip, struct pwm_device *pwm,
>>>> -				unsigned long dty, unsigned long prd)
>>>> +				unsigned long dty, unsigned long prd,
>>>> +				bool enabled)
>>>>  {
>>>>  	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
>>>>  
>>>> -	if (pwm_is_enabled(pwm)) {
>>>> +	if (pwm_is_enabled(pwm) && enabled) {
>>>>  		/*
>>>> -		 * If the PWM channel is enabled, using the duty update register
>>>> -		 * to update the value.
>>>> +		 * If the PWM channel is enabled, use update registers
>>>> +		 * to update the duty and period.
>>>>  		 */
>>>>  		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV2_CDTYUPD, dty);
>>>> +		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWMV2_CPRDUPD, prd);  
>>> Same here, I'm not convinced we are guaranteed that both parameters will
>>> be applied atomically. There's a sync mechanism described in the
>>> datasheet, but I'm not sure I understand how it works, and anyway,
>>> you're not using it here, so let's stick to the "update duty only"
>>> approach for now.  
>> Only for synchronous channels the atomicity is granted. I didn't cover that
>> in this commit. With this approach the dty, period will be changed at the
>> next period but there is no guarantee that they will be synchronously
>> updated.
> Ditto, let's stick to the current approach.
>
> Regards,
>
> Boris
