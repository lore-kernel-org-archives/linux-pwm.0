Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9D6189B84;
	Sun, 16 Aug 2026 07:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786864959; cv=none; b=ET39R4ZFsPIfNpsbKmn4Ypb78wfWbP8R+jLcDl4gfPCFODEqQJCmyWMDbeY9DdnZQoxj0wkJrk5LOylGFtp6G+Qn2TuJ1BJS5qwl6UtvXdsicMsloMCSfI4QE+hRBnJ/78fYJ8GuoDJ7ZVXi2Zw8+Up4bcUeoSn9WZVFWKligCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786864959; c=relaxed/simple;
	bh=ZxUbPbKVwBWJLyynWqCyR8gsBsDAP0QJscyAXYyAYX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5c4zpDPhr5KVhNPx4GCVtW6hu79AYkaolZqCesw1eiAGoV5Y4rPU5dNZIEZdBK6JhAwubp9QaZ7axnqI830SyJveSLE5VfOIdJtjCmtBx7wv/dBLuMQn5Rd5MxM/qe3m5KSC6qiQmhAnzs+AoIw/T9/W1tsM4VOUBU4aQAyqs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1Tj50Fx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1Tj50Fx"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 926411F000E9;
	Sun, 16 Aug 2026 07:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786864958;
	bh=QU0XV+67+4zP3HorGtApdNiGPe6PqjFUijXi2WBaOXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k1Tj50Fx6iC38CBSqdSN6vVPRJJYdqeGMVc0T/qC53l0GFg8jPBLGUKqwkKOUEEEe
	 lq/Sy/LunwPLdIMu0uWdxzLkqz9s4YaK5QBsyPKLo6Mxzz7/iZL2XZScX9WdkEUh4E
	 y6wzof3cBcedd+yyuw/W+4kQ8oa4ATEwYc198TDfl02UZYOo5r4pjwo6eigogms/vX
	 SdIJ5NmxD5tZrbrzVAyN+VJa19gUMzNrzPhc/4P1fNV2FT0qhYlb2Gawc+1L/g/Gdd
	 nl5NkAUKxjBQGbOmw7QXUWRQ5gnIcMVsBn9vAYjvmf0bb75I48pT4TyWpUMrMarW19
	 y3Zfk5CcTPU9A==
Date: Sun, 16 Aug 2026 09:22:35 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Axel Lin <axel.lin@ingics.com>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: renesas-tpu: Fix runtime PM reference leak
Message-ID: <aoFj0SZppae0bAB_@monoceros>
References: <20260814134143.1388120-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5fuuca7jw6wtx3rk"
Content-Disposition: inline
In-Reply-To: <20260814134143.1388120-1-ruoyuw560@gmail.com>


--5fuuca7jw6wtx3rk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: renesas-tpu: Fix runtime PM reference leak
MIME-Version: 1.0

Hello,

On Fri, Aug 14, 2026 at 09:41:43PM +0800, Ruoyu Wang wrote:
> tpu_pwm_timer_start() used pm_runtime_get_sync() without checking its
> return value before touching the TPU clock.  A failed runtime resume was
> therefore ignored, and the callback continued into register access.
>=20
> Use pm_runtime_resume_and_get() and propagate a failed resume.  Keep the
> matching put when clock preparation fails after a successful resume.
>=20
> tpu_pwm_disable() also needs to propagate a failed start so that the PWM
> apply callback does not access registers while runtime PM is inactive.
>=20
> This issue was found by a static analysis checker and confirmed by manual
> source review.
>=20
> Fixes: 99b82abb0a35 ("pwm: Add Renesas TPU PWM driver")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>

Looks good to me. While it's a fix, I think it's not very urgent, we
lived with that since 13 years and is very unlikely to trigger.

So I applied it to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
nexxt

as 7.4-rc1 material. This branch isn't written in stone, so I'll still
take acks for the patch, and I will rebase it to 7.3-rc1 once that is
available.

Thanks for your contribution,
Uwe

--5fuuca7jw6wtx3rk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqBZTgACgkQj4D7WH0S
/k49/ggAlHuqL+xin6L/iSiHBkkVaSROb/IrsOy80BuTIxg4TG79Bo6WmgkR6AaR
8uvDVjPBCr8s4vJQNjN294jivHcFhs6XwcGBjnU64eVkHgR8UqOB7vsQUF9fOJB/
Flp9wwUfFM0T2zIXokF4W4it0nsCoPihouRroGi2YnKDYyK2kliefqnuMa61+jEV
GGExJ39FOura+5jEnUgF3fQZHyHkMj1ICtQHGNa1NwqiXrjnPkkMoMI8+LecRroK
qu6vR0fiORsoNqZ3gyVVq4+xFySdxwqxkynPipoEmk8/WFaXgZH/SNlLXYFe1v0s
XMkVEF3FV8gKqc9GQr6GPKFG/W8D9g==
=Zz9y
-----END PGP SIGNATURE-----

--5fuuca7jw6wtx3rk--
