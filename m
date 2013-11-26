Return-Path: <thierry.reding@gmail.com>
Date: Tue, 26 Nov 2013 16:48:59 +0100
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RFC] backlight: pwm_bl: usage of regulators for turning on of
 backlight.
Message-ID: <20131126154858.GA27808@ulmo.nvidia.com>
References: <5294ACE1.9020008@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <5294ACE1.9020008@ti.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: jg1.han@samsung.com, linux-pwm@vger.kernel.org, Felipe Balbi <balbi@ti.com>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2013 at 07:44:57PM +0530, Sourav Poddar wrote:
> Hi,
>=20
> This is in regards to the following patch[1] in 3.13-rc1 kernel..
>=20
> Should not the usage of 'regulator_enable' should be optional?

No, it shouldn't.

> Without a power-supply node in dts, backlight entires does
> not get populated,

That seems to be a bug in the regulator framework. See here[0].

Thierry

[0]: http://www.spinics.net/lists/arm-kernel/msg288215.html

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSlMLqAAoJEN0jrNd/PrOhRAkP/ipkJDD0xq2AQk7SJ60up/oo
72yTVB8NsODbOQfWCK++PCRHi25J7WQCGdlWgbwsfVwNzsI2G8uvqgtWmeAKskof
5hbLpNOSRd02UdQ+fTw6dNMj4cbRIg/qxgRRMYeR7bboVH/rSCSvM6NOio4Zot4M
ZQKhqy1zNWWFCW0sokkpJccPAwUitec81lE8tQMYOm8KzFTDQAuahADxYd6QBuzR
kwzaIGMjGeYF6W+LXxWLZE3TkNNa6T0WT8VCpyzE6oICC04/IoPURChjYIIxZHHr
Z1gEoer+WC+53Cwi6UlLF0XXWQ+EOTRdaJmmUlmSqIHHJj0Pe2GwxiD7PkfeFMsT
7RaAlbq6uVCbCz1130UJbm35jJwIzkYetjc4h/S++UE9LGY6dImnAZmcjS3Tuxn+
+j7WYfkLYvZetIESRu7rZjJUFxTTsFjLd6izJVMD7ZNkFTQwYc6FGzGCjEk7P2b3
4RLy3ZbODJye1nWTvYQPymkGNmgd2pf8exkmW7FihkX1OWXPrCfb5V1yKdMcafAO
ie4VE9+TWCD7vNjYHpEzWGAkvalfkc29ecyOj5GeFWHcPPIUATE3QkIGmKGTke3r
HkBt/jetCxRERDEZfvuhtKGu3J4hQfA0UxGkrIL4YQKRKDM5TO6eTsLe5xCysHQH
anwRpW9MQZwxK0ZqNK8N
=F6q0
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
