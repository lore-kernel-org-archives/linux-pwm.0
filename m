From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: berlin: Add PM support
Date: Mon, 5 Sep 2016 07:32:37 +0200
Message-ID: <20160905053237.GB3532@ulmo.ba.sec>
References: <1448444485-4857-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34989 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbcIEFcm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Sep 2016 01:32:42 -0400
Content-Disposition: inline
In-Reply-To: <1448444485-4857-1-git-send-email-jszhang@marvell.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: sebastian.hesselbarth@gmail.com, antoine.tenart@free-electrons.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2015 at 05:41:25PM +0800, Jisheng Zhang wrote:
> This patch adds S2R support for berlin pwm driver.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
> Since v1:
>  - implement .request and .free hooks, allocate/free the channel in
>    berlin_pwm_request/berlin_pwm_free. Then use pwm_get_chip_data in
>    suspend/resume implementation.
>  - s/int/unsigned int
>  - check return value of clk_prepare_enable
>  - remoev BERLIN_PWM_PM_OPS macro
>  drivers/pwm/pwm-berlin.c | 90 ++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 89 insertions(+), 1 deletion(-)

Sorry, I had completely missed this. Applied now, with some minor
stylistic changes.

Thanks,
Thierry

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXzQNzAAoJEN0jrNd/PrOhR6UP/iQExK/VJCrH2X5PnBKknwQH
oe4WDvgvxYCz/MxH857RbvCQ9iQmQxeUIl6OodkCamRaXJr5vrKihTlCAe85U1oa
4D5Tp+8a3+2VGOczeEJlQlCaBHOqVDWXl0DDfAlINdOGGcLZnJQPmKMHULqaEezk
2m4BcEyWhnVKa66MuD7ThiqEPxAnW1ux1COd4B86gBJi45kbRhX4MT37wtJGhpkR
ywQwpbJd/ljcM0fHGM+iUyk5xWxtpQzcQVgKuzMB1+nmyrs7KEOITmRjvfoo2JKP
tLWZfzp7jXx27XW08wasBtRV5zs3SrvFd2peSgKEkhKX51Mm323Ma5NyRVAG81Pj
nM7ayoUlmr9zRvZOZrDhwYEM7zw6zna7y2N6QMHKG3T5KNMGC+Ubn6mPvsHCPd4e
uLQ3KjBKxbc7d6PtPvD7vLJpb5An9e3UD+cREhDeEPAN/BwW6A4pm9TkRQ2XUIS+
sKV58+KIdbteeY1YQWcA45ZCEFaUBORPivKsWGP6ttfFbwOa/amS72Yw6j+EeSOY
a1SL1TIfFGEEMl2tABhPJLWffClhTVk0JUaLZk8KYyVnZRxzVYcMmhd9K+MXIYnY
jXWOQTfgbzCMGWvzKWhRbTSRU5IjEcK/gkEOtIrl9Qxkioo9H7nZhy+eJwUw+t+D
sVUNDroI5xSE5D1hs1pj
=bPtl
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
