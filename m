From: Atish Patra <atish.patra@wdc.com>
Subject: Re: [RFC 2/4] pwm: sifive: Add a driver for SiFive SoC PWM
Date: Mon, 15 Oct 2018 23:28:04 -0700
Message-ID: <39685c1b-46cf-9e78-c9aa-46168627053f@wdc.com>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
 <1539111085-25502-3-git-send-email-atish.patra@wdc.com>
 <20181010131128.GA29142@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010131128.GA29142@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: "palmer@sifive.com" <palmer@sifive.com>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, Wesley Terpstra <wesley@sifive.com>
List-Id: linux-pwm@vger.kernel.org

On 10/10/18 6:11 AM, Christoph Hellwig wrote:
> Thanks for getting these drivers submitted upstream!
> 
> I don't really know anything about PWM, so just some random nitpicking
> below..
> 
>> +	iowrite32(frac, pwm->regs + REG_PWMCMP0 + (dev->hwpwm * SIZE_PWMCMP));
> 
> * already has a higher precedence than +, so no need for the inner
> braces.
> 
>> +	duty = ioread32(pwm->regs + REG_PWMCMP0 + (dev->hwpwm * SIZE_PWMCMP));
> 
> Same here.

Will remove the braces in both places.
> 
>> +	/* (1 << (16+scale)) * 10^9/rate = real_period */
> 	unsigned long scalePow = (pwm->approx_period * (u64)rate) / 1000000000;
> 
> no camcel case, please.

My bad. I will fix that.

> 
>> +	int scale = ilog2(scalePow) - 16;
>> +
>> +	scale = clamp(scale, 0, 0xf);
> 
> Why not:
> 
> 	int scale = clamp(ilog2(scale_pow) - 16, 0, 0xf);
> 

Sure.

>> +static int sifive_pwm_clock_notifier(struct notifier_block *nb,
>> +				     unsigned long event, void *data)
>> +{
>> +	struct clk_notifier_data *ndata = data;
>> +	struct sifive_pwm_device *pwm = container_of(nb,
>> +						     struct sifive_pwm_device,
>> +						     notifier);
> 
> I don't think there are any guidlines, but I always prefer to just move
> the whole container_of onto a new line:
> 
> 	struct sifive_pwm_device *pwm =
> 		container_of(nb, struct sifive_pwm_device, notifier);

Done.

Regards,
Atish
> 
>> +static struct platform_driver sifive_pwm_driver = {
>> +	.probe = sifive_pwm_probe,
>> +	.remove = sifive_pwm_remove,
>> +	.driver = {
>> +		.name = "pwm-sifivem",
>> +		.of_match_table = of_match_ptr(sifive_pwm_of_match),
>> +	},
>> +};
> 
> What about using tabs to align this a little more nicely?
> 
> static struct platform_driver sifive_pwm_driver = {
> 	.probe			= sifive_pwm_probe,
> 	.remove			= sifive_pwm_remove,
> 	.driver = {
> 		.name		= "pwm-sifivem",
> 		.of_match_table	= of_match_ptr(sifive_pwm_of_match),
> 	},
> };
> 
