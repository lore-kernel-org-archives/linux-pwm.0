From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2 v2] pwm: add a driver for the STMPE PWM
Date: Sun, 1 May 2016 20:19:27 +0200
Message-ID: <CACRpkdYsoUtSGad8caEBSUqJAjP9r4-i4Va6ZLKM+0QF3+JLiA@mail.gmail.com>
References: <1459891357-28352-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:32878 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbcEAST2 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sun, 1 May 2016 14:19:28 -0400
Received: by mail-oi0-f47.google.com with SMTP id v145so135838037oie.0
        for <linux-pwm@vger.kernel.org>; Sun, 01 May 2016 11:19:28 -0700 (PDT)
In-Reply-To: <1459891357-28352-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>

On Tue, Apr 5, 2016 at 11:22 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> This adds a driver for the STMPE 24xx series of multi-purpose
> I2C expanders. (I think STMPE means ST Microelectronics
> Multi-Purpose Expander.) This PWM was designed in accordance with
> Nokia specifications and is kind of weird and usually just
> switched between max and zero dutycycle. However it is indeed
> a PWM so it needs to live in the PWM subsystem.
>
> This PWM is mostly used for white LED backlight.
>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:

Thierry? Soon a month since I posted this and the kernel
merge window is getting closer.

If I need to respin this I'd like to know so I can do it before
the merge window, else can this and 1/2 be applied?

Yours,
Linus Walleij
