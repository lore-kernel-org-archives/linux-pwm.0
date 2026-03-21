Received: from aposti.net (aposti.net [185.119.170.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B028737646E;
	Sat, 21 Mar 2026 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.119.170.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774103774; cv=none; b=j1Y2E3/yrCTqUlumZ0WbKDlUkM2bfIkOCecoopzIHnUkg/T/UV/Hijnb0IfpiVRuqd8SXrC07pfC2x8hDpsfa8CI36z0OCHfDEh7J5zHe4H6KVC9+xKt3OUffHsJfoyb1mdiUUHEq7TZFezarMrmZfQdhayidH9XNVOKnd4X5Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774103774; c=relaxed/simple;
	bh=zn/YO/TCXYmtoC+IugKxfXMgLUpYdFLfP52Rtce5fis=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T+tSspg2sVaSOWgf9JriRhxAcD0ov4R4sQMi2uqc09eP2Dy+WzwwgTQI3wdzXrP4yN10u4d6Yhp3glrCEs4JvnBLpa6PwJf99UlAhTLYFF5Wt6WVLePIorsVCfs2t54NlZW5J7Ik+sglSFVYwzEquXFGRlL72pXieEXaJkkyp3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=tItR4EGf; arc=none smtp.client-ip=185.119.170.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="tItR4EGf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crapouillou.net;
	s=mail; t=1774103764;
	bh=zn/YO/TCXYmtoC+IugKxfXMgLUpYdFLfP52Rtce5fis=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=tItR4EGfLEa1h0KEu4qta07yvf6EoA1oLMHHC/hHhBs0Flu++Bg0kh8FQdq/TuUeU
	 L6VYg25/W455cp4F60jr3LEHcLjz1JzpIgg9sk2Rs99TE9/gAlZ5jK3SVea7hWdAkY
	 r/REthetPvMxUyWn+d51Yha0TSqiILnsAiPClR2E=
Message-ID: <46bc3e91ae5a3e246bcd89b715d9ea5b797052f3.camel@crapouillou.net>
Subject: Re: [PATCH v1 1/1] pwm: jz4740: Drop unused include
From: Paul Cercueil <paul@crapouillou.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Date: Sat, 21 Mar 2026 15:35:59 +0100
In-Reply-To: <20260320220644.3237290-1-andriy.shevchenko@linux.intel.com>
References: <20260320220644.3237290-1-andriy.shevchenko@linux.intel.com>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZM
 LQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5Uz
 FZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtN
 z8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe
 +rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY
 3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr
 1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f
 33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIP
 dlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET
 4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7U
 rf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KF
 lBwgAhlGy6nqP7O3u7q23hRU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le vendredi 20 mars 2026 =C3=A0 23:06 +0100, Andy Shevchenko a =C3=A9crit=
=C2=A0:
> This driver includes the legacy header <linux/gpio.h> but does
> not use any symbols from it. Drop the inclusion.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
> =C2=A0drivers/pwm/pwm-jz4740.c | 1 -
> =C2=A01 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> index 6bdb01619380..e0b5966fc7fe 100644
> --- a/drivers/pwm/pwm-jz4740.c
> +++ b/drivers/pwm/pwm-jz4740.c
> @@ -10,7 +10,6 @@
> =C2=A0
> =C2=A0#include <linux/clk.h>
> =C2=A0#include <linux/err.h>
> -#include <linux/gpio.h>
> =C2=A0#include <linux/kernel.h>
> =C2=A0#include <linux/mfd/ingenic-tcu.h>
> =C2=A0#include <linux/mfd/syscon.h>
