From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] backlight: pwm_bl: disable PWM when 'duty_cycle' is zero
Date: Mon, 6 Jun 2016 15:02:21 +0300
Message-ID: <5755664D.5070109@ti.com>
References: <1465209896-10319-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kNuhR8o4WgBv2Rl2lSIDJivXn71Fon0ro"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39561 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751081AbcFFMCi (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 6 Jun 2016 08:02:38 -0400
In-Reply-To: <1465209896-10319-1-git-send-email-LW@KARO-electronics.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW@KARO-electronics.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org

--kNuhR8o4WgBv2Rl2lSIDJivXn71Fon0ro
Content-Type: multipart/mixed; boundary="U29awtVD8qFXqbilhIq0eSj4vCNXjmApt"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW@KARO-electronics.de>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Message-ID: <5755664D.5070109@ti.com>
Subject: Re: [PATCH] backlight: pwm_bl: disable PWM when 'duty_cycle' is zero
References: <1465209896-10319-1-git-send-email-LW@KARO-electronics.de>
In-Reply-To: <1465209896-10319-1-git-send-email-LW@KARO-electronics.de>

--U29awtVD8qFXqbilhIq0eSj4vCNXjmApt
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 06/06/16 13:44, Lothar Wa=C3=9Fmann wrote:
> 'brightness' is usually an index into a table of duty_cycle values,
> where the value at index 0 may well be non-zero
> (tegra30-apalis-eval.dts and tegra30-colibri-eval-v3.dts are real-life
> examples).
> Thus brightness =3D=3D 0 does not necessarily mean that the PWM output
> will be inactive.
> Check for 'duty_cycle =3D=3D 0' rather than 'brightness =3D=3D 0' to de=
cide
> whether to disable the PWM.

The binding doc does say:

  - brightness-levels: Array of distinct brightness levels. Typically the=
se
      are in the range from 0 to 255, but any range starting at 0 will do=
=2E
      The actual brightness level (PWM duty cycle) will be interpolated
      from these values. 0 means a 0% duty cycle (darkest/off), while the=

      last value in the array represents a 100% duty cycle (brightest).

 Tomi


--U29awtVD8qFXqbilhIq0eSj4vCNXjmApt--

--kNuhR8o4WgBv2Rl2lSIDJivXn71Fon0ro
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXVWZOAAoJEPo9qoy8lh71rlUP/1LZ7du57I/I2DqYuSQt+rzB
7Qjmu5i0Tr2XKLcX7Pxh3LgWETurlCvO0NILjjFbiBR8kr3rXVD9IcYx//cHAfWS
qbjZcSNFhPYoXmMMabBT8SfBzeYjIGZJvqcRrd/9Pthft55giTJlCbO0jldkgmmL
pou6sMM41YLY3024l5xeMtlD5qrh7WSUtzesDcyH/r0Nw3npwIQLz6frhz+MuZ3D
k4YwGnPDqG2g+Aj8uqLAiL76DboNrnYl67/PcckGOWRQEXYbY4BzZl/VwY+0SFIN
c9JfNFkQ253fFgO2F4NdL0pYsYktrkWw+YOqn2qPzQvISwOLsHrQe+BSGGRjbgmD
pBpihPOQtELqudH6HZSle3U5+FsKwW+9CD6YaMjX4e8PUkSURoBXEhj6SbY5e/cC
QlO5m2uckiTaSc4H/pccQCT/oQboHvCBYxaj3D9VgPbvRGzuZ0pVYOSeEOSVY596
KAXUTPOsciY9i5Xjj/46wSOlyH3EzKGW5gn9srcz+59pJXVJHtrezcrxEBWFGBj1
tKoEyPOyO/kH/LnI3iehEDztLPYWo+hcUrU1QL8tggnrbmvbl2EsFL84LiPYvng4
3WvrvIL+Cuy60OuszyTuB2GSi9kM+KVoht2ESkCb5NTUETU3AgslF/QhTb5R0Dmn
zqDKyCyfUtmch1+Pa/Hf
=ZpVl
-----END PGP SIGNATURE-----

--kNuhR8o4WgBv2Rl2lSIDJivXn71Fon0ro--
