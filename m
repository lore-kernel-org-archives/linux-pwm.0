From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2] pwm: samsung: fix to use lowest div for large enough
 modulation bits
Date: Mon, 5 Sep 2016 08:53:08 +0200
Message-ID: <20160905065308.GF3532@ulmo.ba.sec>
References: <1470133006-4272-1-git-send-email-sw0312.kim@samsung.com>
 <20160816142201.12672-1-sw0312.kim@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dgjlcl3Tl+kb3YDk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160816142201.12672-1-sw0312.kim@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, k.kozlowski@samsung.com, linux-pwm@vger.kernel.org, tomasz.figa@gmail.com, jy0922.shim@samsung.com, krzk@kernel.org
List-Id: linux-pwm@vger.kernel.org


--dgjlcl3Tl+kb3YDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 16, 2016 at 11:22:01PM +0900, Seung-Woo Kim wrote:
> From pwm_samsung_calc_tin(), there is routine to find the lowest
> divider possible to generate lower frequency than requested one.
> But it is always possible to generate requested frequency with
> large enough modulation bits except s3c24xx, so this patch fixes
> to use lowest div for the case. This patch removes following UBSAN
> warning:
>=20
>    UBSAN: Undefined behaviour in drivers/pwm/pwm-samsung.c:197:13
>    shift exponent 32 is too large for 32-bit type 'long unsigned int'
>    [...]
>    [<c0670248>] (ubsan_epilogue) from [<c06707b4>] (__ubsan_handle_shift_=
out_of_bounds+0xd8/0x120)
>    [<c06707b4>] (__ubsan_handle_shift_out_of_bounds) from [<c0694b28>] (p=
wm_samsung_config+0x508/0x6a4)
>    [<c0694b28>] (pwm_samsung_config) from [<c069286c>] (pwm_apply_state+0=
x174/0x40c)
>    [<c069286c>] (pwm_apply_state) from [<c0b2e070>] (pwm_fan_probe+0xc8/0=
x488)
>    [<c0b2e070>] (pwm_fan_probe) from [<c07ba8b0>] (platform_drv_probe+0x7=
0/0x150)
>    [...]
>=20
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> ---
> Changes from v1
>  * Remove too complex condition, instead, just checking simple variant->b=
its as Krzysztof's suggestion
>  * Add comment from Tomasz
>=20
> The UBSAN warning from ARM is reported with the patch in following link:
> https://patchwork.kernel.org/patch/9189575/
> ---
>  drivers/pwm/pwm-samsung.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)

Applied, thanks.

Thierry

--dgjlcl3Tl+kb3YDk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJXzRZTAAoJEN0jrNd/PrOhy0MP/iNFo2S9DN5FZz18UDVpfehU
aUrK7PVUW0/Fk9D9k0U2bhijQGGHeR013fNNDU5h6JD1/hfef8Y6Xwa/0upGujP3
fXDXCF6vXiTRw5zOlDnXoTKuCm05pZ42Jrc3kDM4gVDaK+seHUE0+j/9+RDTAXML
+3lshQpshu8bUTkmDMMJIUO/kEVyD6G9u6VhZdGR7mSgvGJxBFAEFlmce9damPcQ
cmgI5BpIKtLlEkea5mWtZbYgDVtvlF4rpcBqIU8R9C765C/060xPiDcb8Q9Xc1o7
glRprbpE/7QEl+GuqNLToReeb/ig4uEaoera9F2kgkkxAdloNV8v8OtcOKhPi7eK
oL5iKh5lIzXBmUdxcEj7tEvAGfdikqIjXrV6uE1sadYb+mq9y0Y192IMMT87dmHC
HYSJa9lPRaWQVNOcIS2qZfTualvdadQ/wzDfLnK2eMrxIJMK3gmcWLRRUHCs2g1U
++QKfJV3UhuA/oku6MGehVayAXCgzNEKX0zddXt3Kl3kqFzjy4Ai/xWI+AvPB4sF
9/lhB2DOzg9s5OPhwmJ/GQnWVRo7QjXJLoVwRQ7eRd5rX4T5RENWqBVD9Hj8vkUv
hCIlH1A3Ovv+VPcQ3vfNFP9ZNnqdDo8VhqhXuPrZRfWWf8k3Dat1SAWe9gACuuda
oA//igqEGTP2KY0QTatM
=ypi0
-----END PGP SIGNATURE-----

--dgjlcl3Tl+kb3YDk--
