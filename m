From: Alban Bedel <alban.bedel-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH V4] pwm: lpc32xx - Add a driver for the motor PWM
Date: Wed, 10 Sep 2014 17:59:41 +0200
Message-ID: <20140910175941.5c44837f@avionic-0020>
References: <1410363822-22151-1-git-send-email-alban.bedel@avionic-design.de>
	<12709842.iga6ki5KTS@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/aJF=_5+JtGBXXM7sPp4EzlU"; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <12709842.iga6ki5KTS@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

--Sig_/aJF=_5+JtGBXXM7sPp4EzlU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Sep 2014 17:51:36 +0200
Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:

> On Wednesday 10 September 2014 17:43:42 Alban Bedel wrote:
> > +- #pwm-cells: should be 3. See pwm.txt in this directory for a descrip=
tion of
> > +  the cells format. The only third cell flag supported by this binding=
 is
> > +  PWM_POLARITY_INVERTED.
>=20
> If you don't have multiple pwm outputs or programmable period, I would sa=
y it
> should use #pwm-cells=3D<1> and only pass the polarity.

There is 3 channel, so 3 PWM from the API POV, and the period is
independently programmable for each one.

Alban

--Sig_/aJF=_5+JtGBXXM7sPp4EzlU
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUEHVtAAoJEHSUmkuduC28D60QAJ1eKXrO7mgIgY3DdLIlwnF+
bNHWL3xLskfZFupQStfENDsbVRJl4xExXV1+Vt+TSEK2MwfpLrqZc3xlZdtCef+L
8z32nxviKn7DD1uac0oUzoNfedTDfqIaYi5q0Ty3NcdqxI/oX0QtjZjFxdqIPmhX
siGckYC1+GJGF5R6PsF3tk7zSd+cGxJT2XPiv+s0gqrKSk/seQnje1Ub8r2arnK/
Zq+NZ6kuQMt8xjy7Orl3EdTmR1IySl0TJfSk77wgvLHVbqXXP0AElr6WqBYSyR8z
Qi+5ojz2tIE8eOWYNYQd6tC4IijxdM9K+2b5sd8OhtCtFMzrkdYIg8JVhSsiVocy
1RuPxdEL5QHXp9FJjsMCh8nmNduE4nwajY89BlvyGj9lwd4Dy/qi436Nek+f++fL
FFHCuC5V059regqnJoh+ywHeU/qnDVo3KtmvmqikzZSXzPSRAaRdd6IuruRpUPtg
OiJNJimIX2E9SIavQKOVNphzfk8IhyHIutuP/jdg/8Dv0+IB9pljYb2KQ3kVrIxi
TZjYU5Ebl8bapJ08nwKeLo2eDXIA4TCZXg5+Ap4kFLF6DK5N0MA7fSR28diSViCT
OQprOHis0SU+NeL6Re+rRyrzaw8SE2RsgW7Q1qVoi6VtfzAbiJdj7wJAXXyTEMoc
n01TP8sDuKNcSZVPpk/V
=Nw3k
-----END PGP SIGNATURE-----

--Sig_/aJF=_5+JtGBXXM7sPp4EzlU--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
