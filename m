From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: mvebu: clear irq in edge cause register before
 unmask edge irq
Date: Thu, 23 Jan 2020 15:53:33 +0100
Message-ID: <CACRpkdYqTCmG1=HM0QphPou43HFSXBNB5HH1R8xH0KEb=zxC1Q@mail.gmail.com>
References: <20200115073811.24438-1-bigunclemax@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35932 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbgAWOxq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 23 Jan 2020 09:53:46 -0500
Received: by mail-lj1-f196.google.com with SMTP id r19so3777475ljg.3
        for <linux-pwm@vger.kernel.org>; Thu, 23 Jan 2020 06:53:44 -0800 (PST)
In-Reply-To: <20200115073811.24438-1-bigunclemax@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Maxim <bigunclemax@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-pwm@vger.kernel.org, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Jan 15, 2020 at 8:40 AM Maxim <bigunclemax@gmail.com> wrote:

> From: Maxim Kiselev <bigunclemax@gmail.com>
>
> When input GPIO set from 0 to 1, the interrupt bit asserted in the GPIO
> Interrupt Cause Register (ICR) even if the corresponding interrupt
> masked in the GPIO Interrupt Mask Register.
>
> Because interrupt mask register only affects assertion of the interrupt
> bits in Main Interrupt Cause Register and it does not affect the
> setting of bits in the GPIO ICR.
>
> So, there is problem, when we unmask interrupt with already
> asserted bit in the GPIO ICR, then false interrupt immediately occurs
> even if GPIO don't change their value since last unmask.
>
> Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>

Since there is no feedback from the MVEBU maintainers I have
tentatively applied the patch for v5.6 so it gets some testing.

Yours,
Linus Walleij
