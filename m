Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177053;
	b=ar4cPuDElgxlFj5/3j5jSDtSa5gZH74I1atZ/2MtrNQ2hYwCydcexj7Qu5/5MBsOBzJn
	 nOU0BUmyHV6vulhaZJUuXkSqaG3w0DxSw1Vw1KSEaji2p+2pmn6Yyrku5pXcCvVKtcpTS
	 nrhFdL7mxV7EOXio12q2TFhiLgelH4TfZQYu2VP69oD63EI/kiGXZ5mk6ZpzCKLFuH77J
	 KNXm/vWx+zBobqLTo0eSY5pfWN1als9ghIi7iud6ILV5J6/k7I2+LXEm/byPJlsiy43yA
	 wla4im2Y7N+JP8EBXo4Tswv4gyfbBmK7BUED/lRx+a8bkCwAJRvTCXZTXe5+R63pV9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177053;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AxXqgCeXal65+AfazlQec+YPsjLlcdM7scYBIZf41Bo=;
	b=ngT3sFDHYLZoNS70ZSuOg3sVd6ZeI4M5xctmfUw9r4+lMQ5pzL6PHSpsV61DJwfL90gj
	 rWBGDtBszMFy5jqCxl3W6bycUcQcV81OfPzJTjGETnSEKd1BDX6OGdgKFfKIzPd1tIpag
	 9Jz0Z1VxuDEKP7A++31RfDUz5DV4UPo3Grc2h4X1gModwHjfWKSEm7j+oHym9Y/N522Mv
	 NsYa+YyCBOtW090gJ2RZa3Rc8WyZqS0Ka1IUxhTgUXs46wT9CyVdwABhm/0+uHoju+k1z
	 WltbXFJ5NFkLPwJ3e2afrmZOdg9pUVVx1tz2QRM59vZdAWsOWdoF7A6On+gMvT658yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XVBLMlN2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 2A8C1606A320;
	Fri, 20 Nov 2026 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XVBLMlN2
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 80AA01F000C0;
	Fri, 20 Nov 2026 12:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795177052;
	bh=AxXqgCeXal65+AfazlQec+YPsjLlcdM7scYBIZf41Bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XVBLMlN2rDwXEqWI9EpkZOKZOMAka7OKzB/f815QnjXrzl2oTHsRFDq8fkiT6vLaA
	 fgMuNuz3hFQ0LH9A756xzsAmUmCzfaC6trbvjTicc6iiK+AbU1sB8A4vW0utw19goY
	 3nu5fgPlRnvS3N4T6C6Z5V00sbFuPGMME0232q5zxO7v92Ls42JwuDUBDD/lIeUcGe
	 fe+q+Jq2/14m8j/+3b9hPxsuJo2hVxDi/TQ4X4iFbP6s35zFJ1Cv27MuYk8Lfmo8uk
	 mUKM/Y+wEBsrNYcTGv6CXv7UtR4DDMph5LERxOcWkt+3chyvUUgO1lFgH4FHqsEYKT
	 Iyxy4QJXZZfZg==
Date: Fri, 20 Nov 2026 13:17:29 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
	Andrew Bresticker <abrestic@chromium.org>, Binbin Zhou <zhoubinbin@loongson.cn>, 
	David Lechner <dlechner@baylibre.com>, Drew Fustini <dfustini@baylibre.com>, 
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>, Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Grant Erickson <marathon96@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, imx@lists.linux.dev, 
	Joachim Eastwood <manabian@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Juxin Gao <gaojuxin@loongson.cn>, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, 
	linux-tegra@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>, 
	Michael Hennerich <michael.hennerich@analog.com>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Naidu Tellapati <naidu.tellapati@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	NeilBrown <neil@brown.name>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, "Philip, Avinash" <avinashphilip@ti.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sai Masarapu <Sai.Masarapu@imgtec.com>, 
	Sandipan Patra <spatra@nvidia.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>, Shawn Guo <shawn.guo@linaro.org>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Thierry Reding <thierry.reding@kernel.org>, 
	Trevor Gamblin <tgamblin@baylibre.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, 
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Xiubo Li <Li.Xiubo@freescale.com>
Subject: Re: [PATCH 0/8] pwm: Fix various bugs reported by Sashiko
Message-ID: <awA6F830Ve_-vXBg@monoceros>
References: <20261105143847.2559586-1-lee@kernel.org>
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
	protocol="application/pgp-signature"; boundary="ziscyeot6fs5noin"
Content-Disposition: inline
In-Reply-To: <20261105143847.2559586-1-lee@kernel.org>


--ziscyeot6fs5noin
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/8] pwm: Fix various bugs reported by Sashiko
MIME-Version: 1.0

Hello Lee,

On Thu, Nov 05, 2026 at 02:38:02PM +0000, Lee Jones wrote:
> These issues were reported by Sashiko.
>=20
> Lee Jones (8):
>   pwm: tegra: Prevent 32-bit period truncation and division by zero
>   pwm: mxs: Return early when disabling and fix error-path clock leak
>   pwm: loongson: Fix 32-bit control register truncation in
>     pwm_loongson_set_polarity()
>   pwm: axi-pwmgen: Enable clocks before accessing hardware registers in
>     probe()
>   pwm: fsl-ftm: Enable ipg_clk around regcache_sync() during resume
>   pwm: omap-dmtimer: Handle negative error codes from get_pwm_status()
>   pwm: tiehrpwm: Enable runtime PM before registering PWM chip
>   pwm: img: Unregister PWM chip before disabling runtime PM and clocks

I applied patches #3 and #4 to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

, for the others there is feedback to address on your side.

Thanks for your patches, very appreciated!

Best regards
Uwe

--ziscyeot6fs5noin
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsAOlcACgkQj4D7WH0S
/k5nKQf7BqdPQSazSO1K+yijinQelR1WIDWTGkr07M3GrZ3fE2uXEcC13bL2YOiN
7TqrdYEnutbLKMX623WYz1plfEsGkYbCTpey8GFx/i6mTwyzANsfRenSL5oOnQW6
p7GYp7eeYpG4c3qZF4rfTVamKqYs0CVGBlhdot/pHEKmdez+Q8G3Rgd0Iax/z0fg
PIi39hqy53xR/5ZrzTYWSIDPCLZLFk/HpkbjUjBHZfNsrLU/6xf0Drraf+BIYHx4
7NNE6/x7z63mP9ZwwUxkj/Odw+Dm1v37p/Z+Sfs4lq1SWU+bVOsbr37tmNskHg41
GUpO28qdynyg7dNXgTUHdCqNVivLNw==
=w9m6
-----END PGP SIGNATURE-----

--ziscyeot6fs5noin--
