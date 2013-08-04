Return-Path: <thierry.reding@gmail.com>
Date: Sun, 4 Aug 2013 13:03:47 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: Determining wich PWM to use
Message-ID: <20130804110346.GA20305@manwe>
References: <20130727101824.GA11956@sauron.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20130727101824.GA11956@sauron.fritz.box>
List-ID: <linux-pwm.vger.kernel.org>
To: Johannes Thumshirn <morbidrsa@gmail.com>
Cc: linux-pwm@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 27, 2013 at 12:18:24PM +0200, Johannes Thumshirn wrote:
> Hi list,
>=20
> I'm currently working on a pwm driver for the BCM2853 (the SoC used on the
> RaspberryPi). It has two PWM modules, so my question is, how do I determi=
ne
> which PWM to use in the .enable, .disable and .configure functions?

It depends on what you mean by "two PWM modules". Does it have one
controller with two PWM outputs or does it have two controllers with one
or more outputs?

If you have one controller with multiple outputs, which seems to be the
case looking at the driver, then the struct pwm_device's .hwpwm field
contains the per-chip index of the PWM channel.

> If someone wants to have have a look at the preliminary code (far from be=
ing
> submittable and only compile tested) it can be found here:
>=20
> https://github.com/morbidrsa/linux/blob/rpi-pwm/drivers/pwm/pwm-bcm2835.c

=46rom a quick glance that looks pretty good already. Feel free to send it
to the mailing list for review anytime.

> 2nd short question, is it considered good practice to encapsulate registe=
rs in
> structs? I've seen this a lot on powerpc code.

It's not very common. I certainly prefer the standard way of using
writel(value, base + offset) and readl(base + offset), or a variation of
that using driver-specific accessors such as you've done in the above-
mentioned code.

Thierry

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR/jUSAAoJEN0jrNd/PrOhGR4P/2ay4gqjgYRIoL1GFEeDgqJb
rnRWjIcWb0u8xJVEx1WF27Ac8a0U0dW0/x3MndjpGpoZrWbbgX68WHoPGelxQxAO
9Pm/ueNjcZ/s1vlJt1UEGTJK8WFjlEG1jUbohk8KG/ZRX7fCqJPgdUsZEccatk+s
j6mmNoojAVUBUtSoRJWqrjRUisLz+DCwva5Lla4jRGJ5Y2P1afboabC4FWEBFd9L
m/7t53u+0UpO6H69yPF1+I5qgV9CkscyyHMT8yBqSkCd6tJT1LQ+IvHU2LNcH5o+
3ueaaUEn+WU3S3EsV3lsBhWBEtj4/5kW1lXIjdc7Y8cI/2YnONs+Bydg6kLPIdcg
XGXWcp8bYoivLk4eid9VCuGEYi6/x6tpdck4iBsHnkssVEcT6X5WwModX5RSBywo
HFlKEjjtbycDygtess72KO76auRZFUoTVJNgDw/i1foLA2hGpn15eVnrdffd2WmN
X18b9AtQwGo3/rbv7ex5nfewD9zAM+RLq9RhAXSRsYYOokcMOx8J1UOrOPdKWgk8
8mfKzcZ8iB395huTcaFIXUqPN8IafNr7FThl4L54Ew8ALriujV3tPj4YBwRT+oAx
IqvfGSqJW4fEl3VoKM7aaCkdS73cO08vijTAZMgN4Q3obvRnjaDAM5gF4OicyLlx
5rpUDZC5c/efICmUrNeN
=HscI
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
