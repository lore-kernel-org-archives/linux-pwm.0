From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC PATCH 1/7] pwm: rename the PWM_POLARITY_INVERSED enum
Date: Thu, 19 Mar 2020 17:44:10 +0100
Message-ID: <20200319164410.GB3354541@ulmo>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-2-oleksandr.suvorov@toradex.com>
 <20200317174043.GA1464607@ulmo>
 <20200317210042.ryrof3amr7fxp4w5@pengutronix.de>
 <20200318225953.GA2874972@ulmo>
 <CAGgjyvGd4y8M0L1sFMvQ1=gPcKfUPoR13dVS7F5WZx=333KG6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46944 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbgCSQoQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Mar 2020 12:44:16 -0400
Content-Disposition: inline
In-Reply-To: <CAGgjyvGd4y8M0L1sFMvQ1=gPcKfUPoR13dVS7F5WZx=333KG6g@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Paul Barker <pbarker@konsulko.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Igor Opaniuk <igor.opaniuk@toradex.com>, Philippe Schenker <philippe.schenker@toradex.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Claudiu Beznea <claudiu.beznea@microchip.com>, Fabio Estevam <festevam@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Kevin Hilman <khilman@baylibre.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Maxime Ripard <mripard@kernel.org>, NXP Linux Team <linux-imx@nxp.com>, Nicola


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2020 at 01:40:28PM +0200, Oleksandr Suvorov wrote:
> On Thu, Mar 19, 2020 at 1:00 AM Thierry Reding <thierry.reding@gmail.com>=
 wrote:
> >
> > On Tue, Mar 17, 2020 at 10:00:42PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > Hello,
> > >
> > > On Tue, Mar 17, 2020 at 06:40:43PM +0100, Thierry Reding wrote:
> > > > On Tue, Mar 17, 2020 at 02:32:25PM +0200, Oleksandr Suvorov wrote:
> > > > > The polarity enum definition PWM_POLARITY_INVERSED is misspelled.
> > > > > Rename it to PWM_POLARITY_INVERTED.
> > > >
> > > > It isn't misspelled. "inversed" is a synonym for "inverted". Both
> > > > spellings are correct.
> > >
> > > Some time ago I stumbled about "inversed", too. My spell checker does=
n't
> > > know it and I checked some dictionaries and none of them knew that wo=
rd:
> > >
> > > https://www.lexico.com/search?utf8=3D%E2%9C%93&filter=3Ddictionary&di=
ctionary=3Den&query=3Dinversed
> > > https://de.pons.com/%C3%BCbersetzung/englisch-deutsch/inversed
> > > https://dictionary.cambridge.org/spellcheck/english-german/?q=3Dinver=
sed
> > >
> > > https://en.wiktionary.org/wiki/inverse#Verb mentions "inverse" as a v=
erb
> > > having "inversed" as past participle.
> >
> > Here are the first three results from a Google query:
> >
> >         https://www.yourdictionary.com/inversed
> >         https://www.dictionary.com/browse/inversed
> >         https://en.wiktionary.org/wiki/inversed
> >
> > > Having said this I think (independent of the question if "inversed"
> > > exists) using two similar terms for the same thing just results in
> > > confusion. I hit that in the past already and I like it being address=
ed.
> >
> > I don't know. It's pretty common to use different words for the same
> > thing. They're called synonyms.
> >
> > > > And as you noted in the cover letter, there's a conflict between the
> > > > macro defined in dt-bindings/pwm/pwm.txt. If they end up being incl=
uded
> > > > in the wrong order you'll get a compile error.
> > >
> > > There are also other symbols that exist twice (GPIO_ACTIVE_HIGH was t=
he
> > > first to come to my mind). I'm not aware of any problems related to
> > > these. What am I missing?
> >
> > There's currently no problem, obviously. But if for some reason the
> > include files end up being included in a different order (i.e. the
> > dt-bindings header is included before linux/pwm.h) then the macro will
> > be evaluated and result in something like:
> >
> >         enum pwm_polarity {
> >                 PWM_POLARITY_NORMAL,
> >                 1,
> >         };
> >
> > and that's not valid C, so will cause a build error.
> >
> > > > The enum was named this way on purpose to make it separate from the
> > > > definition for the DT bindings.
> > >
> > > Then please let's make it different by picking a different prefix or
> > > something like that.
> >
> > Again, seems to me like unnecessary churn. Feel free to propose
> > something, but I recall being in the same position at the time and this
> > was the best I could come up with.
> >
> > > > Note that DT bindings are an ABI and can
> > > > never change, whereas the enum pwm_polarity is part of a Linux inte=
rnal
> > > > API and doesn't have the same restrictions as an ABI.
> > >
> > > I thought only binary device trees (dtb) are supposed to be ABI.
> >
> > Yes, the DTB is the ABI. dt-bindings/pwm/pwm.h is used to generate DTBs,
> > which basically makes it ABI as well. Yes, the symbol name may not be
> > part of the ABI, but changing the symbol becomes very inconvenient
> > because everyone that depends on it would have to change. Why bother?
> >
> > My point is that enum pwm_polarity is an API in the kernel and hence its
> > easy to change or extend. But since that is not the same for the DTB, we
> > need to be careful what from the internal kernel API leaks into the DTB.
> > That's why they are different symbols, so that it is clear that what's
> > in dt-bindings/pwm/pwm.h is the ABI.
>=20
> Thierry, I see the PWM core converts the bit field "third cell" into
> the polarity variable.

Yes. And if there were other fields in that third cell, there'd be other
variables that would be derived from those.

> Now I probably understand your sight and agree that we shouldn't give
> the same names to bits in bitfield (dts) and values of a variable.
>=20
> But there are lots of useless "0" values of third cell of "pwms"
> option in dts files.

These aren't useless 0 values. 0 doesn't mean "don't care", it's a very
specific value. In this case it implies that the polarity is "normal".
That's very useful if you have a PWM controller that can set the
polarity.

> I see 2 ways now:
> - just remove all "0" "third cell" from "pwms" options in dts files. I
> see this "0" confuses some people.

Some drivers already do this by supporting 2-cell and 3-cell specifiers.
Not everyone does this and they shouldn't need to. The bindings are very
clear about what to do with that third cell and how to parse it. It's
just a matter of reading and understanding the bindings. It's not
exactly rocket science, so why do we have to jump through hoops to try
and simplify it?

> - convert pwm_state.polarity into pwm_state.flags and use bitfield
> directly from dtb.
>   It simplifies the parsing logic and makes adding new flags easier.

And then you have to go and and parsing code everywhere to deal with
these new flags. I prefer to have this parsing code in the core where
it's written once and used everywhere, instead of letting drivers deal
with flags that they might interpret wrongly.

Also remember that the third cell may be extended in the future and not
all data in in may end up being a simple flag.

Thierry

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5zoVoACgkQ3SOs138+
s6GF8hAAueYffxg4JcWpgobT34nhiDqMSTOKHVTV/wvgrao1j94NHjRPJGiDgro8
Tg1rglamXAo0tCFkl7O8G8T6bTb4Yw0TL8FUxzqLbdhjOlNccza7tMrKWciQpbbK
+IJE9sFMdAFlQD29X0SFHC0qJtt01uIplbBNhbZtFWyYEzBSgYS6eSgk41Ju+LRO
PipH/r6gAVcMwssL5yK5jHtoq2JRoI8FHG/SGh/Henl+ldpcKPbLPTmKnR9PZf58
sEsk7AkSkXHnENxSvHrn77SQJ0ur4LxRnFOqFzj/j2XCW0OpFNbiQnYOOo0YatZh
E08sB7uJ1g2lGwpPBir9Z0mSwJyhLSDsOZgEmSz/MCqwJFfzVOm9Q1psqzJygY6D
8METmjXAwMZ0LkXiwtV8xQlQAGhaTWTxupfSUcj4QOgacmSPuC7bX3Ed9wsztPrx
GO0e7D62wvuqRW45o5wPmoXTMO9omp7Q7mjG7yM6bjCn/XOXyvsV013lk5qj8P4A
jQKISE5GXapK7uuSOpvYZP2MHWM5ti8NqBzYdKxYzelYN9jDfP6PddXguUAkZGch
EDaFlVsvvFvSjJWymr9YnvWyVjRD/YibJDsieQoQcFI1lDgJnoKkLPXW/BzRFnnI
XwcJgzoyJm6fVY+gyOmJ45gqPM2dLbBgT5HsmbaDP44S+uVt5KY=
=SgdP
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
