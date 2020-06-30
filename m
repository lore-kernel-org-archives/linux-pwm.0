From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: [RFC PATCH 00/10] Netronix embedded controller driver for Kobo
 and Tolino ebook readers
Date: Tue, 30 Jun 2020 09:15:23 +0200
Message-ID: <20200630071523.GA2983@latitude>
References: <20200620223915.1311485-1-j.neuschaefer@gmx.net>
 <20200630084051.66feadea@aktux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200630084051.66feadea@aktux>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Pengutronix Kernel Team <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>, Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko.stuebner-SN7IsUiht6C/RdPyistoZJqQE7yCjDx5@public.gmane.org>, Stephan Gerhold <stephan-3XONVrnlUWDR7s880joybQ@public.gmane.org>, Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2020 at 08:40:51AM +0200, Andreas Kemnade wrote:
[...]
> got a chance to test it on a Tolino Shine 2 HD.
> It uses the RTC from the RC5T619 but backlight seems to go via MSP430
> EC.
>=20
> I got this.
>=20
> [    1.453603] ntxec 0-0043: Netronix embedded controller version f110 de=
tected.
> [   10.723638] ntxec-rtc 21a0000.i2c:embedded-controller@43:rtc: register=
ed as rtc0
> [   10.775276] ntxec-pwm: probe of 21a0000.i2c:embedded-controller@43:pwm=
 failed with error -5

Hmm, -EIO from the PWM driver.

> [   10.850597] ntxec-rtc 21a0000.i2c:embedded-controller@43:rtc: hctosys:=
 unable to read the hardware clock
>=20
> version number matchess with what the vendor kernel reports. Maybe we
> should document which version is running on which devices?

Good idea, I've added a table to the wiki page:

  https://github.com/neuschaefer/linux/wiki/Netronix-MSP430-embedded-contro=
ller



Jonathan

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl765oMACgkQCDBEmo7z
X9t4uQ//adw6WbhVY/ljNdI6evIOpehnVPm4JcX+Cq+FRgwzpcWAMvdXvmonOM86
Gjy7liAoNDczuxg7kdDhCRwIVANhi3jHJeeeHqzUnki8TSvnWS1iu5xGWOx1RRWj
YbwARZIU2L37uPys5ByF4RoqKp1tngfhL9B9o+e93x8RB16dxACG2qEb7Hdr55qI
/lwk2zuuHwqdxOOGSVFrD40GA52Xc/nn3wr1orqxOIE0k8pOEslBiXq7MW+nKROZ
Cdc1zGpqWnSlRc04jm1da1oJmmqZPCtiK7rMZcY98sbJgmdSflP2R5raXNggdBNQ
jNmRTSsBIxYkdK6+3W3Fl/m8RMJe6gwKaQIqYu69gZbsrm8Ap826po3CkCve4kCJ
w4mYJAxQfI34OrIga4mHru+qnFJEgMPkHwTI98LK7YHJT1ecWn8Ucblxd2dUQlGO
TCcQL//WWRiD73DJ+vd0NstsmvgMSlnUGgmWcCGjEIR0sM3e7DquHbfeDoaSeV58
ALjTBcTcoSyWKFMSO+3iws/kqmW3VlpHRqQrzRaiU9LqluBgK8PKXOopityTqG8K
Mu7yTDOrFwJO2q1kNJP45cpl/2JBpK23MAMFo2U78IvhhjMeKe15m2P79z+fbUAZ
ASFT4XWCVS+Ovv5HwrLoWdrTzNUYi50bl9vFimShNFr5qC9xCWM=
=ozP0
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
