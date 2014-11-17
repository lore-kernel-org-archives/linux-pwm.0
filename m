From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: samsung: Allow samsung pwm driver to be enabled on
 Exynos7
Date: Mon, 17 Nov 2014 12:25:39 +0100
Message-ID: <20141117112537.GC25699@ulmo>
References: <1414759126-4608-1-git-send-email-a.kesavan@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:61581 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbaKQLZn (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 17 Nov 2014 06:25:43 -0500
Received: by mail-wi0-f176.google.com with SMTP id ex7so5358258wid.9
        for <linux-pwm@vger.kernel.org>; Mon, 17 Nov 2014 03:25:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1414759126-4608-1-git-send-email-a.kesavan@samsung.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Abhilash Kesavan <a.kesavan@samsung.com>
Cc: linux-pwm@vger.kernel.org, kesavan.abhilash@gmail.com


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2014 at 06:08:46PM +0530, Abhilash Kesavan wrote:
> To re-use the existing PWM driver for arm64 based exynos7 SoC,
> make the driver depend on ARCH_EXYNOS along with PLAT_SAMSUNG.
>=20
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> ---
>  drivers/pwm/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied (with minor spelling fixups), thanks.

Thierry

--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUadsxAAoJEN0jrNd/PrOhyM4QAIh0wi6pplwgkSLe+XppJifY
O8nKIdrsS7tjLvLJR1PT/2RbQaZ/Rgq84zlFdNHQi1I5n6NV6TvQJL5WYlJNGWmq
B+K3YW3VnYfwXxUvsgwwSsJfkWBSuY5LS0L/IGQcd9F+P5/C7SeXpUunusC9lzFB
dncjokQ9yRKM+9G2t0rBI4bBb6OrbUcPuQn8S9xgZu59i9VZnRJ5Rqd6eJJdAG2V
U7RwI1GTRlMnSx6cO9UZegeJbX2xl6GRs+xouyEoPmJcHi1b9LewusJrNO04n1ji
IjBe2EGI5Y1B6+MXWEMff6NgUk0vIRP0+QKULZbZidhWpQhQ7ESSd98mZkQlj10W
elAo7Io9yg+skhSmN3Pe/zax1Jp13FDp+HJRvAgwpW+fekERLRfvTVv8OV1MmshV
UjmEntJvmCo6rb7XDNPLIUyFKnNQUYQj3J47BUNxAyqdBbgiF8t8rJlD1Qz5Ww+M
wXKde9lVgSG1EgJ+PS+rWIIia1aPDH6d+xA88vsbMPuOKZuDddiMlLJi02Y7PkQz
BqrxMN4QDkcqPiueu7vpjGPTY2SEKAit/AuwDLhIrulZQV3u6TCYkPlZd0hu5U2D
9xAYXy2p/tTOtgeqrSWm2K3//Man2oTOoAGt2qa/1OG25YXKANqQeD73inTpQ9hg
xY/go1oreJp1h1rTqSqV
=OVOy
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--
