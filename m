From: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Subject: Re: [PATCH] backlight: pwm_bl: Fix condition to set enable gpio as
 output
Date: Mon, 17 Apr 2017 17:38:46 +0200
Message-ID: <1492443526.12267.4.camel@paulk.fr>
References: <20170416103546.3021-1-contact@paulk.fr>
         <CAMuHMdV1+caNwbuk=Kw7cRUxcp1iC=YArnQXf2mcn+qnc6+OOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-CtD7ssR0i9DXtq8WomxN"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdV1+caNwbuk=Kw7cRUxcp1iC=YArnQXf2mcn+qnc6+OOQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linux PWM List <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--=-CtD7ssR0i9DXtq8WomxN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le dimanche 16 avril 2017 =C3=A0 22:55 +0200, Geert Uytterhoeven a =C3=A9cr=
it=C2=A0:
> On Sun, Apr 16, 2017 at 12:35 PM, Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org> wr=
ote:
> > The move to a dedicated pwm_backlight_initial_power_state function in
> > commit 7613c922315e308a6486d802abed2eb74443dffd modified the condition
> > to set the enable gpio as output. This breaks specific use cases using
> > that GPIO, such as tegra124-based nyan Chromebooks where backlight
> > stopped working.
> >=20
> > This puts the condition back to the way it was before the move.
> >=20
> > Signed-off-by: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
>=20
> Does "[PATCH v2] backlight: pwm_bl: Fix GPIO out for unimplemented
> .get_direction()"
> (https://lkml.org/lkml/2017/4/4/225) fix your issue?

This definitely solves the issue!

Since this fixes broken backlight (that, in turn, makes systems unusable),
perhaps this should be included in the next rc cycle?

Cheers!

--=20
Paul Kocialkowski, developer of free digital technology at the lower levels

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-CtD7ssR0i9DXtq8WomxN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlj04YYACgkQhP3B6o/u
lQwn7Q/+N9vmCWl3gxixdLDLxRguK49d2NsspLp+j+0hr9P3ZyABbgNRQEobu4iX
co+eb67SKgcIryEjuikKstTruHv291N6HtlZ9eQnmFjfKMbDFseIfBq9RQ1vRX3/
X1rKeifqfRBrDYR+PS16HtWv446stXe4Ta8yTJ0pR1n+h00SjhWxNIEJmUda/lZ0
n7ccxKVFvEGFxGLfj1GXDNP80N9Rb8OlDX1nWfgMuMWMKU1beMjmocLfGqXoMy4k
fr+5CpZhPGwvjMc/7C4dGRCgUwbRkfwKFHxsHMuy5Yf/r7u4kA4pVLNa3bnpPleL
tvExZ8nBdL5MnbuwBuSKEHYugq3kBR+qgG1xRL6trCNUGpMkpVTYtBQYei6fBOdX
i5piOkbVb9Q0ymcNjgwa6YOJUI5a4BEf+3siSNSu6L4aP55QENMzoxoWCJjmOSfE
VNK+zHrDgqf6ofkk0FWysDjt48Izbn/SfksPgDEFe5xDYkV5lmtvd5eCx7ZVVIiw
SepdqDrzupvQMMfN/x8+Rc8fypCCQGR9tSe2p+DgIqKzUJaJJ+NIFTXFli6Gkct2
xV80M61B+Zkw2lqCfn+3WABoblQPKLDeeNWDbV2cktj5/o9BBnLSypputR8NTibm
BpQXeCkeYtk2MAuniNYUwwl7xRceSUQgjZeMnCtQUYISKCxby9g=
=yHIX
-----END PGP SIGNATURE-----

--=-CtD7ssR0i9DXtq8WomxN--
