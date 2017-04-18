From: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Subject: Re: [PATCH] backlight: pwm_bl: Fix condition to set enable gpio as
 output
Date: Tue, 18 Apr 2017 10:46:36 +0200
Message-ID: <1492505196.2014.0.camel@paulk.fr>
References: <20170416103546.3021-1-contact@paulk.fr>
         <CAMuHMdV1+caNwbuk=Kw7cRUxcp1iC=YArnQXf2mcn+qnc6+OOQ@mail.gmail.com>
         <1492443526.12267.4.camel@paulk.fr>
         <CAMuHMdVLUmT_NJt86tspYEZnsFEiEwiNu_19RQu0qhtcyP1SdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-YRZad20UnWSB1u90ZlB1"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdVLUmT_NJt86tspYEZnsFEiEwiNu_19RQu0qhtcyP1SdQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linux PWM List <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Fbdev development list <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--=-YRZad20UnWSB1u90ZlB1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le lundi 17 avril 2017 =C3=A0 21:36 +0200, Geert Uytterhoeven a =C3=A9crit=
=C2=A0:
> On Mon, Apr 17, 2017 at 5:38 PM, Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org> wro=
te:
> > Le dimanche 16 avril 2017 =C3=A0 22:55 +0200, Geert Uytterhoeven a =C3=
=A9crit :
> > > On Sun, Apr 16, 2017 at 12:35 PM, Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org=
>
> > > wrote:
> > > > The move to a dedicated pwm_backlight_initial_power_state function =
in
> > > > commit 7613c922315e308a6486d802abed2eb74443dffd modified the condit=
ion
> > > > to set the enable gpio as output. This breaks specific use cases us=
ing
> > > > that GPIO, such as tegra124-based nyan Chromebooks where backlight
> > > > stopped working.
> > > >=20
> > > > This puts the condition back to the way it was before the move.
> > > >=20
> > > > Signed-off-by: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
> > >=20
> > > Does "[PATCH v2] backlight: pwm_bl: Fix GPIO out for unimplemented
> > > .get_direction()"
> > > (https://lkml.org/lkml/2017/4/4/225) fix your issue?
> >=20
> > This definitely solves the issue!
> >=20
> > Since this fixes broken backlight (that, in turn, makes systems unusabl=
e),
> > perhaps this should be included in the next rc cycle?
>=20
> You mean v4.11 final, as there probably won't be another rc?
> Yes!

I'm all for it!

Cheers,

--=20
Paul Kocialkowski, developer of free digital technology at the lower levels

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-YRZad20UnWSB1u90ZlB1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlj10mwACgkQhP3B6o/u
lQwSJg/9GlHtQ4xfmvn1wZDYCd+1b0T8K+5tZx4cReHsCoBkQbR6A5SfgqyeE7b2
ip7AYzVq6S82Jpe9DwV5kcGhN8gC+nJ4klmEr5892IjrjZILaemHr0vbE6OogiEs
YXHqgIOnwrHPUzZmKeCgM79qa0IgVlMj3+dep+jNvUiSip9IkJzH8OJfkTZKfZyK
pbE14u0y6b5RxfYomoAMfL0YAbSsWZk6xj8hWdzmAr+WtiWrc7ki6/rHSKxoessK
YAoNcnAZBP7i1S5DOSTp9VT6DtdHAz3jje+37K7XjbvphzW7aXzEaQOJXllqFIr7
zuF3Gg1rlXhgtITHZYfnB/hZS1uq+gFy9RIugI9Mb+AUEzSJchiTKFyy7n0kum8M
0i8xcNQ6O/2m1l4oiL1vzs7a4/NArZj0u+WRv1Zt+zfQYW1+XpTLvn+X2/wBDdER
u0xX38787JCAgdnKhvbyk7qH5Nc2gmeuoIwMgioh+LpFIsmIKVNkUbP5yzulfxNf
ckfYvMttC1q782ME2NiHqKPByQhl2j2NlAWIQJ4xtAw0gFACVDgvCX+ESkkPYGvB
Y4wmx1kYcspswZN8hokHi0qbumePOC0E6EbjXgcKNXymh07WF3JfQdEZcZ5vh3ad
FgorFMCfLDm+E7BS8XiwAyx0Wrc37R8u1Xk8pEtr8KA5U/f1gbg=
=dlne
-----END PGP SIGNATURE-----

--=-YRZad20UnWSB1u90ZlB1--
