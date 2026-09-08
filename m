Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A88D4B0496;
	Tue,  8 Sep 2026 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788861149; cv=none; b=dzWzQGCH609SZChOM+Qx4D34Ix/uV0BU3tEM+HfCcI/lext93TRX18Gtk1Z8q9ELFjO1irzTg8kJ+qGBxnDisGPiSSic0N84leSu+ukihUNawAWIX7pO8wGuejCAcVLhA5okiuqHAoNj+pm7WRxBKMpo0f0YWzHQjC1yI85tg5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788861149; c=relaxed/simple;
	bh=Pdy6RnI0d+rMW/H4Nbmwq+aGpcKCP3ObVwNbVnHaNU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yr+1FOvphFFtd7pIHBSK82pt4/ZxT29TZzOKYje8WpjUgDb+pS2rJ1xtO9wxsiUckODTVbICRG4axss5k0dEmKJecYLS4H916DVu1ndGdVxKrMyA2TTBY/7YuWySMVPEiNosDa/R/EqjCHhSZvAtgKZ11nZlE3foJOQwNOcTCHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tm6zRzmX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tm6zRzmX"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8DC0C1F00A3A;
	Tue,  8 Sep 2026 09:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788861148;
	bh=/lYRpbphz5d0VWM774kHqDgOjW789EXt/riQZS0iTBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tm6zRzmXUseZ+aS9UzB1+ZLcFMe9HmnJ2BjPhrPUR1F6NMyvI5YVVA2YptyDktxRR
	 +j183vcLquwhBFxcEVFDVhTDJSj4OV7ej/FzGuYldqHTk3d5c0/XfKWZcOkoKDqc/0
	 nov4CiEon7xNnP+PwbULARjV8fhMS2ivrjcIJrf15ilKupZHN3OsvMiL2Hqda4lrqi
	 ZrWrnVhFEGhjuy0Uboa7SahsKH7nJpuvzFVtqr0dd/bIOn+wjA3vgSpqI7jjxA80ga
	 dgXBFNlEIDDmp9l5ANf9H6fqTKh8mt+aRkRloFQS4H8KjOFV188Il0g8B9IJTbt4E5
	 yZUVnizXl54hw==
Date: Tue, 8 Sep 2026 11:52:25 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pwm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jitao Shi <jitao.shi@mediatek.com>
Subject: Re: [PATCH] pwm: mtk-disp: Fix period readback
Message-ID: <ap_Zslo-dTKtsvfi@monoceros>
References: <20260827105738.8570-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j2zvo2wdfghwgivo"
Content-Disposition: inline
In-Reply-To: <20260827105738.8570-1-wenst@chromium.org>


--j2zvo2wdfghwgivo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: mtk-disp: Fix period readback
MIME-Version: 1.0

Hello,

On Thu, Aug 27, 2026 at 06:57:36PM +0800, Chen-Yu Tsai wrote:
> The period value stored in the register is the number of clock cycles - 1.
>=20
> Account for the offset when calculating the period in nanoseconds. This
> fixes the discrepancy reported by the pwm core when CONFIG_PWM_DEBUG=3D1:
>=20
>     mediatek-disp-pwm 1100e000.pwm: .apply is not idempotent
>     	(ena=3D1 pol=3D0 281500/499875) -> (ena=3D1 pol=3D0 281500/499750)
>=20
> Calculation discrepancy in the driver was found by AI run by a colleague
> while debugging another PWM related issue. Check against SoC datasheet
> and fix done by the author.
>=20
> Fixes: 3f2b16734914 ("pwm: mtk-disp: Implement atomic API .get_state()")
> Cc: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Applied with the R-b tags by AngeloGioacchino Del Regno and Fei Shao and

diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index 68a4512e821a..56d10cde5b46 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -210,7 +210,7 @@ static int mtk_disp_pwm_get_state(struct pwm_chip *chip,
 	period =3D FIELD_GET(PWM_PERIOD_MASK, con1);
 	/*
 	 * period has 12 bits, clk_div 11 and NSEC_PER_SEC has 30,
-	 * so period * (clk_div + 1) * NSEC_PER_SEC doesn't overflow.
+	 * so (period + 1) * (clk_div + 1) * NSEC_PER_SEC doesn't overflow.
 	 */
 	state->period =3D DIV64_U64_ROUND_UP((period + 1) * (clk_div + 1) * NSEC_=
PER_SEC, rate);
 	high_width =3D FIELD_GET(PWM_HIGH_WIDTH_MASK, con1);

squashed in to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

=2E

Thanks
Uwe

--j2zvo2wdfghwgivo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqf2tcACgkQj4D7WH0S
/k7N2wgAihLhQXDL9Cax4wf5Ty8D6JUSMvcK81wXU2CWnzA7RzNxyg4Xrm7sHdTk
V2DWl3w7pJaos4ItmlGALGe6cAZAbeHJIvw3Y7BhWJM88gZqm3ceM9nL2d3pT0Iz
GC2O6pTdoj1VoAqcpgS1JrVn4aqdzkRU52+AH1O3GoqggwBZ9IIzlrmQcLHfqncm
YQb9Mfgf6E9VpTusJxQJetR6Q88nzzGSVsc92jr+V5Cf7uZrSQPFupYAz8hL1eI9
2FaEB0XW8TU3a/pgHN8YEJJ2ICXLzJQGkhLTMQ562RvLKD+aEZrou/65q7SUtjcR
UL1sWd9q3hJZGetdK3ZnCJmpZLebzg==
=oDez
-----END PGP SIGNATURE-----

--j2zvo2wdfghwgivo--
