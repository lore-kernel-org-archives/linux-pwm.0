From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: quck help on PDM DAC driver
Date: Mon, 22 Sep 2014 11:48:16 +0200
Message-ID: <20140922094814.GL1470@ulmo>
References: <CAC3mp02joXnMME8WWq0jrT5fm5SUMkJ15H_DC3Oaz=y9C_DyCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yaPAUYI/0vT2YKpA"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:41276 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664AbaIVJsS (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Sep 2014 05:48:18 -0400
Received: by mail-we0-f173.google.com with SMTP id x48so1143421wes.32
        for <linux-pwm@vger.kernel.org>; Mon, 22 Sep 2014 02:48:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAC3mp02joXnMME8WWq0jrT5fm5SUMkJ15H_DC3Oaz=y9C_DyCw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Naidu Tellapati <naidu.tellapati@gmail.com>
Cc: linux-pwm@vger.kernel.org


--yaPAUYI/0vT2YKpA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2014 at 04:15:42PM +0530, Naidu Tellapati wrote:
> Hi Thierry and all,
>=20
> Many thanks in advance. My name is Naidu Tellapati. I am from India.
>=20
> The Pulse Density Modulation DAC which we have on our SOC produces a
> form of analogue output according to the relative density of output
> pulses to the intended analogue signal amplitude. The 4 PDM outputs
> are provided that can be used to control targets such as an LCD
> backlight. After going through Linux PWM documentation, I understand
> that our PDM DAC driver does not exactly fit into the Linux PWM
> framework.
>=20
> The PDM DAC block takes only input clock and a 12 bit value (as input
> pulse) configured in one of the SOC configuration registers as an
> input and based on some simple internal logic, the block produces a
> form of analogue output according to the relative density of output
> pulses to the intended analogue signal amplitude. The PDM DAC block
> won't take duty_cycle as input configuration parameters. Instead it
> takes 12 bit value (input pulse) as a configuration parameter.

What does this 12-bit value represent? It sounds to me like it's exactly
what the duty-cycle is for other devices. And if it's the only parameter
then it seems to me like the device simply has a fixed period.

Both of the above should be possible to do in the current PWM framework.
For example, you could compute the period (in ns) of the PDM based on
the input clock frequency and inter/extrapolate the 12-bit parameter to
range [0..period].

You can also add checks to refuse setting a period in pwm_config() that
doesn't correspond to the fixed period derived from the input clock.

Thierry

--yaPAUYI/0vT2YKpA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUH/BeAAoJEN0jrNd/PrOhjPoP/Re0EdKd05XDKWdCWQXHXdB0
4TuIukARHnASdd8HXXAfNP6SOWFixKeIM/kBwuGVubt5mlV4b2LG29x1Em+RJ7NH
aPItqVA7G6gPKvC9Dx1QLCNgrvrlZOZdg3JWUee93L9qQezTY8lF6w7TBuOButL+
t6N3+3HWF0m0vHP76e9vsapkbx0M3zaf0E1xNFtoux9V7CCgc2uTi5Imgo591J8y
WTV92sht5Qs8va0E3/I2SNS3l5+hQvXwxNaaTmZGYozG/wk/OLMwly/GY9nn9x/B
eppu1d+CVZDsYnbvhoHzYueLvBMa05AFegMWHMqH6exndunCOlJnHlFc+g3h2PDr
HUMez3awVjs7YKEyJHhJYHS59OmyR7OyK1vAqdMhlCyCLYWN4w0rZm7uakIajX0A
VcHSb9xXdcUElmb+6ut/kZvRJj3rPkt0O6Ty3m3SeSaUjXxlVeXXtaO6e/ePKXK9
TOtzWY6qAaiyP1lfLaPgg8KvZLfwXF8LJGHqI71Jrl9rCgaRuCL+QMjSpgT11Ac1
KeDb1Lh7+xKmv0DPcoovNHlpxXKVOyHUEP5SNMTcAgUv+WsiEtbmBDgGWVPKjlK+
uylGSKoQsTnttVdC2riEbXyZIJtD3Bmt7Pm/+ePqdPUOgyUtBoG4IE3UZTf2kEYi
IOC4PlJR3EcVlwih+6W8
=rwPo
-----END PGP SIGNATURE-----

--yaPAUYI/0vT2YKpA--
