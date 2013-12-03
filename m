From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH RESEND v5 1/2] PWM: PXA: add device tree support to PWM
 driver
Date: Tue, 3 Dec 2013 11:17:15 +0100
Message-ID: <20131203101714.GG21178@ulmo.nvidia.com>
References: <1379791174-2369-1-git-send-email-mikedunn@newsguy.com>
 <1379791174-2369-2-git-send-email-mikedunn@newsguy.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p7qwJlK53pWzbayA"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ea0-f173.google.com ([209.85.215.173]:55521 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019Ab3LCKSM (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 3 Dec 2013 05:18:12 -0500
Content-Disposition: inline
In-Reply-To: <1379791174-2369-2-git-send-email-mikedunn@newsguy.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mike Dunn <mikedunn@newsguy.com>
Cc: linux-pwm@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chao Xie <chao.xie@marvell.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>


--p7qwJlK53pWzbayA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 21, 2013 at 12:19:33PM -0700, Mike Dunn wrote:
> This patch adds device tree support to the PXA's PWM driver.  Nothing
> needs to be extracted from the device tree node by the PWM device.
> Client devices need only specify the period; the per-chip index is
> implicitly zero because one device node must be present for each PWM
> output in use.  This approach is more convenient due to the wide
> variability in the number of PWM channels present across the various PXA
> variants, and is made possible by the fact that the register sets for
> each PWM channel are segregated from each other.  An of_xlate() method
> is added to parse this single-cell node.  The existing ID table is
> reused for the match table data.
>=20
> Tested on a Palm Treo 680 (both platform data and DT cases).
>=20
> Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
> ---
>  Documentation/devicetree/bindings/pwm/pxa-pwm.txt | 30 +++++++++++++
>  drivers/pwm/pwm-pxa.c                             | 52 +++++++++++++++++=
+++++-
>  2 files changed, 81 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pxa-pwm.txt

Hi Mike,

It looks like this fell through the cracks. Is this patch still the
latest one you have? Should it still be applied?

Thierry

--p7qwJlK53pWzbayA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSna+qAAoJEN0jrNd/PrOhEN0P/j/R50+IlIwPL9vuovuV1xj3
SZJ0gRHT1PXnytE1PFB5+HIbreYhSQTQ79hfYfxSdYi5h2KVcxLneSEkfGYLLAj9
J70ju3wlKflwYtAp06ssXKxIUVnvYk8kVUxgjpzbq7cMEhHelAvLpcKqD6TnAfIn
3z8y6ZtzcuzsRHIahFTdB75Kb+tjkWfgLOxDfFUTwzU01xaLDNFIZzU4ngF4Rtqz
gxXqTKSFDDvsCn5LHgqOxhjSQdA24x7Q+Nc6oMe/XsB0u1HfmuSb+vU7mmaYrMM4
1ASzxjfTaBHfArx4u2CdjOI+Or/6nlJdknKc1wc/hbFoTTjsuuNZHtQyifFpy2mh
xg6h05QWJLr/SSckWtkjQ377CSqwvg88Jzlr3TTAtywmuIrNvS2mxt2IgdHZLMKT
pjlYZhrp4KqlZVwrXgHbO0FL7tpn7BphFD6L9JcwBOYcoxiO/ATuQ3rQ4esRHF6V
o3lj7JvJFQ/Nla0blL+awexm+sNpwKh1ru6lCGe6naT2IFK4I7TGiu3rc0WLvDG4
cFxf8z907/1ZS4PmBfhb0dUMcupLJS92PMboyO+lLW3FnkU7rHFihfXFIGq9ezuu
cAiIs/z0kfhcEYOUjmfQG2UAZLEwT2GU7q4I+0Ra+KrWHZdljev8IiSwQ/ETRIbS
m8leBaf+QWNUiWkeGsvI
=YbHE
-----END PGP SIGNATURE-----

--p7qwJlK53pWzbayA--
