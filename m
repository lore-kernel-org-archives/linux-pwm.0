From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [resend rfc v4]pwm: add BCM2835 PWM driver
Date: Mon, 29 Sep 2014 22:34:41 -0600
Message-ID: <542A32E1.8040003@wwwdotorg.org>
References: <1412001619-30001-1-git-send-email-bart.tanghe@thomasmore.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:33873 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbaI3Een (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Sep 2014 00:34:43 -0400
In-Reply-To: <1412001619-30001-1-git-send-email-bart.tanghe@thomasmore.be>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Bart Tanghe <bart.tanghe@thomasmore.be>, thierry.reding@gmail.com
Cc: matt.porter@linaro.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org

On 09/29/2014 08:40 AM, Bart Tanghe wrote:
> Add pwm driver for Broadcom BCM2835 processor (Raspberry Pi) 
> Signed-off-by: Bart Tanghe <bart.tanghe@thomasmore.be>

There needs to be a blank line between the description and the tags.

> diff --git a/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt b/Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt

> +Required properties:
> +- compatible: should be "brcm,bcm2835-pwm"
> +- reg: physical base address and length of the controller's registers

This needs to document the clock property too.

It'd be nice to require clock-names rather than doing clock lookup by
index, but I suppose it's not too much of a problem with this device.

> diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c

> +/*
> + * Copyright (C) 2014 Thomas more

But the git commit doesn't have "Thomas More" as the author, nor Thomas'
Signed-off-by line. Can you explain the history of this code?

> +static int bcm2835_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct bcm2835_pwm *pc = to_bcm2835_pwm(chip);
> +	u32 value;
> +
> +	value = readl(pc->base) & ~(PWM_CONTROL_MASK << 8 * pwm->pwm);
> +	value |= (PWM_CONTROL_ENABLE << (8 * pwm->pwm));

It'd be nice to use a #define rather than hard-coded "8" here. Perhaps:

#define PWM_CONTROL_STRIDE 8

Why does _request() enable the PWM output; shouldn't that be deferred
until _enable()? _free() might not want to disable the output, if the
PWM core guarantees that _disable() is always called.

> +static int bcm2835_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +			      int duty_ns, int period_ns)
> +{
> +	struct bcm2835_pwm *pc = to_bcm2835_pwm(chip);
> +
> +	if (period_ns > MIN_PERIOD) {
> +		writel(duty_ns / pc->scaler,
> +			 pc->base + DUTY + pwm->pwm * CHANNEL);
> +		writel(period_ns / pc->scaler,
> +			pc->base + PERIOD + pwm->pwm * CHANNEL);
> +	} else {
> +		dev_err(pc->dev, "Period not supported\n");
> +	}

The "else" case should propagate the error. It'd be better to do the
error-checking first to remove an indent level from the rest of the code:

	if (period_ns <= MIN_PERIOD) {
		dev_err(...);
		return -EINVAL;
	}
	writel(...);

> +static int bcm2835_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
> +				enum pwm_polarity polarity)
> +{
> +	struct bcm2835_pwm *pc = to_bcm2835_pwm(chip);
> +	u32 value;
> +
> +	if (polarity == PWM_POLARITY_NORMAL) {
> +		value = readl(pc->base);
> +		value &= ~(PWM_POLARITY << 8 * pwm->pwm);
> +		writel(value, pc->base);
> +	} else if (polarity == PWM_POLARITY_INVERSED) {
> +		value = readl(pc->base);
> +		value |= PWM_POLARITY << (8 * pwm->pwm);
> +		writel(value, pc->base);
> +	}

If you move the readl/writel outside the if statement, you remove the
duplication of code.

> +static const struct pwm_ops bcm2835_pwm_ops = {
...
> +	.owner = THIS_MODULE,
> +};

Doesn't something in the driver core automatically set .owner now?
Perhaps that's only for certain subsystems though?

> +MODULE_AUTHOR("Bart Tanghe <bart.tanghe@thomasmore.be");

That doesn't match the (c) message at the start of the file.
