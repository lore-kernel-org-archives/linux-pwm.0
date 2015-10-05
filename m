From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 0/2] pwm: Broadcom BCM7038 PWM controller (v4)
Date: Mon, 5 Oct 2015 17:14:15 +0200
Message-ID: <20151005151415.GE27759@ulmo>
References: <1442274426-3507-1-git-send-email-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="maH1Gajj2nflutpK"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1442274426-3507-1-git-send-email-f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ariel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--maH1Gajj2nflutpK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2015 at 04:47:04PM -0700, Florian Fainelli wrote:
> Hi,
>=20
> This patch series add PWM support for the Broadcom BCM7xxx
> chips which feature one or more PWM controllers capable of
> output periods from 148ns to ~622ms using a combination of
> variable and fixed frequency settings.
>=20
> The controller does not support setting a polarity.
>=20
> This is based on Thierry's pwm/next branch.
>=20
> Florian Fainelli (2):
>   Documentation: dt: add Broadcom BCM7038 PWM controller binding
>   pwm: Add Broadcom BCM7038 PWM controller support

I've applied both of these patches with a couple of stylistic changes.

Thanks,
Thierry

--maH1Gajj2nflutpK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWEpPEAAoJEN0jrNd/PrOhPb8QALly2J8RcqCm9bMjFOKaPIA0
YnXd3reuz8w8ybIO3LC7hQ64c58mSGMX4gFpFLegyRMOE751dpL/0UHinmsK89rH
HmHFGlQrEvk2YAxkShevQz4lBS1wbi557F3v8LFRYs/hgqgPvofcv/2gQttbtpBh
tg3xkkWKwIuuMM7uBW7+gD0/Pgw5bxTD+P/6SWFt5B+AkuR82wQj1iNx/4/8FhMk
zpVdaiFb8GjslXjJtm+yIpaRlIPet2yeiJmW8F8iSxxLumz4/ufC55jctbtQzT32
TdMYYIsjLX27n8ha5epbYF2OTBc82+huRDtSMXxH0X+nk63swi+wv51qotQ7Ith+
HgNcxEIzKmE0VX6QJZua6qBLE+tNbdqZNEP2cWna22nNWVp+aXnRk0vq/szoAZJA
eMfRVnaYNr8tCr6XKnWvy545Xs4vEbSeGnwNz6m2d/OUB3g87MW8y+iTCxCd8aEL
0ss0BbQkzknSPXq3F/z1pRN5pDtClUlpyMEBteHazLo6i/zbAmYWrSAfXmo3jypA
K3BIhyb/qJpj6sKFIC/1wl6o8eGhh114dIWWnvnHNTkc5bbFdf0JMNhOUXCshxAv
2todUCOAyf952Thh2rhwXWgIfhZBvCequtyKiRXuYCKSS320vrB9TAEHznlsFUFm
7HJKJw3am+HpGRiEwfoy
=+uEP
-----END PGP SIGNATURE-----

--maH1Gajj2nflutpK--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
