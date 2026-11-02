Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648568;
	b=mnLoG9E7Jgo77TeokjvFxKL58bZjpRtIpmeiM/y1nHIgVIeJSjvUyvzNE62JFlGc40H2
	 ohmXMlzW9udSdgCntMtOTS7akuflaKSPsafJUjmvzmfTEln18ZyVFGT5z0FQgsjs2XZ+a
	 aTo5RIOVfPCnQI6gr0ROcVjouwDWIlJWVgm+hdYQy9JJ12EKV2datctGy5hLtsC+II45i
	 5EG8wIImpzuU2VBPyZA+5BmjyJUqjnBXDbgaM/qeGGsmjnbrH4zZK7cs/aWsGR5LpxlM2
	 DZ8Sqga3VUXTwkey0Oshs6Vp1K+jek58RA2glJSsbJ2e4g+AcxFrPXNOizyJM6DHV6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648568;
	h=Received:DKIM-Signature:Date:From:To:List-Id:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xYM2w+R+s64GsgyYN0vH9vlqjZhy326IFMYWXn8QM+c=;
	b=kUUa4H2oU1CHb+sRFNqK6oyEWQjEngFVn4KP86RH3h4nfhb4UAix/ozCGtr0KU1V/K/o
	 RglCQvMVPuhCd2htC5LCqS8JVnPKHmLIcxzLtODM6EAFen54WzqzGFOZmfMi7a2deM3P2
	 ezaWtBvxVoJGv4hhCGjC1Cq+spVrC9MlR6dY05e7TouIgj2Ry2Dpf7Hr+51N0zUzot6z0
	 OWqOVK3cvr3AWIMK0Wh+lICaYrsqW8TQdN7hS2ZhEtcjiX+RM+Aj0ngwlPH4XzDTA1IsK
	 j8AYYAAKetkW8Fc6b5NVovTiU+69F2S36X6toBgfyo2UWKOHmMql9C58fJPxL0U/ZGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UqGnCmL9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAD9606A327;
	Mon,  2 Nov 2026 19:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UqGnCmL9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642A71F00A16;
	Mon,  2 Nov 2026 19:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793648567;
	bh=xYM2w+R+s64GsgyYN0vH9vlqjZhy326IFMYWXn8QM+c=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To;
	b=UqGnCmL91cb8o0RZa9AlcojqHd3NUoVze7hhFa8SslvzoohKM0vCByoWxY2tq2oSJ
	 GBQ67ti/d4c7M6n/qCanFt6OgwcYM+NdcWM5eXrGKgdaeknPu9pU+e09+e6yrR3mdO
	 mHEeyc4z7p94vZCMydTjR5bh4LZdctFYDKpySRLtsULm5Pf06LmbQcF4bkwCVJoOdI
	 mHj6ycFAWqkwDKa6nB6lnbx8ITyvsRDcAKLBTsyc4NqiN+2puCQBCjkSA/a5NiaKu9
	 LgsE8qcf3vMfZlydP6I7j58hmywN0qWeUQe1mpdE66XxAdD/Bau9Wc/fpYQ1y6nlK3
	 QQHDPQbO+/kxQ==
Date: Mon, 2 Nov 2026 19:42:42 +0000
From: Conor Dooley <conor@kernel.org>
To: "ukleinek@kernel.org" <ukleinek@kernel.org>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	"patchwork-bot+linux-riscv@kernel.org" <patchwork-bot+linux-riscv@kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"emil.renner.berthing@canonical.com" <emil.renner.berthing@canonical.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"pjw@kernel.org" <pjw@kernel.org>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND v22 0/3] Add OpenCores PTC PWM support
Message-ID: <20261102-tidal-quintet-3867b525d891@spud>
References: <20260810030714.48100-1-hal.feng@starfivetech.com>
 <179357141185.2624073.8394896290201314670.git-patchwork-notify@kernel.org>
 <NT0PR01MB11026FD52BC4266EFFEACBD5E66A2@NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn>
 <auheO4sRs4P36jgw@monoceros>
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
	protocol="application/pgp-signature"; boundary="CrMnFs07IEUOttHU"
Content-Disposition: inline
In-Reply-To: <auheO4sRs4P36jgw@monoceros>

--CrMnFs07IEUOttHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2026 at 10:57:10AM +0100, ukleinek@kernel.org wrote:
> Hello,
>=20
> On Mon, Nov 02, 2026 at 02:11:46AM +0000, Hal Feng wrote:
> > > On 26.11.2 06:17, patchwork-bot+linux-riscv wrote:
> > > This series was applied to riscv/linux.git (fixes) by Conor Dooley
> > > <conor.dooley@microchip.com>:
> > >=20
> > > On Mon, 10 Aug 2026 11:07:11 +0800 you wrote:
> > > > Add OpenCores PTC PWM driver which is used in StarFive
> > > > JH7100/JH7110/JHB100 SoC.
> > > >
> > > > I will maintain this pwm module in place of William.
> > > >
> > > > Changes since v21:
> > > > - Allow non-zero duty cycles shorter than one clock tick to round d=
own to
> > > >   zero.
> > > > - Drop the .free() callback to preserve the PWM hardware state after
> > > >   pwm_put().
> > > > - Update the comment.
> > > >
> > > > [...]
> > >=20
> > > Here is the summary with links:
> > >   - [RESEND,v22,1/3] dt-bindings: pwm: opencores: Update compatibles,
> > > examples and maintainers
> > >     (no matching commit)
> > >   - [RESEND,v22,2/3] riscv: dts: starfive: Correct pwm nodes
> > >     https://git.kernel.org/riscv/c/2186ec5f59c2
> > >   - [RESEND,v22,3/3] pwm: Add OpenCores PTC PWM driver
> > >     (no matching commit)
> > >=20
> > > You are awesome, thank you!
> > > --
> > > Deet-doot-dot, I am a bot.
> > > https://korg.docs.kernel.org/patchwork/pwbot.html
> >=20
> > Has this patch series been applied? I've sent out the updated v23 patch=
 series, but
> > Krzysztof pointed out the Tested-by tag should not be added in the dt-b=
indings patch.
> > Should I send a v24 to drop the Tested-by tag tag, or should I make the=
 changes on top
> > of v22 if it has already been applied?
>=20
> The way I read it, only patch 2/3 "riscv: dts: starfive: Correct pwm
> nodes" was applied.

Yeah. And the mail is a quirk of me not removing the thread from the
linux-riscv patchwork and pw-bot autoresponding when the series was
"applied" by me to that tree when Paul fast-forwarded it.
There should have been a b4-ty email from me a while ago saying that I
had applied the dts patch.

--CrMnFs07IEUOttHU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaujnsgAKCRB4tDGHoIJi
0vGgAP9gqJ8aLAjZxjxqcBKs8ePNSulSrB7JgAx+3rNCP7DK4AEA7fKaU0A4JXOu
VrSrRZ/T+DWcsS8PHwzW9l9w/VPFPgE=
=n+9e
-----END PGP SIGNATURE-----

--CrMnFs07IEUOttHU--
