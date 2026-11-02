Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613434;
	b=4FqJ4QlLzMoe6YCiEWOmIiWqWa/06DWy3nOF6vRpADWR4WqagEWySM2UFvNXYygm9vg+
	 gHX2kfEkQXycIzX/4MwDTH+20BqtdOele+9ltKtK3xHqMkRMXXoUfQERvmUmADrHGqpGT
	 26rdJOuYeZj2hSNdVpfNUL2ksLrYSPgnCGZTcb5OR2dY+tWEp89xGeDo1mRyomgVysE8f
	 dH90u/EzA2zUGMyZ30kCAYdOd/5G+y8T96DnPAVh8Z3wpw6i/+TmfUdZCsYConAqPkIsd
	 WzY5Fs/MMCgQ5JOkFG9wA9q9B4iVW7FdYow7vzCRdO6+0IMHSrW1+toC39XBkQ1OBGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613434;
	h=Received:DKIM-Signature:Date:From:To:List-Id:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2cQyf8sKC1F7loKuPDRIdjy/GzV9dwagAXHv9zwCcFs=;
	b=iHXNYl+20oYMPEh2+P6DuAOYjXizZUi1lr5bQ0KaDUTOEQ559ouKgsJ6k+45SeltipZ9
	 Bi6W+xl5X23k3Or9smlM3rEPmNtbE0SodOJKfC7WkUEms0wRqjhPPRmyzivvTi4Sixf/8
	 S89PNcGIsRpbCawNlxHwZGdBOuppqglCDcQAPZJTTsWjlXw01LmKdK9CXmGXlOYFfUKNY
	 50MqYpXWtaQHgzRxZRYFcUN8Xav4+eiERcJR/cQEzzCI09NMnOCUzVwaVHUrV6e3I4BSp
	 cK0iflO+6J9txw+6NITA196l4P2pYbSATCb4ZoAHxu4v6LoNPKXtKb32ZT0ktS6SU+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kiff0D1h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 122BB606A326;
	Mon,  2 Nov 2026 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kiff0D1h
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id EC15A1F00919;
	Mon,  2 Nov 2026 09:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793613433;
	bh=2cQyf8sKC1F7loKuPDRIdjy/GzV9dwagAXHv9zwCcFs=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To;
	b=Kiff0D1hzOFg0lPBzARDrDswtvyheTKFPGRY6Dhk1IRrG+fJRs6MIhAgBNie8TxNo
	 qv8Z2dIwsyL8p5KE3l85iESoMFUAhJlhQlQWLtQiv++Un14uePj29XUH/YqwG5y3nw
	 yq4MClM8NBo8OSpPr30z4+ifmZpvWgMR67iDRhk3NWrLlAs2/kh9eups5HmEK02ces
	 TIDTvzqBeBrNGYkz41UlqS/iD6OwK9WcP4KupAZHLmfVLEUDgYpGbtgw6c0O7yCqB+
	 kbxRhViJ7R1uvMokm8gHO5p2SSeaCAoq97d2tuDdOjy/A+Xt18Xl3Ks6QOF2ytMGw+
	 FPEND+fBTxj9w==
Date: Mon, 2 Nov 2026 10:57:10 +0100
From: "ukleinek@kernel.org" <ukleinek@kernel.org>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: "patchwork-bot+linux-riscv@kernel.org" <patchwork-bot+linux-riscv@kernel.org>, 
	"conor@kernel.org" <conor@kernel.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, 
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"emil.renner.berthing@canonical.com" <emil.renner.berthing@canonical.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"pjw@kernel.org" <pjw@kernel.org>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND v22 0/3] Add OpenCores PTC PWM support
Message-ID: <auheO4sRs4P36jgw@monoceros>
References: <20260810030714.48100-1-hal.feng@starfivetech.com>
 <179357141185.2624073.8394896290201314670.git-patchwork-notify@kernel.org>
 <NT0PR01MB11026FD52BC4266EFFEACBD5E66A2@NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn>
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
	protocol="application/pgp-signature"; boundary="g7uwo5ayfmhz32zt"
Content-Disposition: inline
In-Reply-To: <NT0PR01MB11026FD52BC4266EFFEACBD5E66A2@NT0PR01MB1102.CHNPR01.prod.partner.outlook.cn>


--g7uwo5ayfmhz32zt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RESEND v22 0/3] Add OpenCores PTC PWM support
MIME-Version: 1.0

Hello,

On Mon, Nov 02, 2026 at 02:11:46AM +0000, Hal Feng wrote:
> > On 26.11.2 06:17, patchwork-bot+linux-riscv wrote:
> > This series was applied to riscv/linux.git (fixes) by Conor Dooley
> > <conor.dooley@microchip.com>:
> >=20
> > On Mon, 10 Aug 2026 11:07:11 +0800 you wrote:
> > > Add OpenCores PTC PWM driver which is used in StarFive
> > > JH7100/JH7110/JHB100 SoC.
> > >
> > > I will maintain this pwm module in place of William.
> > >
> > > Changes since v21:
> > > - Allow non-zero duty cycles shorter than one clock tick to round dow=
n to
> > >   zero.
> > > - Drop the .free() callback to preserve the PWM hardware state after
> > >   pwm_put().
> > > - Update the comment.
> > >
> > > [...]
> >=20
> > Here is the summary with links:
> >   - [RESEND,v22,1/3] dt-bindings: pwm: opencores: Update compatibles,
> > examples and maintainers
> >     (no matching commit)
> >   - [RESEND,v22,2/3] riscv: dts: starfive: Correct pwm nodes
> >     https://git.kernel.org/riscv/c/2186ec5f59c2
> >   - [RESEND,v22,3/3] pwm: Add OpenCores PTC PWM driver
> >     (no matching commit)
> >=20
> > You are awesome, thank you!
> > --
> > Deet-doot-dot, I am a bot.
> > https://korg.docs.kernel.org/patchwork/pwbot.html
>=20
> Has this patch series been applied? I've sent out the updated v23 patch s=
eries, but
> Krzysztof pointed out the Tested-by tag should not be added in the dt-bin=
dings patch.
> Should I send a v24 to drop the Tested-by tag tag, or should I make the c=
hanges on top
> of v22 if it has already been applied?

The way I read it, only patch 2/3 "riscv: dts: starfive: Correct pwm
nodes" was applied.

Best regards
Uwe

--g7uwo5ayfmhz32zt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmroXnQACgkQj4D7WH0S
/k5t+ggAj8/tZvnqb0XSSo59bIxsRnNZ0QQf80PHn3F4h0SvL1vMUD08nW3IUOmf
n9mHe2fe0MQpH9Ay0uqyPUuMi/f1hyVyB0KtPruGqifQ/x2xknefeArHlRAZvGkR
r0SztUC5fIfUioGJfnynVl9rrIFi2HCfOMCRAnyP1YBvEALhHw/MpCQRbdZd7XKE
5LCVDb3aJBee7nktDXrsMYvbbLYHzAd43pU61W79zMhBQg/0SoiRZAJtmFRq90M6
QOQ43RbQj7cZLZ3xlIjhoXG18tvoJFZhFYqEf7bsAtSagCOe13mH/TKfiKxs3NZv
vj+/Csw3/gObvGnq1adib1xuZMwu6A==
=cSrd
-----END PGP SIGNATURE-----

--g7uwo5ayfmhz32zt--
