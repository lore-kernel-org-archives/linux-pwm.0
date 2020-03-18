From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: Re: [RFC PATCH 1/7] pwm: rename the PWM_POLARITY_INVERSED enum
Date: Wed, 18 Mar 2020 13:47:40 +0200
Message-ID: <CAGgjyvGDTD=ZgEjU540HLApQXCoM1a8bk_-eQbS44sge+GpeAg@mail.gmail.com>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-2-oleksandr.suvorov@toradex.com> <20200317174043.GA1464607@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-db8eur05on2124.outbound.protection.outlook.com ([40.107.20.124]:44416
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726616AbgCRLsB (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 18 Mar 2020 07:48:01 -0400
In-Reply-To: <20200317174043.GA1464607@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Paul Barker <pbarker@konsulko.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Philippe Schenker <philippe.schenker@toradex.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Claudiu Beznea <claudiu.beznea@microchip.com>, Fabio Estevam <festevam@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Kevin Hilman <khilman@baylibre.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Maxime Ripard <mripard@kernel.org>, NXP Linux Team <linux-imx@nxp.com>

On Tue, Mar 17, 2020 at 7:41 PM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Tue, Mar 17, 2020 at 02:32:25PM +0200, Oleksandr Suvorov wrote:
> > The polarity enum definition PWM_POLARITY_INVERSED is misspelled.
> > Rename it to PWM_POLARITY_INVERTED.
>
> It isn't misspelled. "inversed" is a synonym for "inverted". Both
> spellings are correct.

> And as you noted in the cover letter, there's a conflict between the
> macro defined in dt-bindings/pwm/pwm.txt. If they end up being included
> in the wrong order you'll get a compile error.

This patch is a part of the patchset, which in result removes enum at all,
so there will be no definition conflict.

> The enum was named this way on purpose to make it separate from the
> definition for the DT bindings. Note that DT bindings are an ABI and can
> never change, whereas the enum pwm_polarity is part of a Linux internal
> API and doesn't have the same restrictions as an ABI.

AFAIU, DTS files are not a part of ABI.

I understand that enums are better than macros for some reasons.
However, I think it is dangerous to use duplicate definitions in
different places when values of these definitions use in the same
code.
So, given that the enum cannot be used in DT, I left only macros.

You personally wrote that the enum pwm_polarity can change, so the
desynchronization I quite possible.

> As far as I'm concerned this is completely unnecessary churn that's
> potentially going to come back and bite us, so I see no reason to accept
> this.


>
> Thierry
