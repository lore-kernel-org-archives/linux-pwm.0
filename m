Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7DD57ED97;
	Tue,  8 Sep 2026 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887637; cv=none; b=DY1BryJuPX4I6RAgR4orL77e1/YGKEFINiangVtOW6tk0vx6dNTPY19CT9K7i6Rs5Ys1euPEsnzL++mM127ObMJbz5KQsNQr9uKL+2DTSmD7tpdsljBSOqPP1q1S4uKd0z58NgEeMnLfbHPoHBsd7yucjNLsjjXidoUEwcxhpdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887637; c=relaxed/simple;
	bh=ek0Smayhi8B4gW1GXsCn8FTSwdWZSt/IemVrVchRirE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPtqj1+Tsf5rXCMcvkHuEAOtJ9nCReNsWHzVYKB93MYYs7ZhNuZ5bWE2HXdZZMgNXsS5ebfzg2AaLcjb3uuXwxTJzf2abdCDfUO/p8ItxMO3jXwqAR2fnU5uBJftpk+OmBxqd6h6/fPAapwWUnTU6alhkGLJNKHQSHXG6CZcXLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4gcHqvq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4gcHqvq"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A523C1F00A3A;
	Tue,  8 Sep 2026 17:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788887636;
	bh=/W45qRLtv26bOktI1LZR0If7Nwl0xlxx+IRS4Ck7a+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g4gcHqvqiSL8lilNMcUUKApSZrQmo8qRP5ML43l85YT1dhOraV36u1FAEc07O8ad9
	 RrrKvqJ5fuOGfZioFiDQfiiFML8gCvpIxoKpxPfsuC2P+ZMPREPAq59TlUYkKgi1El
	 w2AqDMSp+mVz0JfjfIs3anBDi8BEMS86rWvuaCHKhHRxPuYVKt9YT02f1FiWDMUlN1
	 tioKLbaXm2DhRWP9R6wSBLfUvijINHw5av3Xb35DNWPomWVTTWMiW/yKBqT4ukadqc
	 bOv/HNFrNYu+JJlauc2GBEDzhh7EGYWPQfAYc7N9qqfTfGzoFqcUHLpPJy4XbQIRuh
	 oGlCNb/IitN7g==
Date: Tue, 8 Sep 2026 19:13:53 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Manush Prajwal <manushprajwal555@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: lp3943: fix NULL pointer dereference for an
 unconfigured channel
Message-ID: <aqBBapT-KcJDDDGB@monoceros>
References: <6a9d5187.d63de05c.175391.a17c@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sfwbrcaebbdwjzx7"
Content-Disposition: inline
In-Reply-To: <6a9d5187.d63de05c.175391.a17c@mx.google.com>


--sfwbrcaebbdwjzx7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: lp3943: fix NULL pointer dereference for an
 unconfigured channel
MIME-Version: 1.0

On Sun, Sep 06, 2026 at 05:11:58PM +0530, Manush Prajwal wrote:
> lp3943_pwm_probe() unconditionally registers a pwmchip with
> LP3943_NUM_PWMS(2) hwpwm channels, but lp3943_pwm_parse_dt() only
> populates pdata->pwms[i] for the channels whose ti,pwm0/ti,pwm1
> property is actually present in the devicetree (the binding
> explicitly allows each PWM generator to drive zero or more outputs,
> and lp3943_pwm_parse_dt() only fails outright with -ENODATA if
> *neither* property is present). A devicetree that configures only one
> of the two channels leaves pdata->pwms[] NULL for the other.
>=20
> lp3943_pwm_request_map() dereferences pdata->pwms[hwpwm] with no NULL
> check:
>=20
> 	pwm_map->output =3D pdata->pwms[hwpwm]->output;
> 	pwm_map->num_outputs =3D pdata->pwms[hwpwm]->num_outputs;
>=20
> so requesting the unconfigured channel (e.g. exporting it from
> sysfs) crashes with a NULL pointer dereference instead of failing
> cleanly.
>=20
> Return -ENODEV from lp3943_pwm_request_map() when the channel was
> never configured, before the pointer is dereferenced. The caller,
> lp3943_pwm_request(), already propagates an ERR_PTR return correctly
> (it does so today for the existing -EBUSY case).
>=20
> Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/6a9d4c6b.79b5ea6e.147aa1.5883@mx.g=
oogle.com?part=3D1
> Signed-off-by: Manush Prajwal <manushprajwal555@gmail.com>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

adding a Fixes trailer for af66b3c0934e ("pwm: Add LP3943 PWM driver").

I havn't made up my mind yet if I send a fixes PR before 7.3. If I do I
will likely include this patch.

Best regards
Uwe

--sfwbrcaebbdwjzx7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqgQk4ACgkQj4D7WH0S
/k7XpAgAnPnwwfi0ZrVs6V6kJfuKb2EBztPoEhjifptfZAhfy7evyhOW7huM33Tf
5hmyHLbyBvnRfLtJbPgDdIGk9my6HCmiODbpAVF2h/2iLVbu3nG4CxpgsK6SY4hL
shF75mdeN/Ju3pllmVI7h0R9yaS0IFxCtBMugeHGLo03vHamUtti8qE90kgKjGzb
PEiB4vZBkhWIs9J1TTrUuzsUBEGDzb2c00OEct1VGn+4CODAclcNA+lN6Jvi+Lph
m395cEwq51HSE51z5Y6x3HZXtSpUVuDB2uA550yjsIo5z5pSM4Vm8Ky79wFgSgwG
vdFpBHarC2xVkSsSIVrPGJphe4uquw==
=N3MN
-----END PGP SIGNATURE-----

--sfwbrcaebbdwjzx7--
