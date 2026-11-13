Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794612023;
	b=CZN9BAMgzhdpvU+mbVahgprVc3o9pYxTCxJLnDodEZDrnBnYMQaS61G51OMeNPCwH8B0
	 3BMqKz4YincTFtmwuTwCxUf1MebwCw0EdoeFLTDoWk4aEccq9A0ojWzP4d4qhud8/x3ZG
	 XqccfzuDt2fV6DnKGavPuNUttQQU/WSVR8G9IGPKJeWkq9YNqpQPxtiz/nCqxXvT6xZg7
	 tOYfpssa5bG7jVVHOX8NOllxfkhcV+oowLML/II2ZLE27oH0e/5P8vTaxuBRQc3+e3i8U
	 Dqqr+hCyarkgyDaVwacDnMMOHQJweS347LkPcbqhj/KH0Rfm0q7GS62G/iRcFgRL5Cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794612023;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Kw6MlJeQpqUgsp68SfLzlS0WVNHKnp+0tGWAOvUeRWI=;
	b=fE8GZwclbwDjRZM830WKwK2PVv89Jw3xn3FO8dBMilTqje39hUOsIL9NCJNLckTggYS8
	 JrgFVTG+9KPSr85OLkPeahHx2SGslmxPMjNyujhqHW6+AZB5gKsf4GkZtpmUVTF78QPu3
	 3jYKnZ9lzDey31PlLaqbTQUzqJAu58dVuunTPpkCrbOLIe2Y6aueiIT0Snx+B38SlHgth
	 DjmGEpwl1JSYI91rkcWWShTaCA/BJS7h2xIcyoX/Af+c3/HMYWlzXzsYD5QSsrh6fuzlO
	 yNneUthbPDz1eFL/d4W7n5EKkknhowMFfpF/WhkQeG3gOiUKDmYpBgyY2mjg7EqK1AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NsyNyKYB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 128CA606A330;
	Fri, 13 Nov 2026 23:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NsyNyKYB
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0D95C1F000C4;
	Fri, 13 Nov 2026 23:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794612022;
	bh=Kw6MlJeQpqUgsp68SfLzlS0WVNHKnp+0tGWAOvUeRWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NsyNyKYBPkn7Dmhe8dWZWSmkVVj5ZxF3FiACfv99NSHmGe1ZSrp88PcgITnVlOK7B
	 VXMbGiEOmYCvtmsin1kch2HhReTvSEBDvo2RxmYWvGCgB5cPSladfFwCw/6CQqix8Y
	 1PK1Q6/UBuxh3mnW9wm9FY0PJabI4YM1FLOt2rINtO4js+C5b4mGv1sHL8BB5uyg8M
	 Q2hNZGhRps5rQPgtHqTt2WnF2QWEAliC6gtI3YrsLBrcyLSx2BjTIg0FB1WrYNw59a
	 zPM+mMhIuiZYGgeg1UJyNGx9OB8c/1xxFArcJ1uKudZa3UjlKyB1qeQ2L1fP2MaQCZ
	 KjYCKO51ULhXQ==
Date: Sat, 14 Nov 2026 00:20:19 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Manush Prajwal <manushprajwal555@gmail.com>
Cc: lee@kernel.org, linux-pwm@vger.kernel.org, mfd@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: lp3943: validate DT output indices in
 lp3943_pwm_parse_dt()
Message-ID: <aveayVLa1xIXs2-Z@monoceros>
References: <6a9d5118.a865c849.172a3c.4f1f@mx.google.com>
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Post: <mailto:linux-pwm@vger.kernel.org>
List-Help: <mailto:linux-pwm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pwm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="koyasvbz3dtj5k5d"
Content-Disposition: inline
In-Reply-To: <6a9d5118.a865c849.172a3c.4f1f@mx.google.com>


--koyasvbz3dtj5k5d
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: lp3943: validate DT output indices in
 lp3943_pwm_parse_dt()
MIME-Version: 1.0

On Sun, Sep 06, 2026 at 05:10:07PM +0530, Manush Prajwal wrote:
> The ti,pwm0/ti,pwm1 devicetree properties are raw u32 arrays naming
> which of the 16 physical LP3943 outputs (0-15, per the documented
> binding and the 16-entry enum lp3943_pwm_output) each PWM channel
> drives. lp3943_pwm_parse_dt() reads these values straight from the
> devicetree with of_property_read_u32_array() and stores them in
> pwm_map->output[] without checking they are actually in range.
>=20
> Both consumers of pwm_map->output[] then use an out-of-range value
> directly as an index/bit-offset with no bounds check of their own:
>=20
>  - lp3943_pwm_request_map() does
>        test_and_set_bit(offset, &lp3943->pin_used)
>    with offset taken straight from output[i], corrupting memory beyond
>    the single 'unsigned long pin_used' field for offset >=3D BITS_PER_LON=
G.
>=20
>  - lp3943_pwm_set_mode() does
>        mux[index].reg / .mask / .shift
>    with index taken straight from output[i], reading past the 16-entry
>    lp3943_mux_cfg[] array and then issuing a regmap write built from
>    whatever garbage register/mask/shift values were read out of bounds.
>=20
> A devicetree (malformed board file or a loaded overlay) with an
> out-of-range ti,pwm0/ti,pwm1 value is enough to reach either path;
> nothing upstream of these two functions validates the value.
>=20
> Add a range check in lp3943_pwm_parse_dt() right after the values are
> read, rejecting the devicetree with -EINVAL before any out-of-range
> value can reach pwm_map->output[]. Check explicitly for negative
> values in addition to the upper bound: enum lp3943_pwm_output's
> underlying integer representation is implementation-defined per the C
> standard, so do not rely on the compiler having chosen an unsigned
> type for it even though it always does in practice for GCC (verified
> empirically, with and without -fshort-enums, since none of the
> enumerators are negative). Add the LP3943_NUM_OUTPUTS(16) constant
> next to the existing enum it bounds, alongside the existing
> LP3943_NUM_PWMS(2) constant.
>=20
> Signed-off-by: Manush Prajwal <manushprajwal555@gmail.com>
> ---
> Changes since v1:
>  - Sashiko AI review flagged that the bounds check could theoretically
>    be bypassed by a devicetree value with the MSB set, if the compiler
>    chose a signed underlying type for enum lp3943_pwm_output. I checked
>    this empirically with gcc 13.2.0, both with and without
>    -fshort-enums: since none of the enum's values are negative, gcc
>    always picks an unsigned underlying type, so output[j] >=3D 16 already
>    rejects such values today. Added the explicit "< 0" check anyway,
>    since the C standard leaves the enum's underlying type
>    implementation-defined and the check costs nothing.
>  - The same review also flagged a missing NULL check on
>    pdata->pwms[hwpwm] in lp3943_pwm_request_map() as a pre-existing,
>    separate bug (not introduced by this patch, confirmed by
>    inspection) - sending that as its own follow-up patch rather than
>    folding an unrelated fix in here.
>=20
>  drivers/pwm/pwm-lp3943.c   | 7 ++++++-
>  include/linux/mfd/lp3943.h | 2 ++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-lp3943.c b/drivers/pwm/pwm-lp3943.c
> index 10537e74b..e8bb8dbb9 100644
> --- a/drivers/pwm/pwm-lp3943.c
> +++ b/drivers/pwm/pwm-lp3943.c
> @@ -218,7 +218,7 @@ static int lp3943_pwm_parse_dt(struct device *dev,
>  	struct lp3943_platform_data *pdata;
>  	struct lp3943_pwm_map *pwm_map;
>  	enum lp3943_pwm_output *output;
> -	int i, err, num_outputs, count =3D 0;
> +	int i, j, err, num_outputs, count =3D 0;
> =20
>  	if (!node)
>  		return -EINVAL;
> @@ -247,6 +247,11 @@ static int lp3943_pwm_parse_dt(struct device *dev,
>  		if (err)
>  			return err;
> =20
> +		for (j =3D 0; j < num_outputs; j++) {
> +			if (output[j] < 0 || output[j] >=3D LP3943_NUM_OUTPUTS)
> +				return -EINVAL;
> +		}
> +

A few lines above we have:

                num_outputs =3D of_property_count_u32_elems(node, name[i]);
                if (num_outputs <=3D 0)
                        continue;

I wonder if it makes sense to clamp num_outputs also using
LP3943_NUM_OUTPUTS?!

Best regards
Uwe

--koyasvbz3dtj5k5d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr3my8ACgkQj4D7WH0S
/k6ykgf/R52mdqzwf9/fpFtCoIkRXyy3lM8Yc0+utvzGczjsYeuDe/GDeIzC1bnJ
qSse59onKYXC9t3wDJgV5tLYippWNnA+7VXkvgvSPBg+GxIJhtX8E24PfvFXeMOZ
b0iVsFM6PkKrbvKevwJWikDOAI4MUwg0YfTc0ipdXC/MCJ+CfIbC6mzZ/0+WjL9u
hp9Y5JFEh4joIInxYRwqzWzZLD22SPZxfu7PzJhFR9E3RitoXjpDc2xWawgU4MXj
gz+lvey7Bs/BUL0dzvhosED3VEc8TdlEEy0KGDeYlXxjKR0qrNX+nq7aSG4EQ6kw
MvEGLuYmvwUazSwudKqNTkYjbYDEEA==
=eyH4
-----END PGP SIGNATURE-----

--koyasvbz3dtj5k5d--
