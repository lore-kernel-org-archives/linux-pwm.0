From: m18063 <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH] drivers: pwm: pwm-atmel: implement suspend/resume
 functions
Date: Tue, 11 Apr 2017 11:22:39 +0300
Message-ID: <ba255c5b-ff6e-a6fd-0546-9dde04026f4c@microchip.com>
References: <1491834020-3194-1-git-send-email-claudiu.beznea@microchip.com>
 <20170410163558.494cf9be@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170410163558.494cf9be@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alexandre.belloni@free-electrons.com, nicolas.ferre@microchip.com
List-Id: linux-pwm@vger.kernel.org

Hi Boris,

On 10.04.2017 17:35, Boris Brezillon wrote:
> On Mon, 10 Apr 2017 17:20:20 +0300
> Claudiu Beznea <claudiu.beznea@microchip.com> wrote:
> 
>> Implement suspend and resume power management specific
>> function to allow PWM controller to correctly suspend
>> and resume.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> ---
>>  drivers/pwm/pwm-atmel.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 81 insertions(+)
>>
>> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
>> index 530d7dc..75177c6 100644
>> --- a/drivers/pwm/pwm-atmel.c
>> +++ b/drivers/pwm/pwm-atmel.c
>> @@ -58,6 +58,8 @@
>>  #define PWM_MAX_PRD		0xFFFF
>>  #define PRD_MAX_PRES		10
>>  
>> +#define PWM_MAX_CH_NUM		(4)
>> +
>>  struct atmel_pwm_registers {
>>  	u8 period;
>>  	u8 period_upd;
>> @@ -65,11 +67,18 @@ struct atmel_pwm_registers {
>>  	u8 duty_upd;
>>  };
>>  
>> +struct atmel_pwm_pm_ctx {
>> +	u32 cmr;
>> +	u32 cdty;
>> +	u32 cprd;
>> +};
>> +
>>  struct atmel_pwm_chip {
>>  	struct pwm_chip chip;
>>  	struct clk *clk;
>>  	void __iomem *base;
>>  	const struct atmel_pwm_registers *regs;
>> +	struct atmel_pwm_pm_ctx ctx[PWM_MAX_CH_NUM];
> 
> Hm, I'm pretty sure you can rely on the current PWM state and call
> atmel_pwm_apply() at resume time instead of doing that. See what I did
> here [1].

I agree with the approach you propose but the thing is the atmel_pwm_apply()
take care of both, current PWM state and the new state received as argument
in order to change only duty factor without disabling the PWM channel (if
channel is enabled) and then returns. Changing PWM duty and period and polarity
in the same step without disabling + enabling the PWM channel (with atomic
approach) may lead to intermediary unwanted output waveforms (the IP doesn't
support this for ordinary PWM channels). To take advantage of atmel_pwm_apply()
(in the formit is today) in resume() hook might need to first call it to disable
channel and then to enable it. Or atmel_pwm_apply() should be changed to also
disable + enable the channel when user changes the duty factor at runtime.

> 
> Thierry, maybe it's time to start thinking about a generic solution to
> save/restore PWM states.
> 
>>  
>>  	unsigned int updated_pwms;
>>  	/* ISR is cleared when read, ensure only one thread does that */
>> @@ -333,6 +342,77 @@ atmel_pwm_get_driver_data(struct platform_device *pdev)
>>  	return (struct atmel_pwm_registers *)id->driver_data;
>>  }
>>  
>> +#ifdef CONFIG_PM_SLEEP
>> +static int atmel_pwm_suspend(struct device *dev)
>> +{
>> +	struct atmel_pwm_chip *atmel_pwm = dev_get_drvdata(dev);
>> +	struct pwm_device *pwm = atmel_pwm->chip.pwms;
>> +	int i;
>> +	bool disable_clk = false;
>> +
>> +	for (i = 0; i < atmel_pwm->chip.npwm; i++, pwm++) {
>> +		if (!pwm_is_enabled(pwm))
>> +			continue;
>> +
>> +		disable_clk = true;
>> +		atmel_pwm->ctx[i].cdty =
>> +			atmel_pwm_ch_readl(atmel_pwm, i,
>> +					   atmel_pwm->regs->duty);
>> +		atmel_pwm->ctx[i].cprd =
>> +			atmel_pwm_ch_readl(atmel_pwm, i,
>> +					   atmel_pwm->regs->period);
>> +		atmel_pwm->ctx[i].cmr =
>> +			atmel_pwm_ch_readl(atmel_pwm, i, PWM_CMR);
>> +
>> +		atmel_pwm_disable(&atmel_pwm->chip, pwm, false);
>> +	}
>> +
>> +	if (disable_clk)
>> +		clk_disable(atmel_pwm->clk);
> 
> I'm not so sure we want to disable the PWM and the PWM chip clk when
> entering suspend. What if the PWM is driving a critical device (like a
> regulator) that has to stay enabled in suspend?
> Shouldn't we delegate this responsibility to the PWM user?
It is a good point.
> 
> [1]http://patchwork.ozlabs.org/patch/734306/
> 
