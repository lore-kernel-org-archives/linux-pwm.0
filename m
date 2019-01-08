Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-vk1-f193.google.com ([209.85.221.193]:43244 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfAHJfn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Jan 2019 04:35:43 -0500
MIME-Version: 1.0
References: <1546918094-13960-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1546918094-13960-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20190108074749.d23mpcr3wscr6s5j@pengutronix.de> <CAMuHMdUdrfjUHzOZr25a4JsRNK34KL8kA1s1G+BrpRzZgtB-7w@mail.gmail.com>
 <20190108091925.gcv6tqkvxr2ilj3w@pengutronix.de>
In-Reply-To: <20190108091925.gcv6tqkvxr2ilj3w@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Jan 2019 10:35:29 +0100
Message-ID: <CAMuHMdVxdG6DsXxa6T+u7F9HniywjwQneQ5GZ6xoEai89nu-9w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH v2 2/4] pwm: rcar: Use "atomic" API on rcar_pwm_resume()
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Thierry Reding <thierry.reding@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Uwe,

On Tue, Jan 8, 2019 at 10:19 AM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> On Tue, Jan 08, 2019 at 09:56:28AM +0100, Geert Uytterhoeven wrote:
> > On Tue, Jan 8, 2019 at 8:48 AM Uwe Kleine-König
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > Orthogonal to this patch I wonder what the intended behaviour for a pwm
> > > is on suspend. Should it stop oscilating unconditionally? Or should it
> > > only stop if the consumer stops it as part of its own suspend callback?
> >
> > I guess you mean system suspend, not runtime suspend, as the device is
> > runtime-resumed when a PWM is requested?
>
> I admit that suspend (both system and runtime) is a bit of a black box
> for me. So please take that into account when judging my statements.
>
> > Permitted behavior depends on the system: on R-Car Gen3 (arm64), PSCI system
> > suspend will power down the SoC, so PWM output will stop for sure.
> >
> > On R-Car Gen2 (or R-Car Gen3 with s2idle instead of s2ram), the PM Domain
> > code will turn of the PWM module's clock. Hence it will stop oscillating, unless
> > you take special countermeasures, like for modules that need to stay powered
> > for wake-up handling.
>
> Whatever "suspend" here means, I want to prevent that a stopping pwm is
> a surprise for the consumer. So I think suspend should be inhibited if
> the consumer might expect the pwm to continue running but the pwm is
> about to stop. So if the suspend affects the consumer, too, it's the
> consumer that should be responsible to stop the pwm in a controlled
> manner.

I think you can inhibit suspend by letting the .suspend() callback return an
error. However, I think the PWM driver cannot make that decision on its own.
Shutting down the PWM for a status LED is harmless, and the status LED being
enabled should not prevent a system suspend.
Shutting down e.g. a motor may be different.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
