From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH] backlight: pwm_bl: Fix condition to set enable gpio as
 output
Date: Sat, 22 Apr 2017 15:00:35 +0200
Message-ID: <1492866035.1768.3.camel@paulk.fr>
References: <20170416103546.3021-1-contact@paulk.fr>
         <CAMuHMdV1+caNwbuk=Kw7cRUxcp1iC=YArnQXf2mcn+qnc6+OOQ@mail.gmail.com>
         <1492443526.12267.4.camel@paulk.fr>
         <CAMuHMdVLUmT_NJt86tspYEZnsFEiEwiNu_19RQu0qhtcyP1SdQ@mail.gmail.com>
         <1492505196.2014.0.camel@paulk.fr>
         <e5a9e6ce-b1dd-96ae-c051-60be7cbfbe1d@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-gbyA9w8WJqjznjENtKeY"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from gagarine.paulk.fr ([109.190.93.129]:60030 "EHLO
        gagarine.paulk.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1043944AbdDVNCR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 22 Apr 2017 09:02:17 -0400
In-Reply-To: <e5a9e6ce-b1dd-96ae-c051-60be7cbfbe1d@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-tegra@vger.kernel.org


--=-gbyA9w8WJqjznjENtKeY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le jeudi 20 avril 2017 =C3=A0 10:55 +0100, Daniel Thompson a =C3=A9crit=C2=
=A0:
> On 18/04/17 09:46, Paul Kocialkowski wrote:
> > Hi,
> >=20
> > Le lundi 17 avril 2017 =C3=A0 21:36 +0200, Geert Uytterhoeven a =C3=A9c=
rit :
> > > On Mon, Apr 17, 2017 at 5:38 PM, Paul Kocialkowski <contact@paulk.fr>
> > > wrote:
> > > > Le dimanche 16 avril 2017 =C3=A0 22:55 +0200, Geert Uytterhoeven a =
=C3=A9crit :
> > > > > On Sun, Apr 16, 2017 at 12:35 PM, Paul Kocialkowski <contact@paul=
k.fr>
> > > > > wrote:
> > > > > > The move to a dedicated pwm_backlight_initial_power_state funct=
ion
> > > > > > in
> > > > > > commit 7613c922315e308a6486d802abed2eb74443dffd modified the
> > > > > > condition
> > > > > > to set the enable gpio as output. This breaks specific use case=
s
> > > > > > using
> > > > > > that GPIO, such as tegra124-based nyan Chromebooks where backli=
ght
> > > > > > stopped working.
> > > > > >=20
> > > > > > This puts the condition back to the way it was before the move.
> > > > > >=20
> > > > > > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > > > >=20
> > > > > Does "[PATCH v2] backlight: pwm_bl: Fix GPIO out for unimplemente=
d
> > > > > .get_direction()"
> > > > > (https://lkml.org/lkml/2017/4/4/225) fix your issue?
> > > >=20
> > > > This definitely solves the issue!
> > > >=20
> > > > Since this fixes broken backlight (that, in turn, makes systems
> > > > unusable),
> > > > perhaps this should be included in the next rc cycle?
> > >=20
> > > You mean v4.11 final, as there probably won't be another rc?
> > > Yes!
> >=20
> > I'm all for it!
>=20
> Thanks for keeping our attention on this. I sent a PR yesterday (and=C2=
=A0
> hope my GPG key has attracted enough signatures).

Thanks for acting fast and getting this merged already. This is greatly
appreciated!

Cheers,

--=20
Paul Kocialkowski, developer of free digital technology at the lower levels

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-gbyA9w8WJqjznjENtKeY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlj7U/MACgkQhP3B6o/u
lQwX/A/+JbDJmBgnnab3JGdjnC1veF3ROcsNLnb8GBsML770SCaMl3+tVadFSQuj
bW87g/3TC/Bh4hcryQD3sS9s/+1S3WsB6bef5nZU1o9jpAk/h3YmTc4+aBvjDdW/
C3HzBfo30kRrHa6nXWzosRs2KdLvoT1wWeEIto7xRJNFmGGJSoBjSTFKCiKXvEVS
uFc/FXQTRLoRptXEczuU7dBHbq5VaLEWXojakT42RdXxqoOxfW22gQZ2op9iwOon
tO0dKcMuDcI1R/h4ZCQz1RusK9uGiwksclWVCC+tJCXrsMmdP9PAD27VMdLeo2A4
a+13fOP/6SqOwJFcNEpsxhDAorwlC9oB4vgLAF7YCp4X2C3mutvB11Ym+RHrsf4i
CtsKABm4qBQZRLNSlhyX/57CnaOSjYx2QOqi6W2+pFJU6Jkk2aJGvqvA0Fg/dvFx
7HeH/tQQxyBzziy7oX9loy80IOnHkssCQwmlDbEl881Ls7grSl/GzDKUTMo4qW/2
7+zQOHribtsFFvG73BVttWPus1EYxP6LNbrtds7SNCOiWBnsZGEsv6yB5gCjS869
1s1DMKPrr2HToKrWiTn3yyhhalogm5+5RcdJdAhkjFNf34AdWAQ3qPesEZQZKwmL
V4RrdG6S7562tXNN6f+yDeLR/6Wp/4bN9pEjl/Z+jiyZ50sS1gU=
=AEc7
-----END PGP SIGNATURE-----

--=-gbyA9w8WJqjznjENtKeY--
