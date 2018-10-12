From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 0/3] treewide: add vibrator support for various MSM
 SOCs
Date: Fri, 12 Oct 2018 13:47:49 +0200
Message-ID: <20181012114749.GC31561@ulmo>
References: <20180926235112.25710-1-masneyb@onstation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180926235112.25710-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Masney <masneyb@onstation.org>
Cc: linux-pwm@vger.kernel.org, andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jonathan@marek.ca, ctatlor97@gmail.com
List-Id: linux-pwm@vger.kernel.org


--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 26, 2018 at 07:51:09PM -0400, Brian Masney wrote:
> This patch set adds support for the vibrator found on various Qualcomm
> MSM SOCs. This is based on work from:
>=20
> Jonathan Marek from qcom,pwm-vibrator.c in the PostmarketOS repo:
> https://gitlab.com/postmarketOS/linux-postmarketos/commit/7647fb36cb1cbd0=
60f8b52087a68ab93583292b5
>=20
> Jongrak Kwon and Devin Kim from msm_pwm_vibrator.c in the downstream
> Android 3.4.0 sources:
> https://android.googlesource.com/kernel/msm/+/android-msm-lenok-3.10-loll=
ipop-wear-release/drivers/misc/msm_pwm_vibrator.c
>=20
> Driver was tested on a LG Nexus 5 (hammerhead) phone using rumble-test:
> https://git.collabora.com/cgit/user/sre/rumble-test.git/plain/rumble-test=
=2Ec

Looking at all of this it seems like this would be more appropriately
implemented as a force-feedback input device directly. The only reason
you seem to be making this a PWM driver is so that it can be used in
conjunction with pwm-vibrator. The device itself doesn't seem to be a
generic PWM in the way that the PWM framework expects it.

Thierry

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlvAieUACgkQ3SOs138+
s6Edag//XmsTS/HXwJuq0xpBLVXaiqwnPyZAd64I2AhPdhysIBxVktH/+Bj8+Rt4
XnRe3nksdvLciKBE2k88d4ZSVr2V3tyOHStXpQ9PS/7PhT7dzSfgXrlx4TtAiw86
lCttOns77DoI6aDMEHWaLHl5nfof0OUasE37zxC8TsJlDmZZF2YevVlkNIqZNaV/
htDNlMXOuldwpc6eqjRdQFgPF4jHpQBavFuUFy0rCxTzzwOoFxowWamA32BEUNT2
pNB6SrKjiZkhboGXNCOcWqTDfzPxUJayBWTMFswU73+HzVphpbSVylei7SS7qdcd
Uy7fM96A83eOQpwY1DKJUXoO8CA41ZRmtv5Ltu5WPwU6FeqzpnfFy/VWI2kIjhKP
5x/6Mtumh6AIRkIwUDPfiLhalGDvfkuV8MbduXyZrZptmLF4svWUgSxkhC6SClsx
rdwzj5PhVh9yLjhWHQYH95+dfaKOuw5/5CbON3VOl69msNCcaTP9asyL/MRDzGWe
G8RekvDWHgfqW07Ichp3BPK6tYpbmAgE5fn5zOGCU9kkz+6Soe43ajhJWK1tXuPZ
OGZEDdsOr60b+EKZg8Yi0+BYBbIjDEPBO47EC9SOs7shsLN6CreIJefm9o4FHyEY
IkLiNPsbeGCifxgl4Zk6835MabDBHaiQ6cu+javUoFzCqIRGVWU=
=yKT2
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--
