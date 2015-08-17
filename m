From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: Drop owner assignment from i2c_driver
Date: Mon, 17 Aug 2015 15:55:35 +0200
Message-ID: <20150817135533.GA6891@ulmo.nvidia.com>
References: <1436509690-12144-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:36059 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbbHQN4p (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 17 Aug 2015 09:56:45 -0400
Content-Disposition: inline
In-Reply-To: <1436509690-12144-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2015 at 03:28:10PM +0900, Krzysztof Kozlowski wrote:
> i2c_driver does not need to set an owner because i2c_register_driver()
> will set it.
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>=20
> ---
>=20
> The coccinelle script which generated the patch was sent here:
> http://www.spinics.net/lists/kernel/msg2029903.html
> ---
>  drivers/pwm/pwm-pca9685.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

Thierry

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJV0efSAAoJEN0jrNd/PrOhuNEP/0ndHhMHyazqukcKEygsEe8b
SN0iruzSoUCl42p4X4i4Gapj79mJ9OrHK0ff7YhBDXvmDfBEhks7eRG9SOsFWUNJ
qA2XKpvqycigq5vyOLRz41mK51h+6LLVtTQtb/YRTDK9hUb5edKAeIejJl4Do3EJ
vdeR4Dhm2vrifvakL/kMsWX1vNoet0bf0SPiOUFiwugQh42aSxLIFr05NeN3WNTb
AxQTPc+Kuas+YCsSyOkwuw50vx2GJyJz0esQ7mXWuIgAcFOpf4klYl0Ekt5+OKlc
9fW5+E9XrBubUOnpNl/EJPoertykUmux4Dp6F4dRTcCPn/Lx9kTKx7L3Ar86Lhnu
3RCIjo/NypyJMtu8wrFdYEe9TQ4+gUF8n6yBl9bS2mDPyF9s17qFHgfED4FRGFhG
pRmyX60au//D27/6Dtwch5R/Gqi2lGz0WimiWdxYuW87xyGD/E8MUr702irWh+vL
5g5rN2CdjZtrcwsbNrjGXmNphwd0J8EICUVxW1kOiby35BAUgAvXcdRVkJqKYja2
AWhZLwxfsl4s7wxis5Bk8FpzYt6cN5wkVqQf4zAPnhCnp8O0R54eYi//gChlF1Bi
t4RP5DoTbo4ICL3UREPh1x1OF9QC9QR3e10+14mhb68Sr89W/hbxn7OH/TJAzeJW
jV1ePQ0I1SOanEhPmw5d
=hkOw
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
