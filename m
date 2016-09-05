From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 09/17] pwm: sti: Only request clock rate when you need
 to
Date: Mon, 5 Sep 2016 12:36:34 +0200
Message-ID: <20160905103634.GI31424@ulmo.ba.sec>
References: <20160816093508.28307-1-lee.jones@linaro.org>
 <20160816093508.28307-10-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y96v7rNg6HAoELs5"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36134 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932249AbcIEKgi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Sep 2016 06:36:38 -0400
Content-Disposition: inline
In-Reply-To: <20160816093508.28307-10-lee.jones@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, patrice.chotard@st.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org


--y96v7rNg6HAoELs5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 16, 2016 at 10:35:00AM +0100, Lee Jones wrote:
> In the original code the clock rate was only obtained during
> initialisation; however, the rate may change between then and
> its use.  This patch ensures the correct rate is acquired just
> before use.
>=20
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pwm/pwm-sti.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Applied, thanks.

Thierry

--y96v7rNg6HAoELs5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXzUqyAAoJEN0jrNd/PrOhxlcP/2SKnwH81WIKWQf+QnxbZUp7
i98Jg2XW2Fjxo1eUbT18pqH0VZTAEgbIGFmhKYI9nsBwUaNyLrEYMrYL6rLn0CVs
XspUw3LU5rVdamrheBiTxoiG8hPD9jP8eolFgHOGVo3JIWQ4F8evynjYdstdlORD
51RB3JCyGsWuY3xXtgr82YvRc5GpUySqX8tNeHE7l5ygVMQhlISpKvKSqiXUp7QU
1ZCwQbZsOLagkgcpkVb7u/r+Ur846n6nvuP6Ev/70yS1iI0q1/Zj8HGaMHfsP8N4
r+1qByaClNitLPCgiU3VectzYssvcKSQS0QND3Wmc9KoVqG8C1jcltrPEOaMRHm8
AABYBYsd5gHlJA6+zuvLkxvyxV4hmz8ZHY1L0oX2HlMfD5n3VgoKJu38+LRp/iTs
aBJzR/21B+5vU664l9OR3//rvzCrGMzUUi/pY6S+W9jeK02H3kD9yY5QPiTzhQV6
53l3b/N8IHY8Uz5I0YibgwSu4cy84YjuVx9URSgoKPY9xzp9tObkKyuAiUA/fBcY
mlNm9nYd7f80LrNdKP5tbG2kIr2Vb8whCaNWXdWX3fZarwjzgv/fxHzZRF7o3ZKQ
xqJu0p/gAIBIS/XQ7/MzusrM0DAZXvXJm81tTf+EP983/WEI4OimVePY5s9qR2eg
QTXk2DvimBTHDlnqrHpW
=GtSO
-----END PGP SIGNATURE-----

--y96v7rNg6HAoELs5--
