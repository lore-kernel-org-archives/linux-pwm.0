Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40202 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730903AbfHHGta (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Aug 2019 02:49:30 -0400
MIME-Version: 1.0
References: <1562576868-8124-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1562576868-8124-7-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20190807070326.cgkbt4kpzhqvo5a3@pengutronix.de> <TYAPR01MB45445D854C1FDBB473A89559D8D70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB45445D854C1FDBB473A89559D8D70@TYAPR01MB4544.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 8 Aug 2019 08:49:17 +0200
Message-ID: <CAMuHMdUQpTvwk=PxhwJGbW8izBXSzHw0sNvypzONPovR7sZutA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH RFC 6/7] pwm: rcar: Add gpio support to output duty zero
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "geert+renesas@glider.be" <geert+renesas@glider.be>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>

Hi Shimoda-san,

On Thu, Aug 8, 2019 at 5:53 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> > From: Uwe Kleine-König, Sent: Wednesday, August 7, 2019 4:03 PM
> > While at it: If there is a publicly available reference manual adding a line:
> >
> >       Reference Manual: https://...
> >
> > would be great, too.
>
> Unfortunately, the document is not public...

RZ/G1 has the same hardware block, right?
Its Hardware User's Manual is publicly available, e.g. for RZ/G1M:
https://www.renesas.com/eu/en/products/microcontrollers-microprocessors/rz/rzg/rzg1m.html#documents

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
