Return-Path: <f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
Message-ID: <55CE281D.8090104@gmail.com>
Date: Fri, 14 Aug 2015 10:40:45 -0700
From: Florian Fainelli <f.fainelli@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] pwm: Add Broadcom BCM7038 PWM controller support
References: <1438908959-1578-1-git-send-email-f.fainelli@gmail.com> <1438908959-1578-3-git-send-email-f.fainelli@gmail.com>
In-Reply-To: <1438908959-1578-3-git-send-email-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
List-ID: <linux-pwm.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, PWM SUBSYSTEM <linux-pwm@vger.kernel.org>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>

On 06/08/15 17:55, Florian Fainelli wrote:
> Add support for the BCM7038-style PWM controller found in all BCM7xxx STB SoCs.
> This controller has a hardcoded 2 channels per controller, and cascades a
> variable frequency generator on top of a fixed frequency generator which offers
> a range of a 148ns period all the way to ~622ms periods.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

[snip]

> +	/* Try to grab the clock and its rate, if not available, default
> +	 * to the base 27Mhz clock domain this block comes from.
> +	 */
> +	p->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(p->clk)) {
> +		p->clk = NULL;
> +		p->rate = (unsigned long)of_id->data;
> +	} else {
> +		clk_prepare_enable(p->clk);
> +		p->rate = clk_get_rate(p->clk);
> +	}

Replying to myself here, I have reworked that part to use a helper
function which uses either clk_get_rate() or p->rate because even though
the backing clock for that core is fixed, we could have a variable rate
clock in the future, so fetching an accurate rate would be necessary.

[snip]

> +
> +#ifdef CONFIG_PM_SLEEP
> +static int brcmstb_pwm_suspend(struct device *d)
> +{

And here, we should disable the clock

> +	return 0;
> +}
> +
> +static int brcmstb_pwm_resume(struct device *d)
> +{

And enable it here.

I would still appreciate some feedback on the DT binding and this driver
in general before submitting a v2.

Thanks!
-- 
Florian
