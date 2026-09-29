Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DA4402422;
	Tue, 29 Sep 2026 06:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790661631; cv=none; b=E1fIYsUyLLG9HI20GGCgoou3lR/2J/ZKNUn3gEKnlKWyLgbkXFr7BqhoH8MAbif7xoEPFP6CluVw8i3Kl21KiR+d9uf1gHg7dNA2fXiP/zsd68uOuHj0/Ah+Vco1cwav0fkpQ5LdhE30xrlvIb+fZb/pjz0o0tavLosCIhBmb9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790661631; c=relaxed/simple;
	bh=MxIjbY+nCFDzb/mYxJRGXsjLBXyWtF3PH/c/tyPnNYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9s2Fxsmq5gUr2E/lZDsQfuPIgu4X6rB5PkXzRK7bcc1GDWN/czBlyWrgyfgC0OBX0p3fRSTda8IekD1icBTDXcyYSxCajMRKUhe3IcPZMSD6x0F6DUaAaBOzRg2gnFdoDU+g9wTnr7Sdn7wRBEHQd16KF/hhx2tsRDZmgkFGl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1J1Klur; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1J1Klur"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4262A1F000FF;
	Tue, 29 Sep 2026 06:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790661629;
	bh=NGAaPG7jRPlDWonCV4b+j4uXcMNeRtG8skJ3xbe0MqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G1J1KlurOMHR2PzfPmLqvKZVPWFENwQ7lGYp5wHCb6STEmfpu+YTIdGFm/P26tDer
	 u9iLlW8TR3EqgH1goqWA4Y6RBjM/S4hoDQPnKwtZ4n85wrf5YJZMpXKi6MMtaHz2R7
	 c/MaNz9qBFoA3yfgN4QGSGYFC1zUpPz9lQJZ5I1zUhm+GDdgY0fhww2WNOxEEOk9SN
	 l9WCJzjspLycZ4ONuwCwBJQ+HM7/EkFVtx7P+Gw6+A+nca6fwnm/gWT4I2QJInGzMY
	 qt2MMSQ/m32D1w7kTg0gwLw4xI9ONRjluFmOk3M9RaShB7si6G5HmylGvP+Z2mZSRT
	 PaD+MaI/CdpQg==
Date: Tue, 29 Sep 2026 08:00:26 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Manush Prajwal <manushprajwal555@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: tiehrpwm: fix copy-paste error in obsolete DT
 binding fallback
Message-ID: <artTMprq3aNbVrLN@monoceros>
References: <6abaa9fd.8a95a640.187520.71d6@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p4amw4ytnox6vduk"
Content-Disposition: inline
In-Reply-To: <6abaa9fd.8a95a640.187520.71d6@mx.google.com>


--p4amw4ytnox6vduk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: tiehrpwm: fix copy-paste error in obsolete DT
 binding fallback
MIME-Version: 1.0

Hello,

On Mon, Sep 28, 2026 at 11:25:09PM +0530, Manush Prajwal wrote:
> ehrpwm_pwm_probe() attempts to provide backward compatibility for older
> device trees where the functional clock "fck" was supplied by the parent
> PWMSS device rather than within the PWM child node itself.
>=20
> However, when devm_clk_get() for "fck" fails, the fallback checks:
>=20
> 	if (of_device_is_compatible(np, "ti,am33xx-ecap")) {
> 		dev_warn(&pdev->dev, "Binding is obsolete.\n");
> 		clk =3D devm_clk_get(pdev->dev.parent, "fck");
> 	}
>=20
> Because this logic was copied from pwm-tiecap.c, it mistakenly checks for
> "ti,am33xx-ecap" instead of "ti,am33xx-ehrpwm". An eHRPWM node matches
> ehrpwm_of_match ("ti,am3352-ehrpwm" or "ti,am33xx-ehrpwm") and will never
> be compatible with "ti,am33xx-ecap". Consequently, for any device tree
> using the obsolete "ti,am33xx-ehrpwm" binding, the fallback never triggers
> and probe fails with "Failed to get fck".
>=20
> Fix the check to test for "ti,am33xx-ehrpwm" as intended.
>=20
> Signed-off-by: Manush Prajwal <manushprajwal555@gmail.com>

Looks right, I guess it needs:
Fixes: ae5200d22716 ("pwm: pwm-ti*: Get the clock from the PWMSS parent whe=
n using old bindings")
=2E

I wonder: Did you find this because you still use the old bindings, or
by code inspection somehow? If the latter, maybe it's time to drop the
handling instead?

Best regards
Uwe

--p4amw4ytnox6vduk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmq7U/cACgkQj4D7WH0S
/k5ovwf/f6jpWHuSdLq1BR8LCX/XnBPZPFkh+mDOzSq5xhz4IFCBIIEmJj06cJ9e
s0NC/hBxiwNxqN25PVG87FCjkmOn5C8cBaKhYUdZxDIlnbHn/kcjjFuVV0bIzKue
5Dc4N6v6WR1wSttsJ3pIO/LiEbD09BH1RDhT+2hhaWxgTantqW3Y1BEIcedjVPxB
Cwb0xnXCgr+EANDMqsq/UDRYqtoapNxq4MSupNemOFPkjpbPe8xIjHfmGwPMXioN
RiAGPYUH8RZJwfMFhJpJmALjO25ws/+R95uwwWQdM4aaKsTXRBo09pFxG2gXWsaZ
+Qhb90NN2uYzCVTgtVrbTiQPrMC6xQ==
=1zr6
-----END PGP SIGNATURE-----

--p4amw4ytnox6vduk--
