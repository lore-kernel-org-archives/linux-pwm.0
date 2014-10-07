From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v6]pwm: add BCM2835 PWM driver
Date: Tue, 07 Oct 2014 08:35:51 -0700
Message-ID: <54340857.9000409@wwwdotorg.org>
References: <1412690665-15416-1-git-send-email-bart.tanghe@thomasmore.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:48040 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520AbaJGPfy (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Oct 2014 11:35:54 -0400
In-Reply-To: <1412690665-15416-1-git-send-email-bart.tanghe@thomasmore.be>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Bart Tanghe <bart.tanghe@thomasmore.be>, thierry.reding@gmail.com
Cc: matt.porter@linaro.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org

On 10/07/2014 07:04 AM, Bart Tanghe wrote:
> Add pwm driver for Broadcom BCM2835 processor (Raspberry Pi)

Just a few nits below,

> diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c

> +#define PWM_CONTROL_MASK	0xff
> +#define PWM_MODE		0x80		/* set timer in pwm mode */
> +#define DEFAULT		0xff		/* set timer in default mode */

BTW, it'd be nice to say default *what*. Perhaps DEFAULT_PWM_MODE?

> +static int bcm2835_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct bcm2835_pwm *pc = to_bcm2835_pwm(chip);
> +	u32 value;
> +
> +	value = readl(pc->base);
> +	value &= ~(PWM_CONTROL_MASK << PWM_CONTROL_STRIDE * pwm->hwpwm);
> +	value |= (PWM_MODE << (PWM_CONTROL_STRIDE * pwm->hwpwm));

Presence/absence of brackets around the STRIDE*pwm calculation is still
inconsistent here, and in other places.

> +static void bcm2835_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct bcm2835_pwm *pc = to_bcm2835_pwm(chip);
> +	u32 value;
> +
> +	value = readl(pc->base);
> +	value &= (~DEFAULT << (PWM_CONTROL_STRIDE * pwm->hwpwm));

Why clear the "DEFAULT" bits here; why not use PWM_CONTROL_MASK?
