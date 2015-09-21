From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v6 1/5] pwm: add the Berlin pwm controller driver
Date: Mon, 21 Sep 2015 10:09:52 +0200
Message-ID: <20150921080952.GC19865@ulmo.nvidia.com>
References: <1442484788-15482-1-git-send-email-antoine.tenart@free-electrons.com>
 <1442484788-15482-2-git-send-email-antoine.tenart@free-electrons.com>
 <55FEF75C.4090802@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34718 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755990AbbIUIJz (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Sep 2015 04:09:55 -0400
Content-Disposition: inline
In-Reply-To: <55FEF75C.4090802@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2015 at 08:13:48PM +0200, Sebastian Hesselbarth wrote:
> On 17.09.2015 12:13, Antoine Tenart wrote:
> >Add a PWM controller driver for the Marvell Berlin SoCs. This PWM
> >controller has 4 channels.
> >
> >Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> >Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>=20
> Thierry,
>=20
> if you are also fine with the driver, please let me know if you want
> me to take the driver through berlin-tree or if you are taking it.
>=20
> I am taking the binding docs and dts changes anyway.

Sorry but no. The binding documentation needs to go into the same tree
as the driver because they need to be kept in sync. We can't have DT
binding documentation go into platform trees if the driver implementing
the binding hasn't been merged.

Thierry

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJV/7tPAAoJEN0jrNd/PrOh80UQAIIhx8hCusJrfmfJP22lcOTa
ZI4s/PyF7QZGvuMlAzIHY38yJBQDGyvDlazBJ0eR0ktuP8yQAd2V+Cq9FUCJqpUh
Gas0a/hofZFG8yL7wmWGrzYNryh1Rnp0DobgA1Z6Twq4AXSEEFGlR5x59c+XfADh
/8vOS4AG0zLdRGpCM1jzZIZr8NMBzyoQRdEsk0Noyu5qs1g8DyXcT8kQDnI/5/Zy
Dcw3Lgrx+6L+/++7ML6Zg1umzcAELBeJohfc0qsgkS+oNT7aT97NnQcQucUkLPVP
NqahqI6WbDmVxey7+1iVsx1jl18Es6g7Qtv7EwtBsESFpndQHRSxDWzdTMxiyTB9
Nw/3Lf+vidnzTCdXMYffDlLi7SdXSquCd0pwkWZpCRVIAghZHwDriwTnSK6DGpfS
GXYOsSzt02/2r6oPbTUWuzQ6NUrH2u3CWVg1ygTPLdgrcTwcxA70XjS5CdGzH8UX
yWzIclPq11aKOAgXUUTua2PiNBRRZwZjLdDjRWR2diDvSSb5N3AoB58gFkwu9yOt
5/7d0nS9csXR7v06rjMUcDgSL64quLHBkb2snpVX77mMtegTTpl2RF2uchdbOu/V
w1BeJwmW7lrfbcKXj5t+69p8VGexo/PLe+SGxD6kjQW+3oNXGQ7u/BrB+HAhVuWi
kqwFwkSteDfYTEkENDu7
=EkOk
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--
