From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/7] gpio: mvebu: Add limited PWM support
Date: Mon, 12 Jan 2015 15:06:14 +0100
Message-ID: <CACRpkdZe2BMtTPU6wkd+gk5mttz3GdL_zYCTPQOaubwRAHbDgg@mail.gmail.com>
References: <1420846493-31647-1-git-send-email-andrew@lunn.ch>
	<1420846493-31647-4-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:64893 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbbALOGP (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Jan 2015 09:06:15 -0500
Received: by mail-ig0-f171.google.com with SMTP id z20so11465613igj.4
        for <linux-pwm@vger.kernel.org>; Mon, 12 Jan 2015 06:06:14 -0800 (PST)
In-Reply-To: <1420846493-31647-4-git-send-email-andrew@lunn.ch>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, Thierry Reding <thierry.reding@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Imre Kaloz <kaloz@openwrt.org>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Sat, Jan 10, 2015 at 12:34 AM, Andrew Lunn <andrew@lunn.ch> wrote:

> Armada 370/XP devices can 'blink' gpio lines with a configurable on
> and off period. This can be modelled as a PWM.
>
> However, there are only two sets of PWM configuration registers for
> all the gpio lines. This driver simply allows a single gpio line per
> gpio chip of 32 lines to be used as a PWM. Attempts to use more return
> EBUSY.
>
> Due to the interleaving of registers it is not simple to separate the
> PWM driver from the gpio driver. Thus the gpio driver has been
> extended with a PWM driver.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/gpio/Kconfig          |   5 ++
>  drivers/gpio/Makefile         |   1 +
>  drivers/gpio/gpio-mvebu-pwm.c | 202 ++++++++++++++++++++++++++++++++++++++++++
(...)
> +++ b/drivers/gpio/gpio-mvebu-pwm.c
(...)
> +static const struct pwm_ops mvebu_pwm_ops = {
> +       .request = mvebu_pwm_request,
> +       .free = mvebu_pwm_free,
> +       .config = mvebu_pwm_config,
> +       .enable = mvebu_pwm_enable,
> +       .disable = mvebu_pwm_disable,
> +       .owner = THIS_MODULE,
> +};

So the first basic notes:

- PWM maintainer Thierry Reding has to review and ACK this, and the patch needs
  to be posted to the linux-pwm mailing list too (check To: line)

- Should that driver portion really be in drivers/gpio or rather in drivers/pwm

- Why is this not modeled as an MFD spawning a GPIO and a PWM cell,
  as is custom? (Bringing MFD maintainers into the picture.)

So I am aware that this takes the problem from "quick fix extension to the GPIO
driver" to "really nasty hairy re-engineering of the whole shebang" but there is
a lot of precedents in the kernel for splitting up this type of hardware in
separate drivers under an MFD hub.

Yours,
Linus Walleij
