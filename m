From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [RFC PATCH 1/7] pwm: rename the PWM_POLARITY_INVERSED enum
Date: Tue, 17 Mar 2020 22:00:42 +0100
Message-ID: <20200317210042.ryrof3amr7fxp4w5@pengutronix.de>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-2-oleksandr.suvorov@toradex.com>
 <20200317174043.GA1464607@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46209 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgCQVBZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Mar 2020 17:01:25 -0400
Content-Disposition: inline
In-Reply-To: <20200317174043.GA1464607@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Paul Barker <pbarker@konsulko.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Philippe Schenker <philippe.schenker@toradex.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Claudiu Beznea <claudiu.beznea@microchip.com>, Fabio Estevam <festevam@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Kevin Hilman <khilman@baylibre.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Maxime Ripard <mripard@kernel.org>, NXP Linux Team <linux-imx@nxp.com>, Nicolas Ferre <nicolas.f>

Hello,

On Tue, Mar 17, 2020 at 06:40:43PM +0100, Thierry Reding wrote:
> On Tue, Mar 17, 2020 at 02:32:25PM +0200, Oleksandr Suvorov wrote:
> > The polarity enum definition PWM_POLARITY_INVERSED is misspelled.
> > Rename it to PWM_POLARITY_INVERTED.
> 
> It isn't misspelled. "inversed" is a synonym for "inverted". Both
> spellings are correct.

Some time ago I stumbled about "inversed", too. My spell checker doesn't
know it and I checked some dictionaries and none of them knew that word:

https://www.lexico.com/search?utf8=%E2%9C%93&filter=dictionary&dictionary=en&query=inversed
https://de.pons.com/%C3%BCbersetzung/englisch-deutsch/inversed
https://dictionary.cambridge.org/spellcheck/english-german/?q=inversed

https://en.wiktionary.org/wiki/inverse#Verb mentions "inverse" as a verb
having "inversed" as past participle.

Having said this I think (independent of the question if "inversed"
exists) using two similar terms for the same thing just results in
confusion. I hit that in the past already and I like it being addressed.

> And as you noted in the cover letter, there's a conflict between the
> macro defined in dt-bindings/pwm/pwm.txt. If they end up being included
> in the wrong order you'll get a compile error.

There are also other symbols that exist twice (GPIO_ACTIVE_HIGH was the
first to come to my mind). I'm not aware of any problems related to
these. What am I missing?
 
> The enum was named this way on purpose to make it separate from the
> definition for the DT bindings.

Then please let's make it different by picking a different prefix or
something like that.

> Note that DT bindings are an ABI and can
> never change, whereas the enum pwm_polarity is part of a Linux internal
> API and doesn't have the same restrictions as an ABI.

I thought only binary device trees (dtb) are supposed to be ABI.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
