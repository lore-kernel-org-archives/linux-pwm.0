Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795190798;
	b=TKCsUhqro6WwIHDvoc7fTbpin7a7k369AkNEJW1OTfH3eXyYLUNU7AeCExq3VAKcI6ri
	 V7GWhIZVksEI8EiPWGOVlqHFA1+izA0/aOyPNcwoipdKRmRiZANufyn7+Ner+tTrnqz/V
	 v8IFb0Fc6xNxV1rrWdIYb1Yr4ST+Z3uJzLAERnyk14aZk0hVh7oJmo7t/AqytM7tc41WV
	 9pg5fjGULrw8qqbx/Px85SKsceXPa7fVGcL9JojOn9O6DY32LYoJxWrXtjEAsRrpygizZ
	 PDNntXhTuJoQtDgs19A2zA15i+M1WKUUVW3SdOxRajT1Vh1AGGMj43PlrjBJIYou8mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190798;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kUgrgwbIAJZqykyVFH7B082507Cz9Cbb4X4NmbAHYNU=;
	b=FYR04cULsAOFi/6JG5oo+3a1qLHnl7/J8BRcrTIikKswRFOFPBqRQqnuQRxYGXnS4qx+
	 Rze38IhZnzMVbfCkmaDSHImM/ZBDCRHyb26Q+qyc76Q5K14HiPi3kYv+PsfiA+DZm6Yzg
	 EwJaneGcME3xUszldkejGbfJEH8HnXZdul5FnrR7BZgeaonaeSsl4ay3qQagSGmU9aF1q
	 jW3DmjaJ1Ck/NCqUiMhVNESrxSO1E/ZY+ZTi2/vfEI/Lp6+lwgHIRpZ5X6a0pRXdSwgMG
	 0Xjhqk/czhXc07nslGcToL8N3vS0s2S17hPGoG0eCY3wvfpPb1ONeRqHhp5pzHOusZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UPLq6v8R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 575F4606A335;
	Fri, 20 Nov 2026 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UPLq6v8R
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 534421F000C4;
	Fri, 20 Nov 2026 16:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795190797;
	bh=kUgrgwbIAJZqykyVFH7B082507Cz9Cbb4X4NmbAHYNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UPLq6v8R9jO2AcjARnKfPzjLMJXSG+pHCQCnuCLw4ptOS0XtZKF4kc3yI1PktvKQ0
	 Tyf8YGc7cyHc2Ddl90VOLSHFZ9TIJ8p/P5t4UL3CNGMYf2ANBOs5TWoyC+JBvzI9Yv
	 qcUwRIQ+s5nqvIKcbOdFBYtn7CsRnkJPEZD1Mnc29/aeQ0BTXvADFK0BT94Ghotnmz
	 i4ispBoSIKXrt1E6aa8R9Ym7oirKZTtrLvLfmoazapoXkftnVIKYL5o7TqC7BRsF89
	 uoCUvWYYU4Oo6y58UM53dZ283iVHl5hrJuDS7A8Tw5jrt/RYWBjFdFqYo/ZXjlwbHI
	 JNYe7OCJ9GmYA==
Date: Fri, 20 Nov 2026 17:06:35 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: atmel-tcb: Fix the channel restart write on resume
Message-ID: <awBvPEph3wqbEqxV@monoceros>
References: <20261112071615.154385-1-zhujun2@cmss.chinamobile.com>
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
	protocol="application/pgp-signature"; boundary="d6zp3rsvlu3kvp7g"
Content-Disposition: inline
In-Reply-To: <20261112071615.154385-1-zhujun2@cmss.chinamobile.com>


--d6zp3rsvlu3kvp7g
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: atmel-tcb: Fix the channel restart write on resume
MIME-Version: 1.0

On Thu, Nov 12, 2026 at 03:16:15PM +0800, Zhu Jun wrote:
> atmel_tcb_pwm_resume() passes the start command as the register address
> and the channel control register offset as the value. The command is
> 0x5, which is not an aligned register address, so regmap rejects the
> write and an enabled PWM channel is not restarted after resume.
>=20
> Pass the channel control register first and the clock-enable and
> software-trigger bits second.
>=20
> Fixes: 061f8572a31c ("pwm: atmel-tcb: Switch to new binding")
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

Thanks
Uwe

--d6zp3rsvlu3kvp7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsAcAgACgkQj4D7WH0S
/k4BwggAiMnDPMxSpZjzXiPJ1MiGu7Of5KGOAOXIUiQgseggdhpkQXB4W5dImuRm
cCBhD8ooc0C/+xbFDtlF0liSsMf5zmKaAXE6MfC6H0S8Zi4eiwSMKc7w13TxrXOP
wIYEeo7hD3IRFmgSwRU1ahr/8zIelyqgQS0jo1Jni04AuSyN+FPuYrX9fPBoWAAC
PtvzIALwAahKhBGs4o7kK1xJ0BXAMTF9DLxnNWfGKoh0asx6PPH7JuMoM0aFgET5
h6m81LR5GhMjiCglHdMEj38Hbpxmqm+KhQqXf+S7DMUlQoTc4BlB/x4XLGMTX1na
ROT6so46f8hJl3iSIZzpmoQMd6QPRA==
=jUVf
-----END PGP SIGNATURE-----

--d6zp3rsvlu3kvp7g--
