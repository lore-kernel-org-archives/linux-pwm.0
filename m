Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795098448;
	b=FVEF+PIObNE/JeXZXSYWY/88ixqXFVvfkTLPC0rJj08j222ZzDPQvtaYLuHYdcBajgSI
	 pFToPHmPqtXvaVx/uFQjLalsaiYVL0I2u19+AXVeTVHpt2vUa3DiCOKwM6pD+48q/A/hb
	 8uXtjaUa0pKE51DnYx827TseMmHZBop7JCWrDdbCcch08A9UD2i44BumVx69YznkWk//S
	 xtne7IJnW92srrqgp0KL8/BZsKH53aqjRO5LOV1vyVngHwytrLZbkr0Z0Lot1LSoJrGrB
	 UkyMy4vqh7acNsDVtkeGPF8WZp3Lt4oMsWIKvAD5TtraENKjUI3+DZmPNgst2Iz7xpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098448;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=i0S+BCKb6lufGha2L2cCZLDTofXXtpKDViIFgsoKvSE=;
	b=ONxAfNLr+emhZtbaqt7DXN1aksssoR0Gd7gKzD3KoPhD5zJ/ZHQpTKhn0hu+O5GucfaR
	 nrMbGDT/T5NDEGrBME6lqx71Kz4+ocDrAuGEyp7ObU9HTgtUBMgUyvY2akhYhBiuM8IQs
	 p79FbdMBjMAeGenGHp/uiqtS0B3V6TYw8EUtkvH05nJP0Rw0JWwoOKMFiPkZeh/w00m2S
	 G3ztSX2HBWt/e1xKma4dIJ8JBWhiHpLqSlflPSI1GmVoBfMOuNdZVtUGjadxyppmnZLRR
	 +d4UHqif6pR0ucNwCknUOo2L57pqQ0+eDSGDYVo6xXW8gUcoI4RJxHkvwrFydNVC44w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=elho7lnA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id D0C80606A324;
	Thu, 19 Nov 2026 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=elho7lnA
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 115D01F000C6;
	Thu, 19 Nov 2026 14:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795098448;
	bh=i0S+BCKb6lufGha2L2cCZLDTofXXtpKDViIFgsoKvSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=elho7lnAZoQL9tdp9IxRoFrHpJDqqTHtNr8sWHkmN8/G7kNwpZEeTsgYJFXZB+fVF
	 pgPqhMAHMXzcX0lSCJF49mgmkWHMbuB45fwrDWseC8qkTDtGEV6p97k83/8cSoQOjE
	 IfR+2MlWXukcYk7Xm6XxR5V99q8Q5ptIxq9T0YrrE63zT5b1Th5bS6C7oGASDjJX+I
	 Rgi1E3gZ3eqeiqgsP89Sct7lqUHbgkWHYEJNDgrQuYsDkT1V1gG35k8aHV0hh5kiy5
	 o78YghpBxScbnbQ3dfwSZvvs2hSa+h7oPOaTn+2h3s+uiH0AxvozfyO4c9Xvifj5I3
	 GfAQf1doUO7pw==
Date: Thu, 19 Nov 2026 15:27:26 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: shyckless@gmail.com
Cc: m.wilczynski@samsung.com, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: Don't dereference the chip after put_device() in
 __pwm_put()
Message-ID: <av8GQXBbkf8_sHhX@monoceros>
References: <20261119-pwm-v1-1-adeff0cc366a@gmail.com>
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
	protocol="application/pgp-signature"; boundary="jertrl6sz2vk2w2d"
Content-Disposition: inline
In-Reply-To: <20261119-pwm-v1-1-adeff0cc366a@gmail.com>


--jertrl6sz2vk2w2d
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: Don't dereference the chip after put_device() in
 __pwm_put()
MIME-Version: 1.0

On Thu, Nov 19, 2026 at 10:56:17AM +0000, Suyuan Wang via B4 Relay wrote:
> From: Suyuan Wang <stevewong@hust.edu.cn>
>=20
> __pwm_put() drops the chip reference the consumer took and then reads the
> chip to drop the module reference:
>=20
> 	put_device(&chip->dev);
> 	module_put(chip->owner);
>=20
> A consumer takes both references in pwm_device_request()
> (try_module_get(chip->owner) and get_device(&chip->dev)). The chip's base
> reference is released by pwmchip_put(), not by pwmchip_remove(), so a
> consumer can still hold a pwm after the provider has removed and put the
> chip. When that consumer finally calls pwm_put(), the put_device() here
> drops the last reference, pwmchip_release() frees the chip, and
> module_put(chip->owner) then reads the freed chip.
>=20
> Read chip->owner into a local before put_device() and use that.
>=20
> Found with a static analysis tool and checked by hand.
>=20
> Fixes: 4c56b1434b81 ("pwm: Add a struct device to struct pwm_chip")
> Cc: stable@vger.kernel.org
> Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
> Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
> ---
> Compile tested on x86_64 (W=3D1 and sparse, no new warnings). I don't have
> the hardware.
> ---
>  drivers/pwm/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 4c6d716e5fde..8988a7dbe5b1 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -2020,6 +2020,7 @@ EXPORT_SYMBOL_GPL(pwm_get);
>  static void __pwm_put(struct pwm_device *pwm)
>  {
>  	struct pwm_chip *chip =3D pwm->chip;
> +	struct module *owner =3D chip->owner;
> =20
>  	/*
>  	 * Trigger a warning if a consumer called pwm_put() twice.
> @@ -2038,7 +2039,7 @@ static void __pwm_put(struct pwm_device *pwm)
> =20
>  	put_device(&chip->dev);
> =20
> -	module_put(chip->owner);
> +	module_put(owner);
>  }

I wonder what ensures that the compiler doesn't reorder put_device() and
the assignment to owner. Maybe it would be more sensible to call
module_put() before put_device()?

Best regards
Uwe

--jertrl6sz2vk2w2d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr/B0sACgkQj4D7WH0S
/k57PAgArbo0NiJba3pDU/GMulsV9tSu+LKwweT+yDdn+N4GdYutDBm7Qj9PlrWK
9fRNqypIhzXHoX+ktYG9TVn34q05nVLExZQ1kYosez/KK6ybe21kpOlRsEmgWAh3
DyeW5hUxJfEhBfNBt2MYQz/ZAuKzAPA2/EfOVfCR2GNyA+plmMTWj41PL/YMDaUy
1QApg8OwybiVOLQWvq7h3RlcfBsHfIqUIiQavZA3ygwPJ+UYbVD2TOLbA9LXtB57
3RX+esuxKGE46Pjkon1E+AF6XmXUG9jFKNEx2q6PSHvm65Zi39p/xYCKYiFW9AV2
Ga9e1KpXiapkyEA3bs8KK2Cldg3BJQ==
=yUND
-----END PGP SIGNATURE-----

--jertrl6sz2vk2w2d--
