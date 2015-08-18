From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC PATCH] pwm: add TLC59108/TLC59116 PWM driver
Date: Tue, 18 Aug 2015 17:58:15 +0300
Message-ID: <55D34807.2020609@ti.com>
References: <1439905927-27861-1-git-send-email-tomi.valkeinen@ti.com> <1439905927-27861-2-git-send-email-tomi.valkeinen@ti.com> <20150818141959.GF4381@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4QKMbfPI5ct9978I02dwKcqFsF0trCV7l"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49808 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752588AbbHRO6a (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Tue, 18 Aug 2015 10:58:30 -0400
In-Reply-To: <20150818141959.GF4381@lunn.ch>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-leds@vger.kernel.org, Jacek Anaszewski <j.anaszewski@samsung.com>, Bryan Wu <cooloney@gmail.com>

--4QKMbfPI5ct9978I02dwKcqFsF0trCV7l
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 18/08/15 17:19, Andrew Lunn wrote:

>> +Required properties:
>> +  - compatible: "ti,tlc59108-pwm" or "ti,tlc59116-pwm"
>> +  - #pwm-cells: should be 2. See pwm.txt in this directory for a desc=
ription of
>> +    the cells format.
>> +  - reg: physical base address and size of the registers map.
>=20
> Cut and paste error. Reg is the i2c address.

Oh, right. Thanks.

>> +static int tlc591xx_pwm_config(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
>> +			       int duty_ns, int period_ns)
>> +{
>> +	struct tlc591xx_priv *priv =3D to_tlc591xx_priv(chip);
>> +	unsigned val;
>> +	int r;
>> +
>> +	if (period_ns !=3D TLC591XX_CLK_PERIOD) {
>> +		dev_err(chip->dev, "only period of 10309 ns is supported\n");
>> +		return -EINVAL;
>> +	}
>=20
> The hardware does allow you to change the period, but there is only
> one clock generator for all the channels. If you are going to make the

Hmm... How does that work?

The per-led output is fixed 97-kHz. Then there's the group dimming
signal, which can be superimposed on all the individual outputs, with
fixed 190-Hz. Neither frequency can be tuned. And when using group
dimming, the output isn't exactly PWM anymore, but two PWM signals combin=
ed.

Is there some other setting I'm missing?

These group dimming features don't quite fit into PWM model, I guess.
Then again, I don't think LED framework offers any ways to utilize them
either.

> effort to try to model the hardware as a PWM, you should try to
> actually implement the PWM API. Let the first channel which calls
> config set the period, and return an error for any other channel which
> picks a different period.

If there is a way to set the period, I think it may be better to define
it in the TLC's DT data than by "whoever gets there first".

 Tomi


--4QKMbfPI5ct9978I02dwKcqFsF0trCV7l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV00gHAAoJEPo9qoy8lh71ijkQAIkUrST02f6aw8OdFk/UsWhe
v0a9y7LuFQkYgFBtOAr2ze8pda79dIdHS3tX+3FZNlrlD1dMokKv6SrWMe6ilJVM
UA+PYcOQRDPfMYa8cS6rMNO4yiXSoWE1x3L/55YpvCT281GqnEjfRNQuh7urjfkR
pksxdZThYvxXn4+lXkqnJg6nqVJ/QOLIE3IAbMy2e9Hcb9TZSmGAWfmFAD1Ozw5E
alPmHOeVZ/fIbECv0V7bwPSsR1Elu/BMlBBCCQ/VGElT9C8PaMP3uJc2Vbp3M87U
ynPx466B6ulkkaVFtufdyESaX4oV97GNxmajRiZWJo4WevkP3cFwAdEiuK7wTDba
WWX7XF1M/U1t6EDxf5B7sOOzL/hq9hnm4rCiWp1rlhDSRhb1tl9Z7fa9iYaMqECU
KGrDEv2ENtmGYEwXZcNOOcYd9E0o1t6eGfSlo76CVAKhvh0Xip984JsXj0gua1AL
TnWaXGPxqJVgiDoYaEZ3HA4ZhesCDl/IcZ1P1QPvw6RPCX+wmQoU5TlMoxD/uPS/
NJvFxjiKF/WYRfQU2RedirRvqRXX+63/ljMM5kzY9kJiEQlP5PyRp55ZTEbDSqiW
O7UV8uNpH1XLi5hteINq3INnG0UZFptflCI62u9lSjSAVp0LiLiMrfa2oXd3/I7n
YnjjUag10cDD3ZISO6Cm
=zPIE
-----END PGP SIGNATURE-----

--4QKMbfPI5ct9978I02dwKcqFsF0trCV7l--
