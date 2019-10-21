Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44788 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbfJUO1G (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 10:27:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id z9so14237623wrl.11
        for <linux-pwm@vger.kernel.org>; Mon, 21 Oct 2019 07:27:04 -0700 (PDT)
Date: Mon, 21 Oct 2019 16:27:01 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Message-ID: <20191021142701.GB1476994@ulmo>
References: <20191021105739.1357629-1-thierry.reding@gmail.com>
 <20191021111112.n24kme2va6net7g3@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
In-Reply-To: <20191021111112.n24kme2va6net7g3@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH 1/4] pwm: Read initial hardware state at request time
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pwm@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2019 at 01:11:12PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Mon, Oct 21, 2019 at 12:57:36PM +0200, Thierry Reding wrote:
> > The PWM core doesn't need to know about the hardware state of a PWM
> > unless there is a user for it. Defer initial hardware readout until
> > a PWM is requested.
>=20
> A side effect is that for an unused PWM the get_state callback is never
> called (which is good), in return it is called more than once if the PWM
> is requested more often (which is bearable).

You can't request a PWM more than once. PWMs are always exclusive to a
single driver. Now I suppose you could have a single driver request it
multiple times (that driver would then also have to release it before
requesting it again), but I think it's reasonable for the subsystem to
query the hardware state everytime before a PWM is handed to a consumer.
The hardware state could have changed between the time where a consumer
releases the PWM and another requests it.

>=20
> > As a side-effect, this allows the ->get_state() callback to rely on
> > per-PWM data.
>=20
> Given that this is the motivation for your change I'd give more stress
> to this part of the commit log. Also I think this could be more
> understandable if you point out that the effect is that .get_state is
> only called after .request was called successfully which gives the low
> level driver more freedom by (for example) relying on memory allocated
> there.

Isn't that pretty much already in the above commit message just with
different words? I can try to reword this in a different way if that
makes you happier.

> I assume you target the next merge window for this change?

Yes. I'm not sure yet about the remainder of the series. Depending on
what we decide to do about drivers that can't (or don't want to) write
all state through to the hardware, patches 2-4 may become moot.

Thierry

>=20
> Best regards
> Uwe
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2twDUACgkQ3SOs138+
s6FE/A//WLGShPijQImzdd+J5VI6y4yoMor5q0yxH+wpGAdrn/xpCP/4DE5Qsvfg
hBatD1ufGpLwsRIsBj1RuCRYFyQiJyrZuzP5Hc3suEQ2/IvVVeRJGIf6b39fZIW1
Eg9C4K6yqZSZLhS2ELAHXN/6uW8NeGeyVztj+TPU0EMTV1TUiFdgOlIOXtbRX8XN
QFSQJMTPLpxGEfqkZJdUhFVy20/TE7WcKWPc+pfIQO+iPe/Ugv8HESMx7272yOpv
VrbX/VX6BMMHBbPVOfdJ8lvjKZ4+hyV5bAFNlSo34jzzYX95/qFMtiMqTt1chfB2
K0pq98geOlwxEIGsYW++pPTKJjKIOd/n+IdZ0IdeW01DYmRtagJa8U8oTPEXCPfM
RMjpLdnuqIcxwFP33wERBowVuRWN7NasIZVon3OlnA8b6wk2fvVGvnYXvheJromb
n77uIAB2V2y/gCkM8ZZuG1dxE4wfZbwNuesuGVq9zKySOhgvmsr9/ULDitO107zt
U7VE3wAs97t7yBKpWCuB3qPmD4+d7jY2Yz7Jbr2/1MzGwLQ9g4kNj6qJ+ZW5bn40
Ecpp07Kufk3XR8HpWkWb76PiRlGQT7cvidAJy/X66Sm7ahuDLBJQeEDGpdFrVRUv
3qf69Gq/dmEqKD7JeX4s48cgzeBV5o9IWt+5+bdF1+DtfFGZt5c=
=QR6c
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
