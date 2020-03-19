From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: Re: [RFC PATCH 1/7] pwm: rename the PWM_POLARITY_INVERSED enum
Date: Thu, 19 Mar 2020 13:40:28 +0200
Message-ID: <CAGgjyvGd4y8M0L1sFMvQ1=gPcKfUPoR13dVS7F5WZx=333KG6g@mail.gmail.com>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-2-oleksandr.suvorov@toradex.com> <20200317174043.GA1464607@ulmo>
 <20200317210042.ryrof3amr7fxp4w5@pengutronix.de> <20200318225953.GA2874972@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-db8eur05on2134.outbound.protection.outlook.com ([40.107.20.134]:62689
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbgCSLkx (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 19 Mar 2020 07:40:53 -0400
In-Reply-To: <20200318225953.GA2874972@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Paul Barker <pbarker@konsulko.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Philippe Schenker <philippe.schenker@toradex.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Claudiu Beznea <claudiu.beznea@microchip.com>, Fabio Estevam <festevam@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Kevin Hilman <khilman@baylibre.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Maxime Ripard <mripard@kernel.org>, NXP Linux Team <linux-imx@nxp.com>, Nico

On Thu, Mar 19, 2020 at 1:00 AM Thierry Reding <thierry.reding@gmail.com> w=
rote:
>
> On Tue, Mar 17, 2020 at 10:00:42PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > Hello,
> >
> > On Tue, Mar 17, 2020 at 06:40:43PM +0100, Thierry Reding wrote:
> > > On Tue, Mar 17, 2020 at 02:32:25PM +0200, Oleksandr Suvorov wrote:
> > > > The polarity enum definition PWM_POLARITY_INVERSED is misspelled.
> > > > Rename it to PWM_POLARITY_INVERTED.
> > >
> > > It isn't misspelled. "inversed" is a synonym for "inverted". Both
> > > spellings are correct.
> >
> > Some time ago I stumbled about "inversed", too. My spell checker doesn'=
t
> > know it and I checked some dictionaries and none of them knew that word=
:
> >
> > https://www.lexico.com/search?utf8=3D%E2%9C%93&filter=3Ddictionary&dict=
ionary=3Den&query=3Dinversed
> > https://de.pons.com/%C3%BCbersetzung/englisch-deutsch/inversed
> > https://dictionary.cambridge.org/spellcheck/english-german/?q=3Dinverse=
d
> >
> > https://en.wiktionary.org/wiki/inverse#Verb mentions "inverse" as a ver=
b
> > having "inversed" as past participle.
>
> Here are the first three results from a Google query:
>
>         https://www.yourdictionary.com/inversed
>         https://www.dictionary.com/browse/inversed
>         https://en.wiktionary.org/wiki/inversed
>
> > Having said this I think (independent of the question if "inversed"
> > exists) using two similar terms for the same thing just results in
> > confusion. I hit that in the past already and I like it being addressed=
.
>
> I don't know. It's pretty common to use different words for the same
> thing. They're called synonyms.
>
> > > And as you noted in the cover letter, there's a conflict between the
> > > macro defined in dt-bindings/pwm/pwm.txt. If they end up being includ=
ed
> > > in the wrong order you'll get a compile error.
> >
> > There are also other symbols that exist twice (GPIO_ACTIVE_HIGH was the
> > first to come to my mind). I'm not aware of any problems related to
> > these. What am I missing?
>
> There's currently no problem, obviously. But if for some reason the
> include files end up being included in a different order (i.e. the
> dt-bindings header is included before linux/pwm.h) then the macro will
> be evaluated and result in something like:
>
>         enum pwm_polarity {
>                 PWM_POLARITY_NORMAL,
>                 1,
>         };
>
> and that's not valid C, so will cause a build error.
>
> > > The enum was named this way on purpose to make it separate from the
> > > definition for the DT bindings.
> >
> > Then please let's make it different by picking a different prefix or
> > something like that.
>
> Again, seems to me like unnecessary churn. Feel free to propose
> something, but I recall being in the same position at the time and this
> was the best I could come up with.
>
> > > Note that DT bindings are an ABI and can
> > > never change, whereas the enum pwm_polarity is part of a Linux intern=
al
> > > API and doesn't have the same restrictions as an ABI.
> >
> > I thought only binary device trees (dtb) are supposed to be ABI.
>
> Yes, the DTB is the ABI. dt-bindings/pwm/pwm.h is used to generate DTBs,
> which basically makes it ABI as well. Yes, the symbol name may not be
> part of the ABI, but changing the symbol becomes very inconvenient
> because everyone that depends on it would have to change. Why bother?
>
> My point is that enum pwm_polarity is an API in the kernel and hence its
> easy to change or extend. But since that is not the same for the DTB, we
> need to be careful what from the internal kernel API leaks into the DTB.
> That's why they are different symbols, so that it is clear that what's
> in dt-bindings/pwm/pwm.h is the ABI.

Thierry, I see the PWM core converts the bit field "third cell" into
the polarity variable.
Now I probably understand your sight and agree that we shouldn't give
the same names to bits in bitfield (dts) and values of a variable.

But there are lots of useless "0" values of third cell of "pwms"
option in dts files.

I see 2 ways now:
- just remove all "0" "third cell" from "pwms" options in dts files. I
see this "0" confuses some people.
- convert pwm_state.polarity into pwm_state.flags and use bitfield
directly from dtb.
  It simplifies the parsing logic and makes adding new flags easier.

What do think?

>
> Thierry

--=20
Best regards
Oleksandr Suvorov

Toradex AG
Ebenaustrasse 10 | 6048 Horw | Switzerland | T: +41 41 500 48 00
