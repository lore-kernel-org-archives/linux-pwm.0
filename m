Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33091 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfAHI4k (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Jan 2019 03:56:40 -0500
MIME-Version: 1.0
References: <1546918094-13960-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1546918094-13960-3-git-send-email-yoshihiro.shimoda.uh@renesas.com> <20190108074749.d23mpcr3wscr6s5j@pengutronix.de>
In-Reply-To: <20190108074749.d23mpcr3wscr6s5j@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Jan 2019 09:56:28 +0100
Message-ID: <CAMuHMdUdrfjUHzOZr25a4JsRNK34KL8kA1s1G+BrpRzZgtB-7w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH v2 2/4] pwm: rcar: Use "atomic" API on rcar_pwm_resume()
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Thierry Reding <thierry.reding@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Uwe,

On Tue, Jan 8, 2019 at 8:48 AM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> Orthogonal to this patch I wonder what the intended behaviour for a pwm
> is on suspend. Should it stop oscilating unconditionally? Or should it
> only stop if the consumer stops it as part of its own suspend callback?

I guess you mean system suspend, not runtime suspend, as the device is
runtime-resumed when a PWM is requested?

Permitted behavior depends on the system: on R-Car Gen3 (arm64), PSCI system
suspend will power down the SoC, so PWM output will stop for sure.

On R-Car Gen2 (or R-Car Gen3 with s2idle instead of s2ram), the PM Domain
code will turn of the PWM module's clock. Hence it will stop oscillating, unless
you take special countermeasures, like for modules that need to stay powered
for wake-up handling.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
