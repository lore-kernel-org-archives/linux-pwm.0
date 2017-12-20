From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 4/4] ARM: pinctrl: sunxi-pinctrl: fix pin funtion can
 not be match correctly.
Date: Wed, 20 Dec 2017 09:05:29 +0100
Message-ID: <CACRpkdYtn6N6MOqS=oFXDcfgmkN8-qJY5tJpWP8+9JBb1gU9Kw@mail.gmail.com>
References: <20171213144748.GA18267@arx-s1>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:41894 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751850AbdLTIFb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Dec 2017 03:05:31 -0500
Received: by mail-io0-f173.google.com with SMTP id o2so16385047ioe.8
        for <linux-pwm@vger.kernel.org>; Wed, 20 Dec 2017 00:05:31 -0800 (PST)
In-Reply-To: <20171213144748.GA18267@arx-s1>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: hao_zhang <hao5781286@gmail.com>
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>

On Wed, Dec 13, 2017 at 3:47 PM, hao_zhang <hao5781286@gmail.com> wrote:
> Pin function can not be match correctly when SUNXI_PIN describe with
> mutiple variant and same function.
>
> such as:
> on pinctrl-sun4i-a10.c
>
> SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 2),
>                 SUNXI_FUNCTION(0x0, "gpio_in"),
>                 SUNXI_FUNCTION(0x1, "gpio_out"),
>                 SUNXI_FUNCTION_VARIANT(0x2, "pwm",    /* PWM0 */
>                         PINCTRL_SUN4I_A10 |
>                         PINCTRL_SUN7I_A20),
>                 SUNXI_FUNCTION_VARIANT(0x3, "pwm",    /* PWM0 */
>                         PINCTRL_SUN8I_R40)),
>
> it would always match to the first variant function
> (PINCTRL_SUN4I_A10, PINCTRL_SUN7I_A20)
>
> so we should add variant compare on it.
>
> Signed-off-by: hao_zhang <hao5781286@gmail.com>

Please resend patch with Maxime's suggestions fixed and his
ACK added so I can apply it.

I can take this patch separatelt, it does not need to be part of
the PWM series.

Yours,
Linus Walleij
