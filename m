From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm:lpss: update pwm setting for Broxton
Date: Thu, 12 Nov 2015 13:52:36 +0100
Message-ID: <20151112125236.GD31671@ulmo>
References: <1447345684-108039-1-git-send-email-qipeng.zha@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33609 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbbKLMwi (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Nov 2015 07:52:38 -0500
Received: by wmec201 with SMTP id c201so31363682wme.0
        for <linux-pwm@vger.kernel.org>; Thu, 12 Nov 2015 04:52:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1447345684-108039-1-git-send-email-qipeng.zha@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Qipeng Zha <qipeng.zha@intel.com>
Cc: linux-pwm@vger.kernel.org, mika.westerberg@intel.com


--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2015 at 12:28:04AM +0800, Qipeng Zha wrote:
> For Broxton PWM controller, base unit is defined as 8bit integer
> and 14bit fraction, so need to update base unit setting to output
> wave with right frequency.
> a) add scaler for each board setting;
> b) remove validity check of base unit for special board, let pwm
> user to handle this;
>=20
> Signed-off-by: Qipeng Zha <qipeng.zha@intel.com>
> ---
>  drivers/pwm/pwm-lpss.c | 20 +++++++++++---------
>  drivers/pwm/pwm-lpss.h |  1 +
>  2 files changed, 12 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
> index 2504410..5a907db 100644
> --- a/drivers/pwm/pwm-lpss.c
> +++ b/drivers/pwm/pwm-lpss.c
> @@ -14,6 +14,7 @@
>   */
> =20
>  #include <linux/io.h>
> +#include <linux/time.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
> @@ -24,11 +25,9 @@
>  #define PWM_ENABLE			BIT(31)
>  #define PWM_SW_UPDATE			BIT(30)
>  #define PWM_BASE_UNIT_SHIFT		8
> -#define PWM_BASE_UNIT_MASK		0x00ffff00
> +#define PWM_BASE_UNIT_MASK		0x3fffff00

Isn't this going to potentially write reserved bits on non-Broxton
platforms? Previously the upper 8 bits were masked out, but now only the
upper 2 bits are masked out. What about the other 6?

Perhaps it'd be better to parameterize the mask in a way similar to the
scaler value?

Also it's unclear to me how critical this is. Initial patches for
Broxton support were merged into Linus' tree yesterday. Presumably they
had received some testing before, but nobody can't have noticed or this
bug wouldn't exist in the patches that were merged. Does this break any
existing setups and hence should go into v4.4 along with the initial
Broxton support?

Thierry

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWRIuTAAoJEN0jrNd/PrOhWLoQAMEHF4ZROqlsfnv9w49w3BLb
VucuScELVTWFVctwMmVuiKnQWVUuz/1cFijYxZ+rRTI0mrX85jfV8/2JIGesjlJW
vp+SS+cNDzwpDarLYEEQCio3OemFUFkYWHRa9oCgSgKNUWXKuwfcCQIgLgkKIfLH
0lcM40qXcqUpeBTjT1YdIsj+pva625XOlvWuaJ+gSx+i4emU59kQu6UuleMcdVbo
+K789uTG9mT9jQXZhwpdMHxGDSLBd34B0V2S+tKtnODHIpQnrbpJbZkqP+oQlc+5
sUTOaRwSbO7bN4E5BRkhzbSJu0Rf0Yu6B11MznAql5PHYh/zMiwhjrpSdyaX02Hg
ZHEcn+SXf1Wh5LMtEGMYgSlPrMDkjLSQVPsjstMR943lL1vbcfCPKl2QIGh0SYgg
HoOBk1gGuoB7tFwcsiX4oteuFO7zJV4uaQUZy0dnXdu8vHNR82ap5YafOtr6zQUZ
vStZTyrpCkwioIxHqAvRnHslpFpXy7Rupe4m9FrDrkFXWtboGh9IHLWzISl86YXs
13Ogb0sXMqPoJf486CLinlNN75pohxM6ojQxNMFMdwAcGDk8Nfswz8yqwAVvZeTY
3Uzk3urUwQNrSfb406EfB+qpUu10igkT9sFCW5Hdf1ZB4DEiWKjTR7bovsXgZKrp
7D8QjlSD19g3Evb3Lzz2
=gWGw
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--
